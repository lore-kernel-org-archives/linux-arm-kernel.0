From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 2 Mar 2017 02:02:49 +0800
Subject: [xlnx:master 385/410] drivers/staging/apf/xilinx-dma-apf.c:960:10:
 warning: 'attrs' may be used uninitialized in this function
Message-ID: <201703020245.em3JvKLy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   1aacedaf5318e8ae39cc02916647495c1c2992ab
commit: d41696969cb3eb5be69777c0a8cf2a5cc8dae03b [385/410] staging: apf: Updating apf driver for 4.9 kernel version
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d41696969cb3eb5be69777c0a8cf2a5cc8dae03b
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/staging/apf/xilinx-dma-apf.c: In function 'xdma_wait':
>> drivers/staging/apf/xilinx-dma-apf.c:960:10: warning: 'attrs' may be used uninitialized in this function [-Wmaybe-uninitialized]
       attrs |= DMA_ATTR_SKIP_CPU_SYNC;
              
--
   drivers/staging/apf/xlnk.c: In function 'xlnk_memop_ioctl.constprop':
>> drivers/staging/apf/xlnk.c:1595:44: warning: 'cacheable' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (args.memop.flags & XLNK_FLAG_COHERENT || !cacheable) {
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
>> drivers/staging/apf/xlnk.c:1663:4: warning: 'cp' may be used uninitialized in this function [-Wmaybe-uninitialized]
       dma_buf_detach(cp->dbuf, cp->dbuf_attach);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/attrs +960 drivers/staging/apf/xilinx-dma-apf.c

   944				*operating_flags |= XDMA_FLAGS_WAIT_COMPLETE;
   945			} else {
   946				wait_for_completion(&dmahead->cmp);
   947				*operating_flags |= XDMA_FLAGS_WAIT_COMPLETE;
   948			}
   949		}
   950	
   951		if (dmahead->dmabuf) {
   952			dma_buf_unmap_attachment(dmahead->dmabuf->dbuf_attach,
   953						 dmahead->dmabuf->dbuf_sg_table,
   954						 dmahead->dmabuf->dma_direction);
   955			kfree(dmahead->dmabuf->sg_list);
   956			dma_buf_detach(dmahead->dmabuf->dbuf,
   957				       dmahead->dmabuf->dbuf_attach);
   958		} else {
   959			if (!(user_flags & CF_FLAG_CACHE_FLUSH_INVALIDATE))
 > 960				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
   961	
   962			get_dma_ops(chan->dev)->unmap_sg(chan->dev,
   963							 dmahead->sglist,
   964							 dmahead->sgcnt,
   965							 dmahead->dmadir,
   966							 attrs);
   967			if (!(user_flags & CF_FLAG_PHYSICALLY_CONTIGUOUS))
   968				unpin_user_pages(dmahead->sglist, dmahead->sgcnt);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59774 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/b313f5ec/attachment-0001.gz>
