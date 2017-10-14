From: lkp@intel.com (kbuild test robot)
Date: Sat, 14 Oct 2017 19:41:44 +0800
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <20171011082227.20546-5-liuwenliang@huawei.com>
Message-ID: <201710141957.mbxeZJHB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abbott,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc4]
[cannot apply to next-20171013]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abbott-Liu/KASan-for-arm/20171014-104108
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/entry-common.S: Assembler messages:
>> arch/arm/kernel/entry-common.S:83: Error: invalid constant (ffffffffb6e00000) after fixup
   arch/arm/kernel/entry-common.S:118: Error: invalid constant (ffffffffb6e00000) after fixup
--
   arch/arm/kernel/entry-armv.S: Assembler messages:
>> arch/arm/kernel/entry-armv.S:213: Error: selected processor does not support `movw r1,#:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
>> arch/arm/kernel/entry-armv.S:213: Error: selected processor does not support `movt r1,#:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:223: Error: selected processor does not support `movw r1,#:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:223: Error: selected processor does not support `movt r1,#:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:270: Error: selected processor does not support `movw r1,#:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:270: Error: selected processor does not support `movt r1,#:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:311: Error: selected processor does not support `movw r1,#:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:311: Error: selected processor does not support `movt r1,#:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:320: Error: selected processor does not support `movw r1,#:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:320: Error: selected processor does not support `movt r1,#:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movw r1,#:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
   arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movt r1,#:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode

vim +213 arch/arm/kernel/entry-armv.S

