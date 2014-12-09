From: dave.long@linaro.org (David Long)
Date: Tue, 09 Dec 2014 09:27:18 -0500
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <20141209133340.GA20265@linaro.org>
References: <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
 <547C36DB.7060903@hitachi.com> <547F242D.1060705@redhat.com>
 <547F94B0.1000902@linaro.org> <547FB5DD.901@redhat.com>
 <547FCB73.1010707@linaro.org>
 <CAPvkgC3=KKKMa1hWdOYOcV7D7kQSLtnNnXLBB64_P-V+_qUwTw@mail.gmail.com>
 <54803ADD.2090201@hitachi.com>
 <CAPvkgC26-CprjLVH55=7z73JtxTumFFZ4W7itevXxMwReVqQ1g@mail.gmail.com>
 <54804B1F.3020703@hitachi.com> <20141209133340.GA20265@linaro.org>
Message-ID: <548706C6.2050105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/14 08:33, Steve Capper wrote:
> On Thu, Dec 04, 2014 at 08:53:03PM +0900, Masami Hiramatsu wrote:
>> (2014/12/04 20:29), Steve Capper wrote:
>>
>>>> I'd like to ask you to try my fix on your machine, with my reproducing
>>>> methods. (do not use sytemtap nor perf, those can have other issues)
>>>>
>>>
>>> Thank you Masami,
>>>
>>> I tried the following commands:
>>>
>>> echo "p:trace_event_buffer_lock_reserve
>>> trace_event_buffer_lock_reserve" >
>>> /sys/kernel/debug/tracing/kprobe_events
>>> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>>> echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_exec/enable
>>>
>>> The system appeared okay, I then cat'ed out:
>>> # cat /sys/kernel/debug/tracing/kprobe_profile
>>>     trace_event_buffer_lock_reserve                           25              25
>>>
>>> I got similar output (i.e. no crashes) both with and without the
>>> interrupt fix you recommended.
>>>
>>> I'm not sure how to interpret this, please let me know if you would
>>> like me to run any other tests?
>>>
>>> (I did also try your proposed fix with perf + memcpy and that crashed
>>> in a similar way as before).
>>
>> Hmm, then the bug is still there, and the bug may not be in the recursive
>> call path... We need to find another suspicious code in the patch.
>>
>
> Not sure if this is helpful, but the following also caused a crash for
> me:
>
> echo "p:trace_event_buffer_lock_reserve trace_event_buffer_lock_reserve" > /sys/kernel/debug/tracing/kprobe_events
> echo "p:memcpy memcpy" >> /sys/kernel/debug/tracing/kprobe_events
> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>
> [immediate crash]
>
> The crash point for me is in the arm64 ASID allocator, it again looks
> like the interrupts are in an unexpected state.
> (check_and_switch_context goes down the irqs disabled code path, I
> think incorrectly).
>
> This occurred for me both with and without the proposed irq saving fix.
>
> I will do some more digging.
>

Thanks, more information is good.

-dl
