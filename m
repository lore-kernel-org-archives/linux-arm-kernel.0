From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Oct 2018 05:11:35 +0800
Subject: [xlnx:master 1904/2013]
 drivers/staging/xroeframer/sysfs_xroe.c:34:23: note: in expansion of macro
 'CFG_MAJOR_REVISION_MASK'
Message-ID: <201810100532.JCrK7Giq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7ea1af329aee531681b87b1fba5496337bff680f
commit: 937dd07a40b54e8c8a371682ad0abe7a323216a0 [1904/2013] staging: xroeframer: main sysfs source file commit
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 937dd07a40b54e8c8a371682ad0abe7a323216a0
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/xroeframer/xroe_framer.h:7:0,
                    from drivers/staging/xroeframer/sysfs_xroe.c:13:
   drivers/staging/xroeframer/sysfs_xroe.c: In function 'version_show':
>> drivers/staging/xroeframer/roe_framer_ctrl.h:26:33: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define CFG_MAJOR_REVISION_MASK 0x4278190080 /* 4278190080 */
                                    ^
>> drivers/staging/xroeframer/sysfs_xroe.c:34:23: note: in expansion of macro 'CFG_MAJOR_REVISION_MASK'
     unsigned long mask = CFG_MAJOR_REVISION_MASK;
                          ^~~~~~~~~~~~~~~~~~~~~~~

vim +/CFG_MAJOR_REVISION_MASK +34 drivers/staging/xroeframer/sysfs_xroe.c

  > 13	#include "xroe_framer.h"
    14	
    15	enum { XROE_SIZE_MAX = 15 };
    16	static int xroe_size;
    17	static char xroe_tmp[XROE_SIZE_MAX];
    18	
    19	/**
    20	 * version_show - Returns the block's revision number
    21	 * @kobj:	The kernel object of the entry
    22	 * @attr:	The attributes of the kernel object
    23	 * @buff:	The buffer containing the revision string
    24	 *
    25	 * Returns the block's major, minor & version revision numbers
    26	 * in a %d.%d.%d format
    27	 *
    28	 * Return: XROE_SIZE_MAX on success
    29	 */
    30	static ssize_t version_show(struct kobject *kobj, struct kobj_attribute *attr,
    31				    char *buff)
    32	{
    33		u32 offset = CFG_MAJOR_REVISION_OFFSET;
  > 34		unsigned long mask = CFG_MAJOR_REVISION_MASK;
    35		u32 buffer = 0;
    36		u32 major_rev = 0, minor_rev = 0, version_rev = 0;
    37		void __iomem *working_address = ((u8 *)lp->base_addr +
    38		CFG_MAJOR_REVISION_ADDR);
    39	
    40		buffer = ioread32(working_address);
    41		major_rev = (buffer & mask) >> offset;
    42	
    43		offset = CFG_MINOR_REVISION_OFFSET;
    44		mask = CFG_MINOR_REVISION_MASK;
    45		working_address = ((u8 *)lp->base_addr + CFG_MINOR_REVISION_ADDR);
    46	
    47		buffer = ioread32(working_address);
    48		minor_rev = (buffer & mask) >> offset;
    49	
    50		offset = CFG_VERSION_REVISION_OFFSET;
    51		mask = CFG_VERSION_REVISION_MASK;
    52		working_address = ((u8 *)lp->base_addr + CFG_VERSION_REVISION_ADDR);
    53	
    54		buffer = ioread32(working_address);
    55		version_rev = (buffer & mask) >> offset;
    56	
    57		sprintf(buff, "%d.%d.%d\n", major_rev, minor_rev, version_rev);
    58		return XROE_SIZE_MAX;
    59	}
    60	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62155 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/b9ad7c88/attachment-0001.gz>
