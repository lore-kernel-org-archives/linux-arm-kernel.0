From: xiakaixu@huawei.com (xiakaixu)
Date: Fri, 15 Jan 2016 16:20:05 +0800
Subject: [PATCH v2] arm64: Store breakpoint single step state into pstate
In-Reply-To: <20160112170650.GI15737@arm.com>
References: <1450860731-194418-1-git-send-email-wangnan0@huawei.com>
 <1450921362-198371-1-git-send-email-wangnan0@huawei.com>
 <20160104165535.GI1616@arm.com> <568B4F47.5080307@huawei.com>
 <20160112170650.GI15737@arm.com>
Message-ID: <5698ABB5.6000207@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/1/13 1:06, Will Deacon ??:
> On Tue, Jan 05, 2016 at 01:06:15PM +0800, Wangnan (F) wrote:
>> On 2016/1/5 0:55, Will Deacon wrote:
>>> The problem seems to be that we take the debug exception before the
>>> breakpointed instruction has been executed and call perf_bp_event at
>>> that moment, so when we single-step the faulting instruction we actually
>>> step into the SIGIO handler and end up getting stuck.
>>>
>>> Your fix doesn't really address this afaict, in that you don't (can't?)
>>> handle:
>>>
>>>   * A longjmp out of a signal handler
>>>   * A watchpoint and a breakpoint that fire on the same instruction
>>>   * User-controlled single-step from a signal handler that enables a
>>>     breakpoint explicitly
>>>   * Nested signals
>>
>> Please have a look at [1], which I improve test__bp_signal() to
>> check bullet 2 and 4 you mentioned above. Seems my fix is correct.
>>
>> [1] http://lkml.kernel.org/g/1451969880-14877-1-git-send-email-wangnan0 at huawei.com
> 
> I'm still really uneasy about this change. Pairing up the signal delivery
> with the sigreturn to keep track of the debug state is extremely fragile
> and I'm not keen on adding this logic there. I also think we need to
> track the address that the breakpoint is originally taken on so that we
> can only perform the extra sigreturn work if we're returning to the same
> instruction. Furthermore, I wouldn't want to do this for signals other
> than those generated directly by a breakpoint.
> 
> An alternative would be to postpone the signal delivery until after the
> stepping has been taken care of, but that's a change in ABI and I worry
> we'll break somebody relying on the current behaviour.
> 
> What exactly does x86 do? I couldn't figure it out from the code.

Hi Will,

I changed the signal SIGIO to SIGUSR2 according to the patch that Wang Nan
sent out about improving test__bp_signal() to check bullet 2 and 4 you mentioned.
I tested it with arm64 qemu and gdb. The single instruction execution on qemu
shows that the result is the same as the processing described in Wang Nan's patch[2].

I also tested the patch on x86 qemu and found that the result is the same as
arm64 qemu.

[1]
 tools/perf/tests/bp_signal.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 1d1bb48..3046cba 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -175,7 +175,7 @@ int test__bp_signal(int subtest __maybe_unused)
        sa.sa_sigaction = (void *) sig_handler;
        sa.sa_flags = SA_SIGINFO;

-       if (sigaction(SIGIO, &sa, NULL) < 0) {
+       if (sigaction(SIGUSR2, &sa, NULL) < 0) {
                pr_debug("failed setting up signal handler\n");
                return TEST_FAIL;
        }
@@ -237,9 +237,9 @@ int test__bp_signal(int subtest __maybe_unused)
         *
         */

-       fd1 = bp_event(__test_function, SIGIO);
+       fd1 = bp_event(__test_function, SIGUSR2);
        fd2 = bp_event(sig_handler, SIGUSR1);
-       fd3 = wp_event((void *)&the_var, SIGIO);
+       fd3 = wp_event((void *)&the_var, SIGUSR2);

        ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
        ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);

[2]
         * Following processing should happen:
         *   Exec:               Action:                       Result:
         *   incq (%rdi)       - fd1 event breakpoint hit   -> count1 == 1
         *                     - SIGIO is delivered
         *   sig_handler       - fd2 event breakpoint hit   -> count2 == 1
         *                     - SIGUSR1 is delivered
         *   sig_handler_2                                  -> overflows_2 == 1  (nested signal)
         *   sys_rt_sigreturn  - return from sig_handler_2
         *   overflows++                                    -> overflows = 1
         *   sys_rt_sigreturn  - return from sig_handler
         *   incq (%rdi)       - fd3 event watchpoint hit   -> count3 == 1       (wp and bp in one insn)
         *                     - SIGIO is delivered
         *   sig_handler       - fd2 event breakpoint hit   -> count2 == 2
         *                     - SIGUSR1 is delivered
         *   sig_handler_2                                  -> overflows_2 == 2  (nested signal)
         *   sys_rt_sigreturn  - return from sig_handler_2
         *   overflows++                                    -> overflows = 2
         *   sys_rt_sigreturn  - return from sig_handler
         *   the_var++         - fd3 event watchpoint hit   -> count3 == 2       (standalone watchpoint)
         *                     - SIGIO is delivered
         *   sig_handler       - fd2 event breakpoint hit   -> count2 == 3
         *                     - SIGUSR1 is delivered
         *   sig_handler_2                                  -> overflows_2 == 3  (nested signal)
         *   sys_rt_sigreturn  - return from sig_handler_2
         *   overflows++                                    -> overflows == 3
         *   sys_rt_sigreturn  - return from sig_handler
> 
> Will
> 
> .
> 


-- 
Regards
Kaixu Xia
