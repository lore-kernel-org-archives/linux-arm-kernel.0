From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 10 Nov 2015 22:32:47 +0900
Subject: [PATCH v5 0/6] arm64: ftrace: fix incorrect output from stack
 tracer
In-Reply-To: <56415D50.40500@linaro.org>
References: <1446792285-1154-1-git-send-email-takahiro.akashi@linaro.org>
 <252DE845-D0C2-460C-8161-090ED08396A4@gmail.com> <56415D50.40500@linaro.org>
Message-ID: <06B8BFC7-E3A5-4FF8-8897-27AD597D2E45@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 10, 2015, at 11:58 AM, AKASHI Takahiro wrote:

Hi Akashi,

> On 11/09/2015 11:24 PM, Jungseok Lee wrote:
>> On Nov 6, 2015, at 3:44 PM, AKASHI Takahiro wrote:
>> 
>> Hi Akashi,
>> 
>>> This is the fifth patch series for fixing stack tracer on arm64.
>>> The original issue was reported by Jungseok[1], and then I found more
>>> issues[2].
>>> 
>>> We don't have to care about the original issue because the root cause
>>> (patch "ARM64: unwind: Fix PC calculation") has been reverted in v4.3.
>>> 
>>> I address here all the issues and implement fixes described in [2] except
>>> for interrupt-triggered problems(II-3) and leaf function(II-5).  Recent
>>> discussions[3] about introducing a dedicated interrupt stack suggests that
>>> we may avoid walking through from an interrupt stack to a process stack.
>>> (So interrupt-stack patch is a prerequisite.)
>>> 
>>> Basically,
>>> patch1 is a proactive improvement of function_graph tracer.
>>> patch2 corresponds to II-4(functions under function_graph tracer).
>>> patch3, 4 and 5 correspond to II-1(slurping stack) and II-2(differences
>>> between x86 and arm64).
>>> patch6 is a function prologue analyzer test. This won't attest
>>> the correctness of the functionality, but it can suggest that all
>>> the traced functions are treated properly by this function.
>>> (Please note that patch3 has already been queued in Steven's for-next.)
>>> 
>>> I tested the code with v4.3 + Jungseok's patch v5[4].
>> 
>> I've played this series with IRQ stack patch and it works well at least
>> on my system! In addition to this condition, I've run these changes without
>> IRQ stack since it is in progress. I could observe a single strange behavior,
>> minus stack size around elX_irq. Am I missing something?
> 
> You saw the result like:
> ...
> 13)     4336      64   gic_handle_irq+0x5c/0xa4
> 14)     4272     576   el1_irq+0x68/0xd8
> 15)     3696    -160   smc_hardware_send_pkt+0x278/0x42c
> 
> This is the most difficult problem that I mentioned in II-3 of [1] and tried to fix.
> For example, smc_hardware_send_pkt is NOT the function interrupted, but
> _raw_spin_unlock_irqstore which is called at '+0x278/0x42c' is.
> Giving a *perfect* solution against it is quite tough (and complicated).
> Since you have introduced interrupt stack and even on x86 an interrupt stack is
> not supported, I removed related patches.

Yes, that is what I've observed. I was not sure whether the behavior is related to
II-3, interrupted frame, or not. Thanks for clarification!

Best Regards
Jungseok Lee
