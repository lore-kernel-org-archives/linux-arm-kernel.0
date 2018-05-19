From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 May 2018 01:56:25 +0800
Subject: [xlnx:xlnx_rebase_v4.14 74/935] drivers/fpga/zynqmp-fpga.c:79:2:
 error: implicit declaration of function '__flush_cache_user_range'; did you
 mean 'clflush_cache_range'?
Message-ID: <201805200120.xJ9fMtET%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   6b8ad2b85bb2279d13a436396238f0fd150138d1
commit: d91b9e49c2c2663091e2d71a136ad2db919a91b3 [74/935] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout d91b9e49c2c2663091e2d71a136ad2db919a91b3
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_ops_write':
>> drivers/fpga/zynqmp-fpga.c:79:2: error: implicit declaration of function '__flush_cache_user_range'; did you mean 'clflush_cache_range'? [-Werror=implicit-function-declaration]
     __flush_cache_user_range((unsigned long)kbuf,
     ^~~~~~~~~~~~~~~~~~~~~~~~
     clflush_cache_range
   cc1: some warnings being treated as errors

vim +79 drivers/fpga/zynqmp-fpga.c

    45	
    46	static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
    47						const char *buf, size_t size)
    48	{
    49		struct zynqmp_fpga_priv *priv;
    50		char *kbuf;
    51		size_t dma_size;
    52		dma_addr_t dma_addr;
    53		u32 transfer_length;
    54		int ret;
    55		const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
    56	
    57		if (!eemi_ops || !eemi_ops->fpga_load)
    58			return -ENXIO;
    59	
    60		priv = mgr->priv;
    61	
    62		if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
    63			dma_size = size + ENCRYPTED_KEY_LEN + ENCRYPTED_IV_LEN;
    64		else
    65			dma_size = size;
    66	
    67		kbuf = dma_alloc_coherent(priv->dev, dma_size, &dma_addr, GFP_KERNEL);
    68		if (!kbuf)
    69			return -ENOMEM;
    70	
    71		memcpy(kbuf, buf, size);
    72	
    73		if (mgr->flags & IXR_FPGA_ENCRYPTION_EN) {
    74			memcpy(kbuf + size, mgr->key, ENCRYPTED_KEY_LEN);
    75			memcpy(kbuf + size + ENCRYPTED_KEY_LEN, mgr->iv,
    76							ENCRYPTED_IV_LEN);
    77		}
    78	
  > 79		__flush_cache_user_range((unsigned long)kbuf,
    80					 (unsigned long)kbuf + dma_size);
    81	
    82		/**
    83		 * Translate size from bytes to number of 32bit words that
    84		 * the DMA should write to the PCAP interface
    85		 */
    86		if (size & 3)
    87			transfer_length = (size >> 2) + 1;
    88		else
    89			transfer_length = size >> 2;
    90	
    91		ret = eemi_ops->fpga_load(dma_addr, transfer_length, mgr->flags);
    92	
    93		dma_free_coherent(priv->dev, dma_size, kbuf, dma_addr);
    94	
    95		return ret;
    96	}
    97	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61100 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180520/f6735637/attachment-0001.gz>
