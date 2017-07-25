From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 25 Jul 2017 10:04:59 +0800
Subject: [xlnx:master 789/812] arch/sh/include/asm/io.h:45:62: note: in
 expansion of macro 'ioswabl'
Message-ID: <201707251054.Rb2dJKxI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   5a5db6231107b7dbf97af0ae9a451d79e9d38203
commit: c66ee9b2e7c09629a109e942e9fa03f1a1c8ea47 [789/812] mtd: nand: arasan_nand: Add 64bit dma support
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c66ee9b2e7c09629a109e942e9fa03f1a1c8ea47
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dma-mapping.h:10,
                    from drivers/mtd//nand/arasan_nand.c:13:
   drivers/mtd//nand/arasan_nand.c: In function 'anfc_rw_buf_dma':
   drivers/mtd//nand/arasan_nand.c:355:16: warning: right shift count >= width of type [-Wshift-count-overflow]
     writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
                   ^
   arch/sh/include/asm/io.h:30:77: note: in definition of macro '__raw_writel'
    #define __raw_writel(v,a) (__chk_io_ptr(a), *(volatile u32 __force *)(a) = (v))
                                                                                ^
>> arch/sh/include/asm/io.h:45:62: note: in expansion of macro 'ioswabl'
    #define writel_relaxed(v,c) ((void)__raw_writel((__force u32)ioswabl(v),c))
                                                                 ^~~~~~~
>> arch/sh/include/asm/io.h:55:32: note: in expansion of macro 'writel_relaxed'
    #define writel(v,a)  ({ wmb(); writel_relaxed((v),(a)); })
                                   ^~~~~~~~~~~~~~
>> drivers/mtd//nand/arasan_nand.c:355:2: note: in expansion of macro 'writel'
     writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
     ^~~~~~
--
   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dma-mapping.h:10,
                    from drivers/mtd/nand/arasan_nand.c:13:
   drivers/mtd/nand/arasan_nand.c: In function 'anfc_rw_buf_dma':
   drivers/mtd/nand/arasan_nand.c:355:16: warning: right shift count >= width of type [-Wshift-count-overflow]
     writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
                   ^
   arch/sh/include/asm/io.h:30:77: note: in definition of macro '__raw_writel'
    #define __raw_writel(v,a) (__chk_io_ptr(a), *(volatile u32 __force *)(a) = (v))
                                                                                ^
>> arch/sh/include/asm/io.h:45:62: note: in expansion of macro 'ioswabl'
    #define writel_relaxed(v,c) ((void)__raw_writel((__force u32)ioswabl(v),c))
                                                                 ^~~~~~~
>> arch/sh/include/asm/io.h:55:32: note: in expansion of macro 'writel_relaxed'
    #define writel(v,a)  ({ wmb(); writel_relaxed((v),(a)); })
                                   ^~~~~~~~~~~~~~
   drivers/mtd/nand/arasan_nand.c:355:2: note: in expansion of macro 'writel'
     writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
     ^~~~~~

vim +/ioswabl +45 arch/sh/include/asm/io.h

b66c1a39 include/asm-sh/io.h      Paul Mundt 2006-01-16  27  
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  28  #define __raw_writeb(v,a)	(__chk_io_ptr(a), *(volatile u8  __force *)(a) = (v))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  29  #define __raw_writew(v,a)	(__chk_io_ptr(a), *(volatile u16 __force *)(a) = (v))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04 @30  #define __raw_writel(v,a)	(__chk_io_ptr(a), *(volatile u32 __force *)(a) = (v))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  31  #define __raw_writeq(v,a)	(__chk_io_ptr(a), *(volatile u64 __force *)(a) = (v))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  32  
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  33  #define __raw_readb(a)		(__chk_io_ptr(a), *(volatile u8  __force *)(a))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  34  #define __raw_readw(a)		(__chk_io_ptr(a), *(volatile u16 __force *)(a))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  35  #define __raw_readl(a)		(__chk_io_ptr(a), *(volatile u32 __force *)(a))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  36  #define __raw_readq(a)		(__chk_io_ptr(a), *(volatile u64 __force *)(a))
14866543 arch/sh/include/asm/io.h Paul Mundt 2008-10-04  37  
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  38  #define readb_relaxed(c)	({ u8  __v = ioswabb(__raw_readb(c)); __v; })
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  39  #define readw_relaxed(c)	({ u16 __v = ioswabw(__raw_readw(c)); __v; })
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  40  #define readl_relaxed(c)	({ u32 __v = ioswabl(__raw_readl(c)); __v; })
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  41  #define readq_relaxed(c)	({ u64 __v = ioswabq(__raw_readq(c)); __v; })
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  42  
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  43  #define writeb_relaxed(v,c)	((void)__raw_writeb((__force  u8)ioswabb(v),c))
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  44  #define writew_relaxed(v,c)	((void)__raw_writew((__force u16)ioswabw(v),c))
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29 @45  #define writel_relaxed(v,c)	((void)__raw_writel((__force u32)ioswabl(v),c))
b7e68d68 arch/sh/include/asm/io.h Paul Mundt 2012-03-29  46  #define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64)ioswabq(v),c))
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  47  
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  48  #define readb(a)		({ u8  r_ = readb_relaxed(a); rmb(); r_; })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  49  #define readw(a)		({ u16 r_ = readw_relaxed(a); rmb(); r_; })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  50  #define readl(a)		({ u32 r_ = readl_relaxed(a); rmb(); r_; })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  51  #define readq(a)		({ u64 r_ = readq_relaxed(a); rmb(); r_; })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  52  
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  53  #define writeb(v,a)		({ wmb(); writeb_relaxed((v),(a)); })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  54  #define writew(v,a)		({ wmb(); writew_relaxed((v),(a)); })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01 @55  #define writel(v,a)		({ wmb(); writel_relaxed((v),(a)); })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  56  #define writeq(v,a)		({ wmb(); writeq_relaxed((v),(a)); })
37b7a978 arch/sh/include/asm/io.h Paul Mundt 2010-11-01  57  

:::::: The code at line 45 was first introduced by commit
:::::: b7e68d6876dfbab087bc3859211a9efc74cbe30c sh: Support I/O space swapping where needed.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42414 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/af91fd10/attachment-0001.gz>
