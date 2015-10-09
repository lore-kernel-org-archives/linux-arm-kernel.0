From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Oct 2015 14:46:19 +0800
Subject: [PATCH v3 3/7] arm64: ftrace: fix a stack tracer's output under
 function graph tracer
In-Reply-To: <1444298504-10392-4-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <201510091449.9RhxPRNA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/AKASHI-Takahiro/arm64-ftrace-fix-incorrect-output-from-stack-tracer HEAD f6c03913c640aa1d196348c49f15cfdc264393e0 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/kernel/stacktrace.c: In function 'save_trace':
>> arch/arm64/kernel/stacktrace.c:93:29: error: 'return_to_handler' undeclared (first use in this function)
     if (addr == (unsigned long)return_to_handler - AARCH64_INSN_SIZE) {
                                ^
   arch/arm64/kernel/stacktrace.c:93:29: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm64/kernel/stacktrace.c:101:4: error: invalid use of undefined type 'struct ftrace_ret_stack'
       current->ret_stack[data->ret_stack_index--].ret
       ^
>> arch/arm64/kernel/stacktrace.c:101:22: error: dereferencing pointer to incomplete type
       current->ret_stack[data->ret_stack_index--].ret
                         ^

vim +/return_to_handler +93 arch/arm64/kernel/stacktrace.c

    87	{
    88		struct stack_trace_data *data = d;
    89		struct stack_trace *trace = data->trace;
    90		unsigned long addr = frame->pc;
    91	
    92	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
  > 93		if (addr == (unsigned long)return_to_handler - AARCH64_INSN_SIZE) {
    94			/*
    95			 * This is a case where function graph tracer has
    96			 * modified a return address (LR) in a stack frame
    97			 * to hook a function return.
    98			 * So replace it to an original value.
    99			 */
   100			frame->pc = addr =
 > 101				current->ret_stack[data->ret_stack_index--].ret
   102								- AARCH64_INSN_SIZE;
   103		}
   104	#endif /* CONFIG_FUNCTION_GRAPH_TRACER */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45525 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151009/8c359503/attachment-0001.obj>
