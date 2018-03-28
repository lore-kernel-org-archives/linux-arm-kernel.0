From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Mar 2018 20:29:30 +0800
Subject: [PATCH 3/7] net: thunderx: add multicast filter management support
In-Reply-To: <20180327150736.10718-4-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-4-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <201803282043.2ylP72wS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vadim,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.16-rc7 next-20180328]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vadim-Lomovtsev/net-thunderx-implement-DMAC-filtering-support/20180328-190332
config: x86_64-randconfig-s1-03281908 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function 'bgx_lmac_save_filter':
>> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:286:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
      return;
      ^~~~~~
   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:281:12: note: declared here
    static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
               ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/cavium/thunder/nic.h:15:0,
                    from drivers/net/ethernet/cavium/thunder/thunder_bgx.c:21:
   drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function 'bgx_set_dmac_cam_filter_mac':
>> drivers/net/ethernet/cavium/thunder/thunder_bgx.h:61:38: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define  RX_DMACX_CAM_LMACID(x)   (x << 49)
                                         ^
>> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:324:8: note: in expansion of macro 'RX_DMACX_CAM_LMACID'
     cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
           ^~~~~~~~~~~~~~~~~~~

vim +/return +286 drivers/net/ethernet/cavium/thunder/thunder_bgx.c

   280	
 > 281	static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
   282	{
   283		u8 i = 0;
   284	
   285		if (!lmac)
 > 286			return;
   287	
   288		/* At the same time we could have several VFs 'attached' to some
   289		 * particular LMAC, and each VF is represented as network interface
   290		 * for kernel. So from user perspective it should be possible to
   291		 * manipulate with its' (VF) receive modes. However from PF
   292		 * driver perspective we need to keep track of filter configurations
   293		 * for different VFs to prevent filter values dupes
   294		 */
   295		for (i = 0; i < lmac->dmacs_cfg; i++) {
   296			if (lmac->dmacs[i].dmac == dmac) {
   297				lmac->dmacs[i].vf_map |= BIT_ULL(vf_id);
   298				return -1;
   299			}
   300		}
   301	
   302		if (!(lmac->dmacs_cfg < lmac->dmacs_count))
   303			return -1;
   304	
   305		/* keep it for further tracking */
   306		lmac->dmacs[lmac->dmacs_cfg].dmac = dmac;
   307		lmac->dmacs[lmac->dmacs_cfg].vf_map = BIT_ULL(vf_id);
   308		lmac->dmacs_cfg++;
   309		return 0;
   310	}
   311	
   312	static int bgx_set_dmac_cam_filter_mac(struct bgx *bgx, int lmacid, u64 cam_dmac, u8 idx)
   313	{
   314		struct lmac *lmac = NULL;
   315		u64 cfg = 0;
   316	
   317		/* skip zero addresses as meaningless */
   318		if (!cam_dmac || !bgx)
   319			return -1;
   320	
   321		lmac = &bgx->lmac[lmacid];
   322	
   323		/* configure DCAM filtering for designated LMAC */
 > 324		cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
   325			RX_DMACX_CAM_EN | cam_dmac;
   326		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM + ((lmacid * lmac->dmacs_count) + idx) * sizeof(u64), cfg);
   327		return 0;
   328	}
   329	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29217 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/78d453af/attachment-0001.gz>
