From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Apr 2015 13:49:14 +0100
Subject: [v3 2/5] arm64: kvm: allow EL2 context to be reset on shutdown
In-Reply-To: <55276A7E.1080508@linaro.org>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
 <20150408130520.GB5977@leverpostej> <552605CD.7000704@linaro.org>
 <20150409150244.GG9648@leverpostej> <55276A7E.1080508@linaro.org>
Message-ID: <20150415124913.GF2866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What I don't understand is why we can't move the init and tear-down
> > functions into kvm_arch_hardware_enable/disable(). They seem to be for
> > precisely what you are implementing, with the only difference being the
> > time that they are called.
> 
> I don't know, neither. I just followed the discussions between Marc and Geoff,
> and their conclusion. I guessed that *refactoring* might be more complicated than
> expected.
> 
> FYI, I gave a quick try to kvm_arch_hardware_enable() approach by removing
> cpu_init_hyp_mode() from init_hyp_mode() and putting it into kvm_arch_hardware_enable(),
> and it seems to work, at least, in my environment:
>     boot => start a kvm guest => kexec reboot => start a kvm guest

That sounds pretty convincing to me, assuming you wired the teardown
intp kvm_arch_hardware_disable() ?

> > Either I'm missing something, or we can simply implement the existing
> > hooks. I assume I'm missing something.
> 
> Marc, Geoff, any comments?
> 
> 
> >>>> +static struct notifier_block kvm_reboot_nb = {
> >>>> +	.notifier_call		= kvm_reboot_notify,
> >>>> +	.next			= NULL,
> >>>> +	.priority		= 0, /* FIXME */
> >>>
> >>> It would be helpful for the comment to explain why this is wrong, and
> >>> what needs fixing.
> >>
> >> Thank for reminding me of this.
> >>
> >> *priority* enforces a calling order of registered hook functions.
> >> If some hook returns NOTIFY_STOP_MASK, subsequent hooks won't be called.
> >> (Nevertheless, reboot sequence will go ahead. See kernel_restart_prepare()/
> >> notifier_call_chain().)
> >>
> >> So we should make sure that kvm_reboot_notify() be called
> >> 1) after any hook functions which may depend on kvm, and
> >
> > Which hooks depend on KVM?
> 
> I think I answered this question below:
>  >> But how can we guarantee this and determine a priority of kvm_reboot_notify()?
>  >> Looking into all the occurrences of register_reboot_notifier(),
>  >> 1) => nothing
>  >> 2) => virt/kvm/kvm_main.c (priority: 0)
>  >> 3) => drivers/cpufreq/s32416-cpufreq.c (priority: 0)
>  >>        drivers/cpufreq/s5pv210-cpufreq.c (priority: 0)
>  >>
>  >> So a priority higher than zero might be safe and better, but exactly what?
>  >> Some hooks use "INT_MAX."

I can't see anything listed which has a dependency on KVM.

The KVM notifier would be superseded by
kvm_arch_hardware_{disable,enable}, and the cpufreq instances don't seem
to have any relationship to KVM.

Other architectures use kvm_arch_hardware_{enable,disable}(), so I
imagine the core KVM code has no problem with the ordering of these.

Mark.
