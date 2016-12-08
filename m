From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Dec 2016 05:49:03 +0800
Subject: [PATCH v2 4/4] ARM: treewide: Replace uses of virt_to_phys with
 __pa_symbol
In-Reply-To: <20161208185933.13749-5-f.fainelli@gmail.com>
Message-ID: <201612090545.mM8wL2jp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc8]
[cannot apply to arm-soc/for-next next-20161208]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/ARM-Add-support-for-CONFIG_DEBUG_VIRTUAL/20161209-032753
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   arch/arm/mach-realview/platsmp-dt.c: In function 'realview_smp_prepare_cpus':
>> arch/arm/mach-realview/platsmp-dt.c:79:50: error: expected ')' before ';' token
           __pa_symbol((versatile_secondary_startup));)
                                                     ^
>> arch/arm/mach-realview/platsmp-dt.c:80:1: error: expected ';' before '}' token
    }
    ^
--
   In file included from arch/arm/include/asm/delay.h:9:0,
                    from include/linux/delay.h:14,
                    from arch/arm/mach-zx/platsmp.c:10:
   arch/arm/mach-zx/platsmp.c: In function 'zx_smp_prepare_cpus':
>> arch/arm/mach-zx/platsmp.c:97:62: error: expected ')' before ';' token
     zx_secondary_startup_pa = __pa_symbol((zx_secondary_startup);)
                                                                 ^
   arch/arm/include/asm/memory.h:264:56: note: in definition of macro '__pa_symbol_nodebug'
    #define __pa_symbol_nodebug(x) __virt_to_phys_nodebug((x))
                                                           ^
   arch/arm/include/asm/memory.h:296:25: note: in expansion of macro '__phys_addr_symbol'
    #define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
                            ^~~~~~~~~~~~~~~~~~
>> arch/arm/include/asm/memory.h:296:44: note: in expansion of macro 'RELOC_HIDE'
    #define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
                                               ^~~~~~~~~~
>> arch/arm/mach-zx/platsmp.c:97:28: note: in expansion of macro '__pa_symbol'
     zx_secondary_startup_pa = __pa_symbol((zx_secondary_startup);)
                               ^~~~~~~~~~~
>> arch/arm/mach-zx/platsmp.c:97:62: error: expected ')' before ';' token
     zx_secondary_startup_pa = __pa_symbol((zx_secondary_startup);)
                                                                 ^
   arch/arm/include/asm/memory.h:264:56: note: in definition of macro '__pa_symbol_nodebug'
    #define __pa_symbol_nodebug(x) __virt_to_phys_nodebug((x))
                                                           ^
   arch/arm/include/asm/memory.h:296:25: note: in expansion of macro '__phys_addr_symbol'
    #define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
                            ^~~~~~~~~~~~~~~~~~
>> arch/arm/include/asm/memory.h:296:44: note: in expansion of macro 'RELOC_HIDE'
    #define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
                                               ^~~~~~~~~~
>> arch/arm/mach-zx/platsmp.c:97:28: note: in expansion of macro '__pa_symbol'
     zx_secondary_startup_pa = __pa_symbol((zx_secondary_startup);)
                               ^~~~~~~~~~~
   In file included from arch/arm/mach-zx/platsmp.c:21:0:
>> arch/arm/include/asm/fncpy.h:71:39: error: expected expression before '{' token
    #define fncpy(dest_buf, funcp, size) ({     \
                                          ^
>> arch/arm/mach-zx/platsmp.c:98:2: note: in expansion of macro 'fncpy'
     fncpy(sys_iram, &zx_resume_jump, zx_suspend_iram_sz);
     ^~~~~
   In file included from arch/arm/include/asm/delay.h:9:0,
                    from include/linux/delay.h:14,
                    from arch/arm/mach-zx/platsmp.c:10:
>> arch/arm/include/asm/memory.h:264:32: error: called object is not a function or function pointer
    #define __pa_symbol_nodebug(x) __virt_to_phys_nodebug((x))
                                   ^
   arch/arm/include/asm/memory.h:271:31: note: in expansion of macro '__pa_symbol_nodebug'
    #define __phys_addr_symbol(x) __pa_symbol_nodebug(x)
                                  ^~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/memory.h:296:25: note: in expansion of macro '__phys_addr_symbol'
    #define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
                            ^~~~~~~~~~~~~~~~~~
>> arch/arm/mach-zx/platsmp.c:97:28: note: in expansion of macro '__pa_symbol'
     zx_secondary_startup_pa = __pa_symbol((zx_secondary_startup);)
                               ^~~~~~~~~~~

vim +79 arch/arm/mach-realview/platsmp-dt.c

    73		if (IS_ERR(map)) {
    74			pr_err("PLATSMP: No syscon regmap\n");
    75			return;
    76		}
    77		/* Put the boot address in this magic register */
    78		regmap_write(map, REALVIEW_SYS_FLAGSSET_OFFSET,
  > 79			     __pa_symbol((versatile_secondary_startup));)
  > 80	}
    81	
    82	static const struct smp_operations realview_dt_smp_ops __initconst = {
    83		.smp_prepare_cpus	= realview_smp_prepare_cpus,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59402 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161209/ae6a2497/attachment-0001.gz>
