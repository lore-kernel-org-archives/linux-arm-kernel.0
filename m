From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 May 2016 18:27:33 +0800
Subject: [patch V3] lib: GCD: add binary GCD algorithm
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
Message-ID: <201605201833.ecqQBWwU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on v4.6-rc5]
[cannot apply to next-20160519]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zengzhaoxiu-163-com/lib-GCD-add-binary-GCD-algorithm/20160428-195527
config: mips-jz4740 (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

Note: the linux-review/zengzhaoxiu-163-com/lib-GCD-add-binary-GCD-algorithm/20160428-195527 HEAD 35e1a24e8fc3a5308b053ed3c744f02ec2a76820 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/bitops.h:21:0,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/mips/include/asm/bug.h:41,
                    from include/linux/bug.h:4,
                    from include/linux/page-flags.h:9,
                    from kernel/bounds.c:9:
   arch/mips/include/asm/cpu-features.h:205:28: warning: "cpu_data" is not defined [-Wundef]
    # define cpu_has_mips32r6 (cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
                               ^
   arch/mips/include/asm/cpu-features.h:241:5: note: in expansion of macro 'cpu_has_mips32r6'
        cpu_has_mips32r6 | cpu_has_mips64r1 | \
        ^
   arch/mips/include/asm/cpu-features.h:289:25: note: in expansion of macro 'cpu_has_mips_r'
    #define cpu_has_clo_clz cpu_has_mips_r
                            ^
   arch/mips/include/asm/cpu-features.h:291:6: note: in expansion of macro 'cpu_has_clo_clz'
    #if !cpu_has_clo_clz
         ^
>> arch/mips/include/asm/cpu-features.h:205:36: error: token "[" is not valid in preprocessor expressions
    # define cpu_has_mips32r6 (cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
                                       ^
   arch/mips/include/asm/cpu-features.h:241:5: note: in expansion of macro 'cpu_has_mips32r6'
        cpu_has_mips32r6 | cpu_has_mips64r1 | \
        ^
   arch/mips/include/asm/cpu-features.h:289:25: note: in expansion of macro 'cpu_has_mips_r'
    #define cpu_has_clo_clz cpu_has_mips_r
                            ^
   arch/mips/include/asm/cpu-features.h:291:6: note: in expansion of macro 'cpu_has_clo_clz'
    #if !cpu_has_clo_clz
         ^
   make[2]: *** [kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +205 arch/mips/include/asm/cpu-features.h

0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  199  # define cpu_has_mips32r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R1)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  200  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  201  #ifndef cpu_has_mips32r2
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  202  # define cpu_has_mips32r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R2)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  203  #endif
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  204  #ifndef cpu_has_mips32r6
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13 @205  # define cpu_has_mips32r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  206  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  207  #ifndef cpu_has_mips64r1
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  208  # define cpu_has_mips64r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R1)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  209  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  210  #ifndef cpu_has_mips64r2
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  211  # define cpu_has_mips64r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R2)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  212  #endif
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  213  #ifndef cpu_has_mips64r6
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  214  # define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  215  #endif
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  216  
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  217  /*
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  218   * Shortcuts ...
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  219   */
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  220  #define cpu_has_mips_2_3_4_5	(cpu_has_mips_2 | cpu_has_mips_3_4_5)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  221  #define cpu_has_mips_3_4_5	(cpu_has_mips_3 | cpu_has_mips_4_5)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  222  #define cpu_has_mips_4_5	(cpu_has_mips_4 | cpu_has_mips_5)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  223  
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  224  #define cpu_has_mips_2_3_4_5_r	(cpu_has_mips_2 | cpu_has_mips_3_4_5_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  225  #define cpu_has_mips_3_4_5_r	(cpu_has_mips_3 | cpu_has_mips_4_5_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  226  #define cpu_has_mips_4_5_r	(cpu_has_mips_4 | cpu_has_mips_5_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  227  #define cpu_has_mips_5_r	(cpu_has_mips_5 | cpu_has_mips_r)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  228  
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  229  #define cpu_has_mips_3_4_5_64_r2_r6					\
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  230  				(cpu_has_mips_3 | cpu_has_mips_4_5_64_r2_r6)
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  231  #define cpu_has_mips_4_5_64_r2_r6					\
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  232  				(cpu_has_mips_4_5 | cpu_has_mips64r1 |	\
2d83fea7 arch/mips/include/asm/cpu-features.h Maciej W. Rozycki 2015-04-03  233  				 cpu_has_mips_r2 | cpu_has_mips_r6)
08a07904 arch/mips/include/asm/cpu-features.h Ralf Baechle      2014-04-19  234  
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  235  #define cpu_has_mips32	(cpu_has_mips32r1 | cpu_has_mips32r2 | cpu_has_mips32r6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  236  #define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2 | cpu_has_mips64r6)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  237  #define cpu_has_mips_r1 (cpu_has_mips32r1 | cpu_has_mips64r1)
0401572a include/asm-mips/cpu-features.h      Ralf Baechle      2005-12-09  238  #define cpu_has_mips_r2 (cpu_has_mips32r2 | cpu_has_mips64r2)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  239  #define cpu_has_mips_r6	(cpu_has_mips32r6 | cpu_has_mips64r6)
c46b302b arch/mips/include/asm/cpu-features.h Ralf Baechle      2008-10-28  240  #define cpu_has_mips_r	(cpu_has_mips32r1 | cpu_has_mips32r2 | \
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13 @241  			 cpu_has_mips32r6 | cpu_has_mips64r1 | \
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  242  			 cpu_has_mips64r2 | cpu_has_mips64r6)
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  243  
34c56fc1 arch/mips/include/asm/cpu-features.h Leonid Yegoshin   2014-11-13  244  /* MIPSR2 and MIPSR6 have a lot of similarities */

:::::: The code at line 205 was first introduced by commit
:::::: 34c56fc1c167facc375d927687df0a3891d164ac MIPS: asm: cpu: Add MIPSR6 ISA definitions

:::::: TO: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
:::::: CC: Markos Chandras <markos.chandras@imgtec.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18282 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160520/95fd2492/attachment-0001.obj>
