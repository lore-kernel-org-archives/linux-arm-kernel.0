From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Mar 2018 19:01:53 +0800
Subject: [PATCH] arm64: avoid race condition issue in dump_backtrace
In-Reply-To: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
Message-ID: <201803241843.AFCX0bXC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ji,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.16-rc6 next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ji-Zhang/arm64-avoid-race-condition-issue-in-dump_backtrace/20180324-165040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/traps.c: In function 'dump_backtrace':
>> arch/arm64/kernel/traps.c:116:2: error: expected '}' before 'else'
     else if (tsk->state == TASK_RUNNING) {
     ^~~~

vim +116 arch/arm64/kernel/traps.c

    99	
   100	void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
   101	{
   102		struct stackframe frame;
   103		int skip;
   104	
   105		pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
   106	
   107		if (!tsk)
   108			tsk = current;
   109	
   110		if (!try_get_task_stack(tsk))
   111			return;
   112	
   113		if (tsk == current) {
   114			frame.fp = (unsigned long)__builtin_frame_address(0);
   115			frame.pc = (unsigned long)dump_backtrace;
 > 116		else if (tsk->state == TASK_RUNNING) {
   117			pr_notice("Do not dump other running tasks\n");
   118			return;
   119		} else {
   120			/*
   121			 * task blocked in __switch_to
   122			 */
   123			frame.fp = thread_saved_fp(tsk);
   124			frame.pc = thread_saved_pc(tsk);
   125		}
   126	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
   127		frame.graph = tsk->curr_ret_stack;
   128	#endif
   129	
   130		skip = !!regs;
   131		printk("Call trace:\n");
   132		do {
   133			/* skip until specified stack frame */
   134			if (!skip) {
   135				dump_backtrace_entry(frame.pc);
   136			} else if (frame.fp == regs->regs[29]) {
   137				skip = 0;
   138				/*
   139				 * Mostly, this is the case where this function is
   140				 * called in panic/abort. As exception handler's
   141				 * stack frame does not contain the corresponding pc
   142				 * at which an exception has taken place, use regs->pc
   143				 * instead.
   144				 */
   145				dump_backtrace_entry(regs->pc);
   146			}
   147		} while (!unwind_frame(tsk, &frame));
   148	
   149		put_task_stack(tsk);
   150	}
   151	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37896 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/dc233aa6/attachment-0001.gz>
