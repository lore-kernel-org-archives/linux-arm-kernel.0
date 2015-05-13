From: wcohen@redhat.com (William Cohen)
Date: Wed, 13 May 2015 16:35:54 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <5553ACF2.2080802@linaro.org>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com> <553AB222.50609@redhat.com>
 <553EF74D.8020706@redhat.com> <20150429102346.GK8236@arm.com>
 <55442BFA.50101@redhat.com> <554851CB.2010909@linaro.org>
 <20150505154830.GI1550@arm.com> <55519583.9020507@linaro.org>
 <5551F693.8050100@redhat.com> <555317E8.2000502@hitachi.com>
 <555370B9.2070203@redhat.com> <5553ACF2.2080802@linaro.org>
Message-ID: <5553B5AA.6070609@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 03:58 PM, David Long wrote:
> On 05/13/15 11:41, William Cohen wrote:
>> On 05/13/2015 05:22 AM, Masami Hiramatsu wrote:
>>> On 2015/05/12 21:48, William Cohen wrote:
>>
>>>> Hi Dave,
>>>>
>>>> In some of the previous diagnostic output it looked like things would go wrong
>>>> in the entry.S when the D bit was cleared and the debug interrupts were
>>>> unmasksed.  I wonder if some of the issue might be due to the starting the
>>>> kprobe for the trampoline, but leaving things in an odd state when another
>>>> set of krpobe/kretporbes are hit when the trampoline is running.
>>>
>>> Hmm, does this mean we have a trouble if a user kprobe handler calls the
>>> function which is probed by other kprobe? Or, is this just a problem
>>> only for kretprobes?
>>
>> Hi Masami,
>>
>> I wrote an example based off of sample/kprobes/kprobes_sample.c to force the reentry issue for kprobes (the attached kprobe_rentry_example.c). That seemed to run fine.  I think the reason that the trampoline handler got into trouble is because of the reset_current_kprobe() before the possible call to kfree, but I haven't verified it. It seems like that should be at the end of trampoline handler just before the return.  Other architectures have similar trampoline handlers, so I am surprised that the other architectures haven't encountered this issue with kretprobes.  Maybe this is due to specific of arm64 exception handling.
>>
>> # modprobe kprobe_reentry_example
>> [  909.617295] Planted kprobe at fffffe00000b7b34
>> [  909.623873] Planted kprobe at fffffe000032d34c
>> # rmmod kprobe_reentry_example
>> [ 1482.647504] kprobe at fffffe00000b7b34 unregistered
>> [ 1482.687506] kprobe at fffffe000032d34c unregistered
>> [ 1482.692361] y = 42
>> [ 1482.694361] z = 0
>> # grep \ int_sqrt$ /proc/kallsyms
>> fffffe000032d34c T int_sqrt
>> # grep \ do_fork$ /proc/kallsyms
>> fffffe00000b7b34 T do_fork
>>
> 
> I actually have been doing exactly the same thing.  I was not able to provoke a failure in either the pre or post handler when having them call to another kprobe'd (dummy) function.  However it does look to me like it's reentering the exception handler firstly at the second software breakpoint and then (shortly after returning from that) with a single-step.   That's what you would expect but I *thought* neither of those cases was allowed.  It does not call either the pre or post handler in the dummy function.  I would expect this to be an issue for a kretprobe pre handler too, although I've yet to test this.
> 

Hi Dave,

That is a good point. If the kprobe machinery disables the kretprobe handler because of reentry, that would be problem.  The kretprobe handler always has to fix up the return address, no exceptions.  The patch with the direct call to the trampoline handler would avoid these possible kprobe handler disables.  Could the skipping of the kretprobe trampoline handler be triggered by putting a kprobe on a "ret" instruction that is in a kretprobe'd function?  Is there any functions in the arm64 kernel memory that end up being a stub with just a return instruction in the memory management code?  Something similar to the following routines:

fffffe0000090e10 <calibration_delay_done>:
fffffe0000090e10:       d65f03c0        ret

or

fffffe0000094aac <exit_thread>:
fffffe0000094aac:       d65f03c0        ret



-Will


>>>
>>>>   As Dave
>>>> mentioned the proposed trampoline patch avoids using a kprobe in the
>>>> trampoline and directly calls the trampoline handler.  Attached is the
>>>> current version of the patch which was able to run the systemtap testsuite.
>>>>   Systemtap does exercise the kprobe/kretprobe infrastructure, but it would
>>>> be good to have additional raw kprobe tests to check that kprobe reentry
>>>> works as expected.
>>>
>>> Actually, Will's patch looks like the same thing what I did on x86,
>>> as the kretprobe-booster. So I'm OK for that. But if the above problem
>>> is not solved, we need to fix that, since kprobes can be used from
>>> different sources.
>>
>> The patch should look similar to the x86 code. The x86 code was used as a model.
>>
>> -Will
>>
> 
