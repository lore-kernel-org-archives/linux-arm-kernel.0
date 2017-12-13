From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 13 Dec 2017 23:41:22 -0000
Subject: [xlnx:master 5502/6640] drivers//fpga/zynqmp-fpga.c:60:2: error:
 implicit declaration of function '__flush_cache_user_range'; did you mean
 'flush_cache_range'?
Message-ID: <201607261804.blPo9EtG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   9c2e29b2c81dbb1efb7ee4944b18e12226b97513
commit: 280ca3f99087c428f2627bdeada12224596e0784 [5502/6640] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 280ca3f99087c428f2627bdeada12224596e0784
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers//fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_ops_write':
>> drivers//fpga/zynqmp-fpga.c:60:2: error: implicit declaration of function '__flush_cache_user_range'; did you mean 'flush_cache_range'? [-Werror=implicit-function-declaration]
     __flush_cache_user_range(kbuf, kbuf + size);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     flush_cache_range
   cc1: some warnings being treated as errors

vim +60 drivers//fpga/zynqmp-fpga.c

    43	
    44	static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
    45						const char *buf, size_t size)
    46	{
    47		struct zynqmp_fpga_priv *priv;
    48		char *kbuf;
    49		dma_addr_t dma_addr;
    50		u32 transfer_length;
    51		int ret;
    52	
    53		priv = mgr->priv;
    54	
    55		kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
    56		if (!kbuf)
    57			return -ENOMEM;
    58	
    59		memcpy(kbuf, buf, size);
  > 60		__flush_cache_user_range(kbuf, kbuf + size);
    61	
    62		/**
    63		 * Translate size from bytes to number of 32bit words that
    64		 * the DMA should write to the PCAP interface
    65		 */
    66		if (size & 3)
    67			transfer_length = (size >> 2) + 1;
    68		else
    69			transfer_length = size >> 2;
    70	
    71		ret = zynqmp_pm_fpga_load(dma_addr, transfer_length, priv->flags);
    72	
    73		dma_free_coherent(priv->dev, size, kbuf, dma_addr);
    74	
    75		return ret;
    76	}
    77	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39364 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/6581be1c/attachment.gz>