2dede2d8e Nicolas Pitre   2006-01-14  151  
2190fed67 Russell King    2015-08-20  152  	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1
c4c5716e1 Catalin Marinas 2009-02-16  153   UNWIND(.fnstart		)
c4c5716e1 Catalin Marinas 2009-02-16  154   UNWIND(.save {r0 - pc}		)
e6a9dc612 Russell King    2016-05-13  155  	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole - 4)
b86040a59 Catalin Marinas 2009-07-24  156  #ifdef CONFIG_THUMB2_KERNEL
b86040a59 Catalin Marinas 2009-07-24  157   SPFIX(	str	r0, [sp]	)	@ temporarily saved
b86040a59 Catalin Marinas 2009-07-24  158   SPFIX(	mov	r0, sp		)
b86040a59 Catalin Marinas 2009-07-24  159   SPFIX(	tst	r0, #4		)	@ test original stack alignment
b86040a59 Catalin Marinas 2009-07-24  160   SPFIX(	ldr	r0, [sp]	)	@ restored
b86040a59 Catalin Marinas 2009-07-24  161  #else
2dede2d8e Nicolas Pitre   2006-01-14  162   SPFIX(	tst	sp, #4		)
b86040a59 Catalin Marinas 2009-07-24  163  #endif
b86040a59 Catalin Marinas 2009-07-24  164   SPFIX(	subeq	sp, sp, #4	)
b86040a59 Catalin Marinas 2009-07-24  165  	stmia	sp, {r1 - r12}
ccea7a19e Russell King    2005-05-31  166  
b059bdc39 Russell King    2011-06-25  167  	ldmia	r0, {r3 - r5}
b059bdc39 Russell King    2011-06-25  168  	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
b059bdc39 Russell King    2011-06-25  169  	mov	r6, #-1			@  ""  ""      ""       ""
e6a9dc612 Russell King    2016-05-13  170  	add	r2, sp, #(SVC_REGS_SIZE + \stack_hole - 4)
b059bdc39 Russell King    2011-06-25  171   SPFIX(	addeq	r2, r2, #4	)
b059bdc39 Russell King    2011-06-25  172  	str	r3, [sp, #-4]!		@ save the "real" r0 copied
ccea7a19e Russell King    2005-05-31  173  					@ from the exception stack
ccea7a19e Russell King    2005-05-31  174  
b059bdc39 Russell King    2011-06-25  175  	mov	r3, lr
^1da177e4 Linus Torvalds  2005-04-16  176  
^1da177e4 Linus Torvalds  2005-04-16  177  	@
^1da177e4 Linus Torvalds  2005-04-16  178  	@ We are now ready to fill in the remaining blanks on the stack:
^1da177e4 Linus Torvalds  2005-04-16  179  	@
b059bdc39 Russell King    2011-06-25  180  	@  r2 - sp_svc
b059bdc39 Russell King    2011-06-25  181  	@  r3 - lr_svc
b059bdc39 Russell King    2011-06-25  182  	@  r4 - lr_<exception>, already fixed up for correct return/restart
b059bdc39 Russell King    2011-06-25  183  	@  r5 - spsr_<exception>
b059bdc39 Russell King    2011-06-25  184  	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
^1da177e4 Linus Torvalds  2005-04-16  185  	@
b059bdc39 Russell King    2011-06-25  186  	stmia	r7, {r2 - r6}
^1da177e4 Linus Torvalds  2005-04-16  187  
e6978e4bf Russell King    2016-05-13  188  	get_thread_info tsk
e6978e4bf Russell King    2016-05-13  189  	ldr	r0, [tsk, #TI_ADDR_LIMIT]
74e552f98 Abbott Liu      2017-10-11  190  #ifdef CONFIG_KASAN
74e552f98 Abbott Liu      2017-10-11  191  	movw r1, #:lower16:TASK_SIZE
74e552f98 Abbott Liu      2017-10-11  192  	movt r1, #:upper16:TASK_SIZE
74e552f98 Abbott Liu      2017-10-11  193  #else
e6978e4bf Russell King    2016-05-13  194  	mov r1, #TASK_SIZE
74e552f98 Abbott Liu      2017-10-11  195  #endif
e6978e4bf Russell King    2016-05-13  196  	str	r1, [tsk, #TI_ADDR_LIMIT]
e6978e4bf Russell King    2016-05-13  197  	str	r0, [sp, #SVC_ADDR_LIMIT]
e6978e4bf Russell King    2016-05-13  198  
2190fed67 Russell King    2015-08-20  199  	uaccess_save r0
2190fed67 Russell King    2015-08-20  200  	.if \uaccess
2190fed67 Russell King    2015-08-20  201  	uaccess_disable r0
2190fed67 Russell King    2015-08-20  202  	.endif
2190fed67 Russell King    2015-08-20  203  
c0e7f7ee7 Daniel Thompson 2014-09-17  204  	.if \trace
02fe2845d Russell King    2011-06-25  205  #ifdef CONFIG_TRACE_IRQFLAGS
02fe2845d Russell King    2011-06-25  206  	bl	trace_hardirqs_off
02fe2845d Russell King    2011-06-25  207  #endif
c0e7f7ee7 Daniel Thompson 2014-09-17  208  	.endif
f2741b78b Russell King    2011-06-25  209  	.endm
^1da177e4 Linus Torvalds  2005-04-16  210  
f2741b78b Russell King    2011-06-25  211  	.align	5
f2741b78b Russell King    2011-06-25  212  __dabt_svc:
2190fed67 Russell King    2015-08-20 @213  	svc_entry uaccess=0
^1da177e4 Linus Torvalds  2005-04-16  214  	mov	r2, sp
da7404725 Russell King    2011-06-26  215  	dabt_helper
e16b31bf4 Marc Zyngier    2013-11-04  216   THUMB(	ldr	r5, [sp, #S_PSR]	)	@ potentially updated CPSR
b059bdc39 Russell King    2011-06-25  217  	svc_exit r5				@ return from exception
c4c5716e1 Catalin Marinas 2009-02-16  218   UNWIND(.fnend		)
93ed39701 Catalin Marinas 2008-08-28  219  ENDPROC(__dabt_svc)
^1da177e4 Linus Torvalds  2005-04-16  220  
^1da177e4 Linus Torvalds  2005-04-16  221  	.align	5
^1da177e4 Linus Torvalds  2005-04-16  222  __irq_svc:
ccea7a19e Russell King    2005-05-31  223  	svc_entry
187a51ad1 Russell King    2005-05-21  224  	irq_handler
1613cc111 Russell King    2011-06-25  225  

:::::: The code at line 213 was first introduced by commit
:::::: 2190fed67ba6f3e8129513929f2395843645e928 ARM: entry: provide uaccess assembly macro hooks

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64028 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171014/e2e98833/attachment-0001.gz>
