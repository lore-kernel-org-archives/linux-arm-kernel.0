From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 10 Dec 2016 08:54:06 +0800
Subject: [arm:mcbin 32/52]
 drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c:510:2: warning: this
 'for' clause does not guard...
Message-ID: <201612100803.vEOmvAnF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git mcbin
head:   9c14c9238518271b6f94c9d5a0210ae9154ec27b
commit: 56413dbd2c3aa08a1e3f0cfd66c539227278e7d2 [32/52] net: marvell: add mvpp2x driver
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 56413dbd2c3aa08a1e3f0cfd66c539227278e7d2
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c: In function 'mv_pp2x_bm_pools_init':
>> drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c:510:2: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     for (i = i - 1; i >= 0; i--)
     ^~~
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c:512:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'for'
      return err;
      ^~~~~~

vim +/for +510 drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c

   494		size = MVPP2_BM_POOL_SIZE_MAX;
   495		for (i = 0; i < num_pools; i++) {
   496			bm_pool = &priv->bm_pools[i];
   497			bm_pool->log_id = i;
   498			bm_pool->id = first_pool + i;
   499			bm_pool->external_pool = false;
   500			err = mv_pp2x_bm_pool_create(&pdev->dev, hw, bm_pool, size,
   501						     mv_pp2x_pool_pkt_size_get(bm_pool->log_id));
   502			if (err)
   503				goto err_unroll_pools;
   504		}
   505		priv->num_pools = num_pools;
   506		return 0;
   507	
   508	err_unroll_pools:
   509		dev_err(&pdev->dev, "failed to create BM pool %d, size %d\n", i, size);
 > 510		for (i = i - 1; i >= 0; i--)
   511			mv_pp2x_bm_pool_destroy(&pdev->dev, priv, &priv->bm_pools[i]);
   512			return err;
   513	}
   514	
   515	static int mv_pp2x_bm_init(struct platform_device *pdev, struct mv_pp2x *priv)
   516	{
   517		int i, err;
   518		u8 first_pool = mv_pp2x_first_pool_get(priv);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52668 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161210/058827ab/attachment-0001.gz>
