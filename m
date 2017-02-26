From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 27 Feb 2017 00:09:56 +0800
Subject: [xlnx:master 265/384] drivers/staging/apf/xlnk.c:1542:2: error:
 implicit declaration of function 'DEFINE_DMA_ATTRS'
Message-ID: <201702270041.thW1iBCV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   1741e191412444e3ab3308b407a9328186c248e4
commit: 712fed3371f3769aa4e25f671d04d688aeb7d387 [265/384] staging: apf: Enable HPC ports on MPSoC for SDSoC
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 712fed3371f3769aa4e25f671d04d688aeb7d387
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/staging/apf/xlnk.c: In function 'xlnk_dmasubmit_ioctl':
   drivers/staging/apf/xlnk.c:1138:33: warning: passing argument 4 of 'get_user_pages' makes pointer from integer without a cast [-Wint-conversion]
                t->sg_list_size, 1, 1,
                                    ^
   In file included from drivers/staging/apf/xlnk.c:25:0:
   include/linux/mm.h:1278:6: note: expected 'struct page **' but argument is of type 'int'
    long get_user_pages(unsigned long start, unsigned long nr_pages,
         ^~~~~~~~~~~~~~
   drivers/staging/apf/xlnk.c:1139:13: warning: passing argument 5 of 'get_user_pages' from incompatible pointer type [-Wincompatible-pointer-types]
                xlnk_page_store, NULL);
                ^~~~~~~~~~~~~~~
   In file included from drivers/staging/apf/xlnk.c:25:0:
   include/linux/mm.h:1278:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
    long get_user_pages(unsigned long start, unsigned long nr_pages,
         ^~~~~~~~~~~~~~
   drivers/staging/apf/xlnk.c:1137:5: error: too many arguments to function 'get_user_pages'
        get_user_pages(first_page * PAGE_SIZE,
        ^~~~~~~~~~~~~~
   In file included from drivers/staging/apf/xlnk.c:25:0:
   include/linux/mm.h:1278:6: note: declared here
    long get_user_pages(unsigned long start, unsigned long nr_pages,
         ^~~~~~~~~~~~~~
   drivers/staging/apf/xlnk.c: In function 'xlnk_memop_ioctl':
>> drivers/staging/apf/xlnk.c:1542:2: error: implicit declaration of function 'DEFINE_DMA_ATTRS' [-Werror=implicit-function-declaration]
     DEFINE_DMA_ATTRS(attrs);
     ^~~~~~~~~~~~~~~~
>> drivers/staging/apf/xlnk.c:1542:19: error: 'attrs' undeclared (first use in this function)
     DEFINE_DMA_ATTRS(attrs);
                      ^~~~~
   drivers/staging/apf/xlnk.c:1542:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/staging/apf/xlnk.c:1588:3: error: implicit declaration of function 'dma_set_attr' [-Werror=implicit-function-declaration]
      dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/DEFINE_DMA_ATTRS +1542 drivers/staging/apf/xlnk.c

  1536		int cacheable;
  1537		void *k_addr;
  1538		enum dma_data_direction dmadir;
  1539		xlnk_intptr_type page_id;
  1540		unsigned int page_offset;
  1541		struct scatterlist sg;
> 1542		DEFINE_DMA_ATTRS(attrs);
  1543	
  1544		status = copy_from_user(&args,
  1545					(void __user *)arg_addr,
  1546					sizeof(union xlnk_args));
  1547	
  1548		if (status) {
  1549			pr_err("Error in copy_from_user.  status = %d\n", status);
  1550			return status;
  1551		}
  1552	
  1553		if (!(args.memop.flags & XLNK_FLAG_MEM_ACQUIRE) &&
  1554		    !(args.memop.flags & XLNK_FLAG_MEM_RELEASE)) {
  1555			pr_err("memop lacks acquire or release flag\n");
  1556			return -EINVAL;
  1557		}
  1558	
  1559		if (args.memop.flags & XLNK_FLAG_MEM_ACQUIRE &&
  1560		    args.memop.flags & XLNK_FLAG_MEM_RELEASE) {
  1561			pr_err("memop has both acquire and release defined\n");
  1562			return -EINVAL;
  1563		}
  1564	
  1565		spin_lock(&xlnk_buf_lock);
  1566		buf_id = xlnk_buf_find_by_user_addr(args.memop.virt_addr,
  1567						    current->pid);
  1568		if (buf_id > 0) {
  1569			cacheable = xlnk_bufcacheable[buf_id];
  1570			k_addr = xlnk_bufpool[buf_id] +
  1571				(args.memop.virt_addr - xlnk_userbuf[buf_id]);
  1572			p_addr = xlnk_phyaddr[buf_id] +
  1573				(args.memop.virt_addr - xlnk_userbuf[buf_id]);
  1574		}
  1575		spin_unlock(&xlnk_buf_lock);
  1576	
  1577		if (buf_id <= 0) {
  1578			pr_err("Error, buffer not found\n");
  1579			return -EINVAL;
  1580		}
  1581	
  1582		dmadir = (enum dma_data_direction)args.memop.dir;
  1583	
  1584		if (args.memop.flags & XLNK_FLAG_COHERENT || !cacheable) {
  1585			pr_err("Skipping flush.  cacheable=%d, flags = %d\n",
  1586			       cacheable,
  1587			       args.memop.flags);
> 1588			dma_set_attr(DMA_ATTR_SKIP_CPU_SYNC, &attrs);
  1589		}
  1590	
  1591		page_id = p_addr >> PAGE_SHIFT;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59786 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/69417ec6/attachment-0001.gz>
