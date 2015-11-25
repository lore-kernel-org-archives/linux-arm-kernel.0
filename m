From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Nov 2015 04:21:09 +0800
Subject: [PATCH v2] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <50fd45fb78403b66381569a8c9ada6b17433e2d9.1448460525.git.geliangtang@163.com>
Message-ID: <201511260435.1AHQOCP1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geliang,

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.4-rc2 next-20151124]

url:    https://github.com/0day-ci/linux/commits/Geliang-Tang/ARM-davinci-fix-a-problematic-usage-of-WARN/20151125-221653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-davinci_all_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/bug.h:62:0,
                    from arch/arm/include/asm/div64.h:63,
                    from include/linux/kernel.h:136,
                    from arch/arm/mach-davinci/board-dm355-evm.c:11:
   arch/arm/mach-davinci/board-dm355-evm.c: In function 'dm355_evm_init':
>> include/asm-generic/bug.h:74:72: error: expected expression before ')' token
    #define __WARN_printf(arg...) warn_slowpath_fmt(__FILE__, __LINE__, arg)
                                                                           ^
   include/asm-generic/bug.h:97:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(format);     \
      ^
>> arch/arm/mach-davinci/board-dm355-evm.c:387:7: note: in expansion of macro 'WARN'
     if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
          ^
   arch/arm/mach-davinci/board-dm355-evm.c:387:6: warning: value computed is not used [-Wunused-value]
     if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
         ^
>> arch/arm/mach-davinci/board-dm355-evm.c:387:58: error: expected statement before ')' token
     if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
                                                             ^
--
   In file included from arch/arm/include/asm/bug.h:62:0,
                    from arch/arm/include/asm/div64.h:63,
                    from include/linux/kernel.h:136,
                    from arch/arm/mach-davinci/board-dm355-leopard.c:10:
   arch/arm/mach-davinci/board-dm355-leopard.c: In function 'dm355_leopard_init':
>> include/asm-generic/bug.h:74:72: error: expected expression before ')' token
    #define __WARN_printf(arg...) warn_slowpath_fmt(__FILE__, __LINE__, arg)
                                                                           ^
   include/asm-generic/bug.h:97:3: note: in expansion of macro '__WARN_printf'
      __WARN_printf(format);     \
      ^
>> arch/arm/mach-davinci/board-dm355-leopard.c:245:7: note: in expansion of macro 'WARN'
     if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
          ^
   arch/arm/mach-davinci/board-dm355-leopard.c:245:6: warning: value computed is not used [-Wunused-value]
     if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
         ^
>> arch/arm/mach-davinci/board-dm355-leopard.c:245:58: error: expected statement before ')' token
     if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
                                                             ^

vim +387 arch/arm/mach-davinci/board-dm355-evm.c

   381	
   382		gpio_request(1, "dm9000");
   383		gpio_direction_input(1);
   384		dm355evm_dm9000_rsrc[2].start = gpio_to_irq(1);
   385	
   386		aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
 > 387		if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
   388			clk_prepare_enable(aemif);
   389	
   390		platform_add_devices(davinci_evm_devices,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18871 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151126/eeb2e3c4/attachment-0001.obj>
