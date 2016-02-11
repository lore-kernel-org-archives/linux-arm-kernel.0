From: james.morse@arm.com (James Morse)
Date: Thu, 11 Feb 2016 10:41:08 +0000
Subject: [PATCH] arm64: use raw_smp_processor_id in stack backtrace dump
In-Reply-To: <56BB7D7B.4060002@linaro.org>
References: <1455053182-31404-1-git-send-email-yang.shi@linaro.org>
 <20160210102939.GD1052@arm.com> <56BB247F.6040202@arm.com>
 <20160210121030.GH1052@arm.com> <56BB7D7B.4060002@linaro.org>
Message-ID: <56BC6544.70001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 10/02/16 18:12, Shi, Yang wrote:
> On 2/10/2016 4:10 AM, Will Deacon wrote:
>> On Wed, Feb 10, 2016 at 11:52:31AM +0000, James Morse wrote:
>>> On 10/02/16 10:29, Will Deacon wrote:
>>>> On Tue, Feb 09, 2016 at 01:26:22PM -0800, Yang Shi wrote:
>>>>> dump_backtrace may be called in kthread context, which is not bound to a
>>>>> single
>>>>> cpu, i.e. khungtaskd, then calling smp_processor_id may trigger the below bug
>>>>> report:
>>>>
>>>> If we're preemptible here, it means that our irq_stack_ptr is potentially
>>>> bogus. Whilst this isn't an issue for kthreads, it does feel like we
>>>> could make this slightly more robust in the face of potential frame
>>>> corruption. Maybe just zero the IRQ stack pointer if we're in preemptible
>>>> context?
>>>
>>> Switching between stacks is only valid if we are tracing ourselves while on the
>>> irq_stack, we should probably prevent it for other tasks too.
>>>
>>> Something like (untested):
>>> ---------------------
>>> if (tsk == current && in_atomic())
>>>     irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
> 
> One follow up question, is it possible to have both tsk != current and
> on_irq_stack is true at the same time?

No. If you are tracing an irq stack, it must be your own stack.

If this weren't the case, it would be the stack of a running task on a remote
CPU, and you would be racing with the remote CPU changing the values you are
reading. Fortunately nothing tries to do this.

(The third case would be tracing a sleeping irq stack - this doesn't happen
 either, as we switch back to the original stack before calling schedule()).


> If it is possible, this may be a problem
> in unwind_frame called by profile_pc which has tsk being NULL.

Ah, well spotted. I guess there should also be a != NULL comparison thrown into
the mix. I don't think it will be a problem for profile_pc() as it should always
find a !in_lock_functions() frame before it needs to switch stack, (which we are
preventing it from doing). If this ever did happen, it will return 0.


Thanks,

James
