From: zyy@motorola.com (Yuanyuan ZHONG)
Date: Fri, 11 Oct 2013 11:12:19 -0500
Subject: [PATCH] arm: vfp: always clear vfp_current_hw_state when forcing
 reload
In-Reply-To: <20131011120729.GW25034@n2100.arm.linux.org.uk>
References: <1380751187-11257-1-git-send-email-zyy@motorola.com>
 <20131002221123.GC12758@n2100.arm.linux.org.uk>
 <CAFUV4K3dsVDtHhQtuZ6yEQHxxHXaa9LODBZuGFipjAKumF4abQ@mail.gmail.com>
 <CAFUV4K1CkzGZVEwkXGX38jG0HxerqQq--d-qFiqF9J6wi88xYQ@mail.gmail.com>
 <20131011120729.GW25034@n2100.arm.linux.org.uk>
Message-ID: <CAFUV4K3de3p9jP1Oo=cafEuu64YmEzBXrAiiRWUauy0VeCEQ5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 7:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 10, 2013 at 11:00:18AM -0500, Yuanyuan ZHONG wrote:
>> Hi Russell, et al
>>
>> If there is no further comments, I'll submit it to patch system.
>> Thanks.
>
> No, I still don't agree with your patch as being the correct fix.  Look
> at the code that you're creating:
>
>         if (vfp_state_in_hw(cpu, thread)) {
>                 fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
>                 vfp_current_hw_state[cpu] = NULL;
>         }
> #ifdef CONFIG_SMP
>         thread->vfpstate.hard.cpu = NR_CPUS;
>         vfp_current_hw_state[cpu] = NULL;
> #endif
>
> So when SMP is enabled we unconditionally blat out the vfp_current_hw_state
> pointer for this CPU?

I think ensuring local vfp_current_hw_state is invalidated is what
vfp_force_reload() need to do when SMP is enabled.

>
> What actually needs fixing is the call to this function in the hotplug
> thread:
>
>                 vfp_force_reload((long)hcpu, current_thread_info());
>
> I'd suggest this becomes:
>
>                 unsigned cpu = (long)hcpu;
>                 if (vfp_current_hw_state[cpu])
>                         vfp_force_reload(cpu, vfp_current_hw_state[cpu]);
>
> That will force the right hw_state to be forced to reload, rather than
> passing in the wrong thread state.

No. This is not right. Look at the other places vfp_force_reload() are
called, they are all using current_thread_info(). I think only
current_thread_info() is safe for vfp_force_reload().
With your suggestion:
(1) vfp_current_hw_state[cpu] is &thread->vfpstate, not thread.
(2) If the thread exited on another CPU and its stack has been
reclaimed and reallocated, the "thread->vfpstate.hard.cpu = NR_CPUS;"
in vfp_force_reload() will cause memory corruption.

Thanks.
