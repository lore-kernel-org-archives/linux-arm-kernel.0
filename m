From: lkp@intel.com (kbuild test robot)
Date: Sun, 3 Dec 2017 17:38:28 +0800
Subject: [PATCH net-next v4 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <1512090230-27594-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1512090230-27594-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <201712031754.PoaKyXZI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/dt-bindings-net-add-DT-bindings-for-Socionext-UniPhier-AVE/20171203-095248
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/smp.h:21:0,
                    from include/linux/smp.h:64,
                    from include/linux/percpu.h:7,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/net.h:27,
                    from include/linux/skbuff.h:29,
                    from include/linux/if_ether.h:23,
                    from include/linux/etherdevice.h:25,
                    from drivers/net/ethernet/socionext/sni_ave.c:19:
   drivers/net/ethernet/socionext/sni_ave.c: In function 'ave_pfsel_set_promisc':
   arch/ia64/include/asm/io.h:396:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define writel(v,a) __writel((v), (a))
                                 ^
>> drivers/net/ethernet/socionext/sni_ave.c:1046:2: note: in expansion of macro 'writel'
     writel(AVE_PFMBYTE_MASK0, priv->base + AVE_PFMBYTE(entry));
     ^~~~~~

vim +/writel +1046 drivers/net/ethernet/socionext/sni_ave.c

  1034	
  1035	static void ave_pfsel_set_promisc(struct net_device *ndev,
  1036					  unsigned int entry, u32 rxring)
  1037	{
  1038		struct ave_private *priv = netdev_priv(ndev);
  1039	
  1040		if (WARN_ON(entry > AVE_PF_SIZE))
  1041			return;
  1042	
  1043		ave_pfsel_stop(ndev, entry);
  1044	
  1045		/* set byte mask */
> 1046		writel(AVE_PFMBYTE_MASK0, priv->base + AVE_PFMBYTE(entry));
  1047		writel(AVE_PFMBYTE_MASK1, priv->base + AVE_PFMBYTE(entry) + 4);
  1048	
  1049		/* set bit mask filter */
  1050		writel(AVE_PFMBIT_MASK, priv->base + AVE_PFMBIT(entry));
  1051	
  1052		/* set selector to rxring */
  1053		writel(rxring, priv->base + AVE_PFSEL(entry));
  1054	
  1055		ave_pfsel_start(ndev, entry);
  1056	}
  1057	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52905 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171203/ff5e2b51/attachment-0001.gz>
