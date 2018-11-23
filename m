From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Nov 2018 07:41:17 +0800
Subject: [xlnx:xlnx_rebase_v4.14 1052/1439]
 drivers//fpga/zynqmp-fpga.c:173:2: error: implicit declaration of function
 'seq_puts'; did you mean 'set_pte'?
Message-ID: <201811240715.diaKGfzl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   eeab73d1207d6fc2082776c954eb19fd7290bfbe
commit: e3f77c879ff0fe1fd1389f740dcdaa795ae180b7 [1052/1439] fpga: zynqmp-fpga: Add support for pl configuration readback
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e3f77c879ff0fe1fd1389f740dcdaa795ae180b7
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers//fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_read_cfgreg':
>> drivers//fpga/zynqmp-fpga.c:173:2: error: implicit declaration of function 'seq_puts'; did you mean 'set_pte'? [-Werror=implicit-function-declaration]
     seq_puts(s, "zynqMP FPGA Configuration register contents are\n");
     ^~~~~~~~
     set_pte
   drivers//fpga/zynqmp-fpga.c:180:3: error: implicit declaration of function 'seq_printf'; did you mean 'dev_printk'? [-Werror=implicit-function-declaration]
      seq_printf(s, "%s --> \t %x \t\r\n", p->reg, val);
      ^~~~~~~~~~
      dev_printk
   drivers//fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_read_cfgdata':
   drivers//fpga/zynqmp-fpga.c:215:2: error: implicit declaration of function 'seq_write'; did you mean 'vfs_write'? [-Werror=implicit-function-declaration]
     seq_write(s, &buf[data_offset], priv->size);
     ^~~~~~~~~
     vfs_write
   cc1: some warnings being treated as errors

vim +173 drivers//fpga/zynqmp-fpga.c

   158	
   159	static int zynqmp_fpga_read_cfgreg(struct fpga_manager *mgr,
   160					   struct seq_file *s)
   161	{
   162		const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
   163		int ret, val;
   164		unsigned int *buf;
   165		dma_addr_t dma_addr;
   166		struct zynqmp_configreg *p = cfgreg;
   167	
   168		buf = dma_zalloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
   169					  &dma_addr, GFP_KERNEL);
   170		if (!buf)
   171			return -ENOMEM;
   172	
 > 173		seq_puts(s, "zynqMP FPGA Configuration register contents are\n");
   174	
   175		while (p->reg) {
   176			ret = eemi_ops->fpga_read(p->offset, dma_addr, readback_type,
   177						  &val);
   178			if (ret)
   179				goto free_dmabuf;
   180			seq_printf(s, "%s --> \t %x \t\r\n", p->reg, val);
   181			p++;
   182		}
   183	
   184	free_dmabuf:
   185		dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf,
   186				  dma_addr);
   187	
   188		return ret;
   189	}
   190	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49111 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181124/42eb62d0/attachment-0001.gz>
