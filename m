From: wcohen@redhat.com (William Cohen)
Date: Tue, 21 Apr 2015 10:07:42 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <55363791.4070706@hitachi.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com>
Message-ID: <553659AE.4090809@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 07:42 AM, Masami Hiramatsu wrote:
> (2015/04/21 5:19), David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
>> first seen in October 2013. This version attempts to address concerns raised by
>> reviewers and also fixes problems discovered during testing.
>>
>> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>> and return probes(kretprobes) support for ARM64.
>>
>> The kprobes mechanism makes use of software breakpoint and single stepping
>> support available in the ARM v8 kernel.
>>
> [...]
>> Changes since v5 include:
>>
>> 1) Replaced installation of breakpoint hook with direct call from the
>> handlers in debug-monitors.c, as requested.
>> 2) Reject probing of instructions that read the interrupt mask, in
>> addition to instructions that set it.
>> 3) Cleaned up comments describing usage of Debug Mask.
>> 4) Added KPROBE_REENTER case in reenter_kprobe.
>> 5) Corrected the ifdef'd definitions for notify_page_fault() to be
>> consistent when KPROBES is not configed.
>> 6) Changed "cpsr" to "pstate" for HAVE_REGS_AND_STACK_ACCESS_API feature.
>> 7) Added back in missing new files in previous patch.
>> 8) Changed two instances of pr_warning() to pr_warn().
> 
> Looks OK to me:)
> BTW, have you tried to build and test this with CONFIG_KPROBE_EVENT?
> If so, you can also test it by tools/testing/selftests/ftrace/ftracetest.
> 
>> Note that there seems to be at least a potential issue with kprobes
>> on multiple (possibly all) platforms having to do with use of kfree
>> inside of the kretprobes trampoline handler.  This has manifested
>> occasionally in systemtap testing on arm64.  There does not appear to
>> be an simple solution to the problem.
> 
> No, trampoline handler must call recycle_rp_inst() instead of kfree
> to return kretprobe instance to the pool. Hmm, I should look into it.
> 
> Thank you,
> 

Hi,

I have noticed when running the systemtap testsuite even with this newest revision of the arm64 kprobe patches the system will start spewing the following message:

Unexpected kernel single-step exception at EL1

That is triggered by the functioncallcount.stp test in the systemtap examples.  The test is instrumenting many function calls and returns in the memory management code.  It appears that the problem is triggered during the kfree call/return towards the end of trampoline_probe_handler.  The single_step_handler function in debug-monitors.c calls kprobe_single_step_handler which indicates that the breakpoint is not a kprobe breakpoint.  Thus, single_step_handler starts flagging the breakpoint with the above message.

It would be good if the warning message included and address to be a bit more informative.  I put in some addition code (the attached patch) to print out register information to diagnose what was going on.

Other architecture do use kfree in the kretprobe trampoline handlers but do not seem to encounter this problem. 

-Will
-------------- next part --------------
A non-text attachment was scrubbed...
Name: debug_diag.patch
Type: text/x-patch
Size: 915 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/dca21984/attachment.bin>
