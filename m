From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 27 Oct 2017 23:38:16 +0800
Subject: [xlnx:master 1035/1076] drivers//crypto/zynqmp-sha.c:125:3: error:
 implicit declaration of function '__flush_cache_user_range'
Message-ID: <201710272314.N4potkVB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nava,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   a5aa440aa346ae898994f288dc67396485ac61f2
commit: 6aa92efb058fe13225b5ee06e2d6ca5f221e505f [1035/1076] crypto: zynqmp-sha: Adopted SHA3 support for ZynqMP Soc
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6aa92efb058fe13225b5ee06e2d6ca5f221e505f
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   drivers//crypto/zynqmp-sha.c: In function 'zynqmp_sha_update':
>> drivers//crypto/zynqmp-sha.c:125:3: error: implicit declaration of function '__flush_cache_user_range' [-Werror=implicit-function-declaration]
      __flush_cache_user_range((unsigned long)kbuf,
      ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__flush_cache_user_range +125 drivers//crypto/zynqmp-sha.c

   107	
   108	static int zynqmp_sha_update(struct ahash_request *req)
   109	{
   110		struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
   111		struct zynqmp_sha_dev *dd = tctx->dd;
   112		char *kbuf;
   113		size_t dma_size = req->nbytes;
   114		dma_addr_t dma_addr;
   115		int ret;
   116	
   117		if (!req->nbytes)
   118			return 0;
   119	
   120		kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
   121		if (!kbuf)
   122			return -ENOMEM;
   123	
   124		scatterwalk_map_and_copy(kbuf, req->src, 0, req->nbytes, 0);
 > 125		 __flush_cache_user_range((unsigned long)kbuf,
   126					  (unsigned long)kbuf + dma_size);
   127		ret = zynqmp_pm_sha_hash(dma_addr, req->nbytes, ZYNQMP_SHA3_UPDATE);
   128		dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);
   129	
   130		return ret;
   131	}
   132	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42482 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171027/265103c5/attachment-0001.gz>
