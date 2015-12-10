From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Dec 2015 22:54:25 +0800
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <2144222.LfzPx9mJ0p@wuerfel>
Message-ID: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on next-20151210]
[cannot apply to v4.4-rc4]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/i2c-allow-building-emev2-without-slave-mode-again/20151210-211642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
config: x86_64-randconfig-r0-12102217 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/realmode.h:5:0,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:12,
                    from arch/x86/include/asm/smp.h:12,
                    from arch/x86/include/asm/mmzone_64.h:10,
                    from arch/x86/include/asm/mmzone.h:4,
                    from include/linux/mmzone.h:856,
                    from include/linux/gfp.h:5,
                    from include/linux/device.h:29,
                    from drivers/i2c/busses/i2c-emev2.c:15:
   drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_irq_handler':
>> arch/x86/include/asm/io.h:53:3: warning: 'value' may be used uninitialized in this function [-Wmaybe-uninitialized]
    { asm volatile("mov" size " %0,%1": :reg (val), \
      ^
   drivers/i2c/busses/i2c-emev2.c:232:13: note: 'value' was declared here
     u8 status, value;
                ^

vim +/value +53 arch/x86/include/asm/io.h

b310f381d include/asm-x86/io.h      venkatesh.pallipadi at intel.com 2008-03-18  37  #define ARCH_HAS_IOREMAP_WC
d838270e2 arch/x86/include/asm/io.h Toshi Kani                    2015-06-04  38  #define ARCH_HAS_IOREMAP_WT
b310f381d include/asm-x86/io.h      venkatesh.pallipadi at intel.com 2008-03-18  39  
1c5b9069e arch/x86/include/asm/io.h Brian Gerst                   2010-02-05  40  #include <linux/string.h>
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  41  #include <linux/compiler.h>
976e8f677 arch/x86/include/asm/io.h Jeremy Fitzhardinge           2009-02-06  42  #include <asm/page.h>
5b7c73e00 arch/x86/include/asm/io.h Mark Salter                   2014-04-07  43  #include <asm/early_ioremap.h>
d6472302f arch/x86/include/asm/io.h Stephen Rothwell              2015-06-02  44  #include <asm/pgtable_types.h>
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  45  
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  46  #define build_mmio_read(name, size, type, reg, barrier) \
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  47  static inline type name(const volatile void __iomem *addr) \
1c5b0eb66 include/asm-x86/io.h      Mikael Pettersson             2008-08-13  48  { type ret; asm volatile("mov" size " %1,%0":reg (ret) \
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  49  :"m" (*(volatile type __force *)addr) barrier); return ret; }
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  50  
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  51  #define build_mmio_write(name, size, type, reg, barrier) \
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  52  static inline void name(type val, volatile void __iomem *addr) \
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27 @53  { asm volatile("mov" size " %0,%1": :reg (val), \
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  54  "m" (*(volatile type __force *)addr) barrier); }
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  55  
1c5b0eb66 include/asm-x86/io.h      Mikael Pettersson             2008-08-13  56  build_mmio_read(readb, "b", unsigned char, "=q", :"memory")
1c5b0eb66 include/asm-x86/io.h      Mikael Pettersson             2008-08-13  57  build_mmio_read(readw, "w", unsigned short, "=r", :"memory")
1c5b0eb66 include/asm-x86/io.h      Mikael Pettersson             2008-08-13  58  build_mmio_read(readl, "l", unsigned int, "=r", :"memory")
c1f64a580 include/asm-x86/io.h      Linus Torvalds                2008-05-27  59  
1c5b0eb66 include/asm-x86/io.h      Mikael Pettersson             2008-08-13  60  build_mmio_read(__readb, "b", unsigned char, "=q", )
1c5b0eb66 include/asm-x86/io.h      Mikael Pettersson             2008-08-13  61  build_mmio_read(__readw, "w", unsigned short, "=r", )

:::::: The code at line 53 was first introduced by commit
:::::: c1f64a58003fd2efaa725a857e269a15f765791a x86: MMIO and gcc re-ordering issue

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22579 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151210/0b651764/attachment-0001.obj>
