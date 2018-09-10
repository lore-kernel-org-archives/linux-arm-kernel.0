From: lkp@intel.com (kbuild test robot)
Date: Tue, 11 Sep 2018 07:25:30 +0800
Subject: [PATCH 07/11] crypto: caam/qi2 - add DPAA2-CAAM driver
In-Reply-To: <20180910171550.5659-8-horia.geanta@nxp.com>
References: <20180910171550.5659-8-horia.geanta@nxp.com>
Message-ID: <201809110720.EN7DgKRO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Horia,

I love your patch! Perhaps something to improve:

[auto build test WARNING on cryptodev/master]
[also build test WARNING on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Horia-Geant/crypto-caam-add-DPAA2-DPSECI-driver/20180911-055735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/crypto/caam/caamalg_qi2.c: In function 'dpaa2_dpseci_congestion_setup':
>> drivers/crypto/caam/caamalg_qi2.c:2463:31: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     cong_notif_cfg.message_ctx = (u64)priv;
                                  ^
   At top level:
   drivers/crypto/caam/caamalg_qi2.c:288:13: warning: 'split_key_sh_done' defined but not used [-Wunused-function]
    static void split_key_sh_done(void *cbk_ctx, u32 err)
                ^~~~~~~~~~~~~~~~~

vim +2463 drivers/crypto/caam/caamalg_qi2.c

  2430	
  2431	static int dpaa2_dpseci_congestion_setup(struct dpaa2_caam_priv *priv,
  2432						 u16 token)
  2433	{
  2434		struct dpseci_congestion_notification_cfg cong_notif_cfg = { 0 };
  2435		struct device *dev = priv->dev;
  2436		int err;
  2437	
  2438		/*
  2439		 * Congestion group feature supported starting with DPSECI API v5.1
  2440		 * and only when object has been created with this capability.
  2441		 */
  2442		if ((DPSECI_VER(priv->major_ver, priv->minor_ver) < DPSECI_VER(5, 1)) ||
  2443		    !(priv->dpseci_attr.options & DPSECI_OPT_HAS_CG))
  2444			return 0;
  2445	
  2446		priv->cscn_mem = kzalloc(DPAA2_CSCN_SIZE + DPAA2_CSCN_ALIGN,
  2447					 GFP_KERNEL | GFP_DMA);
  2448		if (!priv->cscn_mem)
  2449			return -ENOMEM;
  2450	
  2451		priv->cscn_mem_aligned = PTR_ALIGN(priv->cscn_mem, DPAA2_CSCN_ALIGN);
  2452		priv->cscn_dma = dma_map_single(dev, priv->cscn_mem_aligned,
  2453						DPAA2_CSCN_SIZE, DMA_FROM_DEVICE);
  2454		if (dma_mapping_error(dev, priv->cscn_dma)) {
  2455			dev_err(dev, "Error mapping CSCN memory area\n");
  2456			err = -ENOMEM;
  2457			goto err_dma_map;
  2458		}
  2459	
  2460		cong_notif_cfg.units = DPSECI_CONGESTION_UNIT_BYTES;
  2461		cong_notif_cfg.threshold_entry = DPAA2_SEC_CONG_ENTRY_THRESH;
  2462		cong_notif_cfg.threshold_exit = DPAA2_SEC_CONG_EXIT_THRESH;
> 2463		cong_notif_cfg.message_ctx = (u64)priv;
  2464		cong_notif_cfg.message_iova = priv->cscn_dma;
  2465		cong_notif_cfg.notification_mode = DPSECI_CGN_MODE_WRITE_MEM_ON_ENTER |
  2466						DPSECI_CGN_MODE_WRITE_MEM_ON_EXIT |
  2467						DPSECI_CGN_MODE_COHERENT_WRITE;
  2468	
  2469		err = dpseci_set_congestion_notification(priv->mc_io, 0, token,
  2470							 &cong_notif_cfg);
  2471		if (err) {
  2472			dev_err(dev, "dpseci_set_congestion_notification failed\n");
  2473			goto err_set_cong;
  2474		}
  2475	
  2476		return 0;
  2477	
  2478	err_set_cong:
  2479		dma_unmap_single(dev, priv->cscn_dma, DPAA2_CSCN_SIZE, DMA_FROM_DEVICE);
  2480	err_dma_map:
  2481		kfree(priv->cscn_mem);
  2482	
  2483		return err;
  2484	}
  2485	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65152 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180911/8991fd0b/attachment-0001.gz>
