From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 May 2018 18:33:32 +0800
Subject: [xlnx:xlnx_rebase_v4.14 730/917] drivers//crypto/zynqmp-sha.c:133:3:
 error: implicit declaration of function '__flush_cache_user_range';
 did you mean 'flush_icache_user_range'?
Message-ID: <201805091829.wnwzjPuw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   a24ae3acb778c948234fa8f227bacd818034055d
commit: 5cccc03f86f27a3e9e76ba7a863eaf2f8506e9e2 [730/917] crypto: zynqmp: Use new firmware ops
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5cccc03f86f27a3e9e76ba7a863eaf2f8506e9e2
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers//crypto/zynqmp-sha.c: In function 'zynqmp_sha_update':
>> drivers//crypto/zynqmp-sha.c:133:3: error: implicit declaration of function '__flush_cache_user_range'; did you mean 'flush_icache_user_range'? [-Werror=implicit-function-declaration]
      __flush_cache_user_range((unsigned long)kbuf,
      ^~~~~~~~~~~~~~~~~~~~~~~~
      flush_icache_user_range
   cc1: some warnings being treated as errors

vim +133 drivers//crypto/zynqmp-sha.c

3abec383 Nava kishore Manne 2017-09-19  111  
3abec383 Nava kishore Manne 2017-09-19  112  static int zynqmp_sha_update(struct ahash_request *req)
3abec383 Nava kishore Manne 2017-09-19  113  {
3abec383 Nava kishore Manne 2017-09-19  114  	struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
3abec383 Nava kishore Manne 2017-09-19  115  	struct zynqmp_sha_dev *dd = tctx->dd;
5cccc03f Rajan Vaja         2018-03-01  116  	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
3abec383 Nava kishore Manne 2017-09-19  117  	char *kbuf;
3abec383 Nava kishore Manne 2017-09-19  118  	size_t dma_size = req->nbytes;
3abec383 Nava kishore Manne 2017-09-19  119  	dma_addr_t dma_addr;
3abec383 Nava kishore Manne 2017-09-19  120  	int ret;
3abec383 Nava kishore Manne 2017-09-19  121  
3abec383 Nava kishore Manne 2017-09-19  122  	if (!req->nbytes)
3abec383 Nava kishore Manne 2017-09-19  123  		return 0;
3abec383 Nava kishore Manne 2017-09-19  124  
5cccc03f Rajan Vaja         2018-03-01  125  	if (!eemi_ops || !eemi_ops->sha_hash)
5cccc03f Rajan Vaja         2018-03-01  126  		return -ENOTSUPP;
5cccc03f Rajan Vaja         2018-03-01  127  
3abec383 Nava kishore Manne 2017-09-19  128  	kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
3abec383 Nava kishore Manne 2017-09-19  129  	if (!kbuf)
3abec383 Nava kishore Manne 2017-09-19  130  		return -ENOMEM;
3abec383 Nava kishore Manne 2017-09-19  131  
3abec383 Nava kishore Manne 2017-09-19  132  	scatterwalk_map_and_copy(kbuf, req->src, 0, req->nbytes, 0);
3abec383 Nava kishore Manne 2017-09-19 @133  	 __flush_cache_user_range((unsigned long)kbuf,
3abec383 Nava kishore Manne 2017-09-19  134  				  (unsigned long)kbuf + dma_size);
5cccc03f Rajan Vaja         2018-03-01  135  	ret = eemi_ops->sha_hash(dma_addr, req->nbytes, ZYNQMP_SHA3_UPDATE);
3abec383 Nava kishore Manne 2017-09-19  136  	dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);
3abec383 Nava kishore Manne 2017-09-19  137  
3abec383 Nava kishore Manne 2017-09-19  138  	return ret;
3abec383 Nava kishore Manne 2017-09-19  139  }
3abec383 Nava kishore Manne 2017-09-19  140  

:::::: The code at line 133 was first introduced by commit
:::::: 3abec3839538ef5fe79c2873360d84cc92b4df25 crypto: zynqmp-sha: Adopted SHA3 support for ZynqMP Soc

:::::: TO: Nava kishore Manne <nava.manne@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49087 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/1c31416f/attachment-0001.gz>
