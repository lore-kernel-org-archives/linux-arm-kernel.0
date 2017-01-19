From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Jan 2017 22:07:20 +0800
Subject: [PATCH 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig
In-Reply-To: <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
Message-ID: <201701192206.1mDZ9sr0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi afzal,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc4 next-20170119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/afzal-mohammed/ARM-mmu-decouple-VECTORS_BASE-from-Kconfig/20170119-171424
config: arm-stm32_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/afzal-mohammed/ARM-mmu-decouple-VECTORS_BASE-from-Kconfig/20170119-171424 HEAD dd110acc21d40c8f50374de1e500a091d14f29c8 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   arch/arm/mm/init.c: In function 'mem_init':
>> arch/arm/mm/init.c:525:11: error: 'VECTORS_BASEUL' undeclared (first use in this function)
       MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
              ^
   arch/arm/mm/init.c:501:19: note: in definition of macro 'MLK'
    #define MLK(b, t) b, t, ((t) - (b)) >> 10
                      ^
>> include/uapi/linux/const.h:20:18: note: in expansion of macro '__AC'
    #define _AC(X,Y) __AC(X,Y)
                     ^~~~
>> arch/arm/include/asm/memory.h:29:15: note: in expansion of macro '_AC'
    #define UL(x) _AC(x, UL)
                  ^~~
>> include/linux/printk.h:297:36: note: in expansion of macro 'UL'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                       ^~~~~~~~~~~
>> arch/arm/mm/init.c:505:2: note: in expansion of macro 'pr_notice'
     pr_notice("Virtual kernel memory layout:\n"
     ^~~~~~~~~
   arch/arm/mm/init.c:525:11: note: each undeclared identifier is reported only once for each function it appears in
       MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
              ^
   arch/arm/mm/init.c:501:19: note: in definition of macro 'MLK'
    #define MLK(b, t) b, t, ((t) - (b)) >> 10
                      ^
>> include/uapi/linux/const.h:20:18: note: in expansion of macro '__AC'
    #define _AC(X,Y) __AC(X,Y)
                     ^~~~
>> arch/arm/include/asm/memory.h:29:15: note: in expansion of macro '_AC'
    #define UL(x) _AC(x, UL)
                  ^~~
>> include/linux/printk.h:297:36: note: in expansion of macro 'UL'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                       ^~~~~~~~~~~
>> arch/arm/mm/init.c:505:2: note: in expansion of macro 'pr_notice'
     pr_notice("Virtual kernel memory layout:\n"
     ^~~~~~~~~

vim +/VECTORS_BASEUL +525 arch/arm/mm/init.c

   499		mem_init_print_info(NULL);
   500	
   501	#define MLK(b, t) b, t, ((t) - (b)) >> 10
   502	#define MLM(b, t) b, t, ((t) - (b)) >> 20
   503	#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
   504	
 > 505		pr_notice("Virtual kernel memory layout:\n"
   506				"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
   507	#ifdef CONFIG_HAVE_TCM
   508				"    DTCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
   509				"    ITCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
   510	#endif
   511				"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
   512				"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   513				"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   514	#ifdef CONFIG_HIGHMEM
   515				"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   516	#endif
   517	#ifdef CONFIG_MODULES
   518				"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   519	#endif
   520				"      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
   521				"      .init : 0x%p" " - 0x%p" "   (%4td kB)\n"
   522				"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
   523				"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
   524	
 > 525				MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
   526	#ifdef CONFIG_HAVE_TCM
   527				MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
   528				MLK(ITCM_OFFSET, (unsigned long) itcm_end),

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 8634 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/6e0941b0/attachment.gz>
