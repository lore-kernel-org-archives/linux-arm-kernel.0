From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Mar 2018 04:43:16 +0800
Subject: [PATCH 7/7] Enable KASan for arm
In-Reply-To: <20180318125342.4278-8-liuwenliang@huawei.com>
References: <20180318125342.4278-8-liuwenliang@huawei.com>
Message-ID: <201803200442.ZvlcJvVm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc6]
[cannot apply to next-20180319]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abbott-Liu/KASan-for-arm/20180319-120138
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/entry-common.S: Assembler messages:
>> arch/arm/kernel/entry-common.S:85: Error: invalid constant (ffffffffb6e00000) after fixup

vim +85 arch/arm/kernel/entry-common.S

^1da177e4 Linus Torvalds  2005-04-16   68  
3302caddf Russell King    2015-08-20   69  	/* Ok, we need to do extra processing, enter the slow path. */
^1da177e4 Linus Torvalds  2005-04-16   70  fast_work_pending:
^1da177e4 Linus Torvalds  2005-04-16   71  	str	r0, [sp, #S_R0+S_OFF]!		@ returned r0
3302caddf Russell King    2015-08-20   72  	/* fall through to work_pending */
3302caddf Russell King    2015-08-20   73  #else
3302caddf Russell King    2015-08-20   74  /*
3302caddf Russell King    2015-08-20   75   * The "replacement" ret_fast_syscall for when tracing or context tracking
3302caddf Russell King    2015-08-20   76   * is enabled.  As we will need to call out to some C functions, we save
3302caddf Russell King    2015-08-20   77   * r0 first to avoid needing to save registers around each C function call.
3302caddf Russell King    2015-08-20   78   */
3302caddf Russell King    2015-08-20   79  ret_fast_syscall:
3302caddf Russell King    2015-08-20   80   UNWIND(.fnstart	)
3302caddf Russell King    2015-08-20   81   UNWIND(.cantunwind	)
3302caddf Russell King    2015-08-20   82  	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
3302caddf Russell King    2015-08-20   83  	disable_irq_notrace			@ disable interrupts
e33f8d326 Thomas Garnier  2017-09-07   84  	ldr	r2, [tsk, #TI_ADDR_LIMIT]
e33f8d326 Thomas Garnier  2017-09-07  @85  	cmp	r2, #TASK_SIZE
e33f8d326 Thomas Garnier  2017-09-07   86  	blne	addr_limit_check_failed
3302caddf Russell King    2015-08-20   87  	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
2404269bc Thomas Garnier  2017-09-07   88  	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
3302caddf Russell King    2015-08-20   89  	beq	no_work_pending
3302caddf Russell King    2015-08-20   90   UNWIND(.fnend		)
3302caddf Russell King    2015-08-20   91  ENDPROC(ret_fast_syscall)
3302caddf Russell King    2015-08-20   92  
3302caddf Russell King    2015-08-20   93  	/* Slower path - fall through to work_pending */
3302caddf Russell King    2015-08-20   94  #endif
3302caddf Russell King    2015-08-20   95  
3302caddf Russell King    2015-08-20   96  	tst	r1, #_TIF_SYSCALL_WORK
3302caddf Russell King    2015-08-20   97  	bne	__sys_trace_return_nosave
3302caddf Russell King    2015-08-20   98  slow_work_pending:
^1da177e4 Linus Torvalds  2005-04-16   99  	mov	r0, sp				@ 'regs'
^1da177e4 Linus Torvalds  2005-04-16  100  	mov	r2, why				@ 'syscall'
0a267fa6a Al Viro         2012-07-19  101  	bl	do_work_pending
662852178 Al Viro         2012-07-19  102  	cmp	r0, #0
81783786d Al Viro         2012-07-19  103  	beq	no_work_pending
662852178 Al Viro         2012-07-19  104  	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
81783786d Al Viro         2012-07-19  105  	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
81783786d Al Viro         2012-07-19  106  	b	local_restart			@ ... and off we go
e83dd3770 Drew Richardson 2015-08-06  107  ENDPROC(ret_fast_syscall)
81783786d Al Viro         2012-07-19  108  

:::::: The code at line 85 was first introduced by commit
:::::: e33f8d32677fa4f4f8996ef46748f86aac81ccff arm/syscalls: Optimize address limit check

:::::: TO: Thomas Garnier <thgarnie@google.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65135 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180320/3ebb7ab3/attachment-0001.gz>
