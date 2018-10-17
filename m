From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Oct 2018 20:31:05 +0800
Subject: [xlnx:master 1769/2087] drivers//fpga/zynqmp-fpga.c:173:2: error:
 implicit declaration of function 'seq_puts'; did you mean 'kset_put'?
Message-ID: <201810172000.rt6nqcnF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Appana,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4d97746570a6e51f834bbf2758a4b4c33308428d
commit: bd1f10f8355edafc243f45ebdc234b4fcc218a33 [1769/2087] fpga: zynqmp-fpga: Add support for pl configuration readback
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bd1f10f8355edafc243f45ebdc234b4fcc218a33
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers//fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_read_cfgreg':
>> drivers//fpga/zynqmp-fpga.c:173:2: error: implicit declaration of function 'seq_puts'; did you mean 'kset_put'? [-Werror=implicit-function-declaration]
     seq_puts(s, "zynqMP FPGA Configuration register contents are\n");
     ^~~~~~~~
     kset_put
>> drivers//fpga/zynqmp-fpga.c:180:3: error: implicit declaration of function 'seq_printf'; did you mean 'dev_printk'? [-Werror=implicit-function-declaration]
      seq_printf(s, "%s --> \t %x \t\r\n", p->reg, val);
      ^~~~~~~~~~
      dev_printk
   drivers//fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_read_cfgdata':
>> drivers//fpga/zynqmp-fpga.c:215:2: error: implicit declaration of function 'seq_write'; did you mean 'vfs_write'? [-Werror=implicit-function-declaration]
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
 > 180			seq_printf(s, "%s --> \t %x \t\r\n", p->reg, val);
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
   191	static int zynqmp_fpga_read_cfgdata(struct fpga_manager *mgr,
   192					    struct seq_file *s)
   193	{
   194		const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
   195		struct zynqmp_fpga_priv *priv;
   196		int ret, data_offset;
   197		unsigned int *buf;
   198		dma_addr_t dma_addr;
   199		size_t size;
   200	
   201		priv = mgr->priv;
   202		size = priv->size + READ_DMA_SIZE + DUMMY_FRAMES_SIZE;
   203	
   204		buf = dma_zalloc_coherent(mgr->dev.parent, size, &dma_addr,
   205					  GFP_KERNEL);
   206		if (!buf)
   207			return -ENOMEM;
   208	
   209		seq_puts(s, "zynqMP FPGA Configuration data contents are\n");
   210		ret = eemi_ops->fpga_read((priv->size + DUMMY_FRAMES_SIZE) / 4,
   211					  dma_addr, readback_type, &data_offset);
   212		if (ret)
   213			goto free_dmabuf;
   214	
 > 215		seq_write(s, &buf[data_offset], priv->size);
   216	
   217	free_dmabuf:
   218		dma_free_coherent(mgr->dev.parent, size, buf, dma_addr);
   219	
   220		return ret;
   221	}
   222	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46863 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/6539252f/attachment-0001.gz>
