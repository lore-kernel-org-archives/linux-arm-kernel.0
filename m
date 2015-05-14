From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 14 May 2015 09:01:03 +0900
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <555370B9.2070203@redhat.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com> <553AB222.50609@redhat.com>
 <553EF74D.8020706@redhat.com> <20150429102346.GK8236@arm.com>
 <55442BFA.50101@redhat.com> <554851CB.2010909@linaro.org>
 <20150505154830.GI1550@arm.com> <55519583.9020507@linaro.org>
 <5551F693.8050100@redhat.com> <555317E8.2000502@hitachi.com>
 <555370B9.2070203@redhat.com>
Message-ID: <5553E5BF.2020602@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/05/14 0:41, William Cohen wrote:
> On 05/13/2015 05:22 AM, Masami Hiramatsu wrote:
>> On 2015/05/12 21:48, William Cohen wrote:
> 
>>> Hi Dave,
>>>
>>> In some of the previous diagnostic output it looked like things would go wrong
>>> in the entry.S when the D bit was cleared and the debug interrupts were 
>>> unmasksed.  I wonder if some of the issue might be due to the starting the 
>>> kprobe for the trampoline, but leaving things in an odd state when another
>>> set of krpobe/kretporbes are hit when the trampoline is running.
>>
>> Hmm, does this mean we have a trouble if a user kprobe handler calls the
>> function which is probed by other kprobe? Or, is this just a problem
>> only for kretprobes?
> 
> Hi Masami,
> 
> I wrote an example based off of sample/kprobes/kprobes_sample.c to force 
> the reentry issue for kprobes (the attached kprobe_rentry_example.c). That
> seemed to run fine.  I think the reason that the trampoline handler got 
> into trouble is because of the reset_current_kprobe() before the possible
> call to kfree, but I haven't verified it.

I still doubt about kfree() reentrant call, since kretprobe handler only
calls recycle_rp_inst() which doesn't free the instance but just push it back
to the unused instance list.

> It seems like that should be at the end of trampoline handler just before
> the return.  Other architectures have similar trampoline handlers,
> so I am surprised that the other architectures haven't encountered this
> issue with kretprobes.  Maybe this is due to specific of arm64 exception
> handling.

Ah, indeed the reset_current_kprobe() here seems not good since some
interruption or some other reason, another kprobes can be hit before
returning.

If kprobes can handle reentered probes correctly, I think your patch
(directly branch from trampoline) looks good to fix this problem.
Actually, arm32 and x86 already has same method.

It seems that powerpc will have similar issue, does someone checked
that? Ananth?

Thank you,

> 
> # modprobe kprobe_reentry_example
> [  909.617295] Planted kprobe at fffffe00000b7b34
> [  909.623873] Planted kprobe at fffffe000032d34c
> # rmmod kprobe_reentry_example
> [ 1482.647504] kprobe at fffffe00000b7b34 unregistered
> [ 1482.687506] kprobe at fffffe000032d34c unregistered
> [ 1482.692361] y = 42
> [ 1482.694361] z = 0
> # grep \ int_sqrt$ /proc/kallsyms 
> fffffe000032d34c T int_sqrt
> # grep \ do_fork$ /proc/kallsyms 
> fffffe00000b7b34 T do_fork
> 
>>
>>>  As Dave
>>> mentioned the proposed trampoline patch avoids using a kprobe in the
>>> trampoline and directly calls the trampoline handler.  Attached is the
>>> current version of the patch which was able to run the systemtap testsuite.
>>>  Systemtap does exercise the kprobe/kretprobe infrastructure, but it would
>>> be good to have additional raw kprobe tests to check that kprobe reentry
>>> works as expected.
>>
>> Actually, Will's patch looks like the same thing what I did on x86,
>> as the kretprobe-booster. So I'm OK for that. But if the above problem
>> is not solved, we need to fix that, since kprobes can be used from
>> different sources.
> 
> The patch should look similar to the x86 code. The x86 code was used as a model.
> 
> -Will
> 


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt at hitachi.com
