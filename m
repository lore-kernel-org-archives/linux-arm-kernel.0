From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Dec 2016 14:48:33 +0800
Subject: [PATCH 7/7] arm: Add livepatch necessary arch selects into Kconfig
In-Reply-To: <1481043967-15602-8-git-send-email-abelvesa@linux.com>
Message-ID: <201612071422.sZoSXIfi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc8 next-20161206]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abel-Vesa/arm-Add-livepatch-support/20161207-074210
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   arch/arm/kernel/entry-ftrace.S: Assembler messages:
>> arch/arm/kernel/entry-ftrace.S:259: Warning: if writeback register is in list, it must be the lowest reg in the list
>> arch/arm/kernel/entry-ftrace.S:259: Warning: writeback of base register when in register list is UNPREDICTABLE

vim +259 arch/arm/kernel/entry-ftrace.S

82112379 Russell King 2014-10-28  243  #else
82112379 Russell King 2014-10-28  244  	__mcount
82112379 Russell King 2014-10-28  245  #endif
82112379 Russell King 2014-10-28  246  UNWIND(.fnend)
82112379 Russell King 2014-10-28  247  ENDPROC(__gnu_mcount_nc)
82112379 Russell King 2014-10-28  248  
82112379 Russell King 2014-10-28  249  #ifdef CONFIG_DYNAMIC_FTRACE
82112379 Russell King 2014-10-28  250  ENTRY(ftrace_caller)
82112379 Russell King 2014-10-28  251  UNWIND(.fnstart)
82112379 Russell King 2014-10-28  252  	__ftrace_caller
82112379 Russell King 2014-10-28  253  UNWIND(.fnend)
82112379 Russell King 2014-10-28  254  ENDPROC(ftrace_caller)
22cc202f Abel Vesa    2016-12-06  255  
22cc202f Abel Vesa    2016-12-06  256  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
22cc202f Abel Vesa    2016-12-06  257  ENTRY(ftrace_regs_caller)
22cc202f Abel Vesa    2016-12-06  258  UNWIND(.fnstart)
22cc202f Abel Vesa    2016-12-06 @259  	__ftrace_regs_caller
22cc202f Abel Vesa    2016-12-06  260  UNWIND(.fnend)
22cc202f Abel Vesa    2016-12-06  261  ENDPROC(ftrace_regs_caller)
22cc202f Abel Vesa    2016-12-06  262  #endif
22cc202f Abel Vesa    2016-12-06  263  
82112379 Russell King 2014-10-28  264  #endif
82112379 Russell King 2014-10-28  265  
82112379 Russell King 2014-10-28  266  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
82112379 Russell King 2014-10-28  267  ENTRY(ftrace_graph_caller)

:::::: The code at line 259 was first introduced by commit
:::::: 22cc202f6f168f6987ec2441a19ce1601a296a4e arm: Add ftrace with regs support

:::::: TO: Abel Vesa <abelvesa@linux.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59460 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/57348213/attachment-0001.gz>
