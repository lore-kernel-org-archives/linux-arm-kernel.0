From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Apr 2018 12:30:50 +0800
Subject: [PATCH 1/2] parisc: use the asm-generic version for writeX()
In-Reply-To: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
Message-ID: <201804171208.1138HEgL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hp-parisc/for-next]
[also build test ERROR on v4.17-rc1 next-20180416]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/parisc-use-the-asm-generic-version-for-writeX/20180417-103119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/hardirq.h:13:0,
                    from include/linux/hardirq.h:9,
                    from arch/parisc/kernel/asm-offsets.c:34:
   include/linux/irq.h: In function 'irq_reg_writel':
>> include/linux/irq.h:1126:3: error: implicit declaration of function 'writel'; did you mean 'iowrite8'? [-Werror=implicit-function-declaration]
      writel(val, gc->reg_base + reg_offset);
      ^~~~~~
      iowrite8
   cc1: some warnings being treated as errors
   make[2]: *** [arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +1126 include/linux/irq.h

7d828062 Thomas Gleixner 2011-04-03  1109  
ebf9ff75 Boris Brezillon 2016-09-13  1110  /*
ebf9ff75 Boris Brezillon 2016-09-13  1111   * The irqsave variants are for usage in non interrupt code. Do not use
ebf9ff75 Boris Brezillon 2016-09-13  1112   * them in irq_chip callbacks. Use irq_gc_lock() instead.
ebf9ff75 Boris Brezillon 2016-09-13  1113   */
ebf9ff75 Boris Brezillon 2016-09-13  1114  #define irq_gc_lock_irqsave(gc, flags)	\
ebf9ff75 Boris Brezillon 2016-09-13  1115  	raw_spin_lock_irqsave(&(gc)->lock, flags)
ebf9ff75 Boris Brezillon 2016-09-13  1116  
ebf9ff75 Boris Brezillon 2016-09-13  1117  #define irq_gc_unlock_irqrestore(gc, flags)	\
ebf9ff75 Boris Brezillon 2016-09-13  1118  	raw_spin_unlock_irqrestore(&(gc)->lock, flags)
ebf9ff75 Boris Brezillon 2016-09-13  1119  
332fd7c4 Kevin Cernekee  2014-11-06  1120  static inline void irq_reg_writel(struct irq_chip_generic *gc,
332fd7c4 Kevin Cernekee  2014-11-06  1121  				  u32 val, int reg_offset)
332fd7c4 Kevin Cernekee  2014-11-06  1122  {
2b280376 Kevin Cernekee  2014-11-06  1123  	if (gc->reg_writel)
2b280376 Kevin Cernekee  2014-11-06  1124  		gc->reg_writel(val, gc->reg_base + reg_offset);
2b280376 Kevin Cernekee  2014-11-06  1125  	else
332fd7c4 Kevin Cernekee  2014-11-06 @1126  		writel(val, gc->reg_base + reg_offset);
332fd7c4 Kevin Cernekee  2014-11-06  1127  }
332fd7c4 Kevin Cernekee  2014-11-06  1128  

:::::: The code at line 1126 was first introduced by commit
:::::: 332fd7c4fef5f3b166e93decb07fd69eb24f7998 genirq: Generic chip: Change irq_reg_{readl,writel} arguments

:::::: TO: Kevin Cernekee <cernekee@gmail.com>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 14302 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/33b3e95b/attachment-0001.gz>
