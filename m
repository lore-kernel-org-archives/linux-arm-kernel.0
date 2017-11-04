From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Nov 2017 01:34:40 +0800
Subject: [PATCH v1 2/3] arm64: add error synchronization barrier in
 kernel_entry/kernel_exit
In-Reply-To: <1509563697-6359-3-git-send-email-gengdongjiu@huawei.com>
References: <1509563697-6359-3-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201711050144.An8gQZxZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.14-rc7 next-20171103]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/arm64-add-a-macro-for-SError-synchronization/20171104-224216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/entry.S: Assembler messages:
>> arch/arm64/kernel/entry.S:439: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:443: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:447: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:451: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:456: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:460: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:601: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:629: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:670: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:777: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:806: Error: selected processor does not support `esb'
   arch/arm64/kernel/entry.S:832: Error: selected processor does not support `esb'

vim +439 arch/arm64/kernel/entry.S

872d8327 Mark Rutland    2017-07-14  425  
60ffc30d Catalin Marinas 2012-03-05  426  /*
60ffc30d Catalin Marinas 2012-03-05  427   * Invalid mode handlers
60ffc30d Catalin Marinas 2012-03-05  428   */
60ffc30d Catalin Marinas 2012-03-05  429  	.macro	inv_entry, el, reason, regsize = 64
b660950c Ard Biesheuvel  2016-03-18  430  	kernel_entry \el, \regsize
60ffc30d Catalin Marinas 2012-03-05  431  	mov	x0, sp
60ffc30d Catalin Marinas 2012-03-05  432  	mov	x1, #\reason
60ffc30d Catalin Marinas 2012-03-05  433  	mrs	x2, esr_el1
2d0e751a Mark Rutland    2017-07-26  434  	bl	bad_mode
2d0e751a Mark Rutland    2017-07-26  435  	ASM_BUG()
60ffc30d Catalin Marinas 2012-03-05  436  	.endm
60ffc30d Catalin Marinas 2012-03-05  437  
60ffc30d Catalin Marinas 2012-03-05  438  el0_sync_invalid:
60ffc30d Catalin Marinas 2012-03-05 @439  	inv_entry 0, BAD_SYNC
60ffc30d Catalin Marinas 2012-03-05  440  ENDPROC(el0_sync_invalid)
60ffc30d Catalin Marinas 2012-03-05  441  
60ffc30d Catalin Marinas 2012-03-05  442  el0_irq_invalid:
60ffc30d Catalin Marinas 2012-03-05  443  	inv_entry 0, BAD_IRQ
60ffc30d Catalin Marinas 2012-03-05  444  ENDPROC(el0_irq_invalid)
60ffc30d Catalin Marinas 2012-03-05  445  
60ffc30d Catalin Marinas 2012-03-05  446  el0_fiq_invalid:
60ffc30d Catalin Marinas 2012-03-05  447  	inv_entry 0, BAD_FIQ
60ffc30d Catalin Marinas 2012-03-05  448  ENDPROC(el0_fiq_invalid)
60ffc30d Catalin Marinas 2012-03-05  449  
60ffc30d Catalin Marinas 2012-03-05  450  el0_error_invalid:
60ffc30d Catalin Marinas 2012-03-05  451  	inv_entry 0, BAD_ERROR
60ffc30d Catalin Marinas 2012-03-05  452  ENDPROC(el0_error_invalid)
60ffc30d Catalin Marinas 2012-03-05  453  

:::::: The code at line 439 was first introduced by commit
:::::: 60ffc30d5652810dd34ea2eec41504222f5d5791 arm64: Exception handling

:::::: TO: Catalin Marinas <catalin.marinas@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36749 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171105/abc6984e/attachment-0001.gz>
