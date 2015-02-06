From: geoff@infradead.org (Geoff Levand)
Date: Thu, 05 Feb 2015 23:06:26 -0800
Subject: [PATCH 7/8] arm64/kexec: Add checks for KVM
In-Reply-To: <54D440AD.2030608@linaro.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
 <20150126191942.GQ23313@leverpostej> <54CA041C.6020403@linaro.org>
 <54CA12A1.8090508@arm.com> <20150129184747.GV17721@leverpostej>
 <54CB206D.7040705@linaro.org> <1422647304.21823.31.camel@infradead.org>
 <54CF32CB.1060507@linaro.org> <1423181494.16019.2.camel@infradead.org>
 <54D440AD.2030608@linaro.org>
Message-ID: <1423206386.10035.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-02-06 at 13:18 +0900, AKASHI Takahiro wrote:
> On 02/06/2015 09:11 AM, Geoff Levand wrote:
> > Hi Takahiro,
> >
> > On Mon, 2015-02-02 at 17:18 +0900, AKASHI Takahiro wrote:
> >> On 01/31/2015 04:48 AM, Geoff Levand wrote:
> >>> As an initial implementation we can hook into the CPU_DYING_FROZEN
> >>> notifier sent to hyp_init_cpu_notify().  The longer term solution
> >>> should use kvm_arch_hardware_enable() and kvm_arch_hardware_disable().
> >>
> >> Are these two different approaches?
> >
> > Yes, these are two different solutions,  One initial work-around, and a
> > more involved proper solution.  Hooking into the CPU_DYING_FROZEN
> > notifier would be a initial fix.  The proper solution would be to move
> > the KVM setup to kvm_arch_hardware_enable(), and the shutdown to
> > kvm_arch_hardware_disable().
> >
> >
> >> kernel_exec() -> machine_shutdown() -> disable_nonboot_cpu()
> >>      -> _cpu_down() -> cpu_notify_nofail(CPU_DEAD|...)
> >>
> >> On the other hand, kvm already has a hook into kvm_arch_hardware_disable():
> >>     (ignoring kvm_usage_count here)
> >> kvm_cpu_hotplug(CPU_DYING) -> hardware_disable()
> >>      -> hardware_disable_nolock() -> kvm_arch_hardware_disable()
> >>
> >> So it seems that we don't have to add a new hook at hyp_init_cpu_notify()
> >> if kvm_arch_hardware_disable() is properly implemented.
> >
> > Yes, that is correct.  But, as above, you would also need to update the
> > KVM startup to use kvm_arch_hardware_enable().
> >
> >> disable_nonboot_cpu() will not inovke cpu hotplug on *boot* cpu, and
> >> we should handle it in a separate way though.
> >
> > IIRC, the secondary cpus go through PSCI on shutdown, and that path
> > is working OK.  Maybe I am mistaken though.
> 
> If so, why should we add a hook at hyp_init_cpu_notify() as initial work-around?

To tear down KVM on the primary cpu.

> > The primary cpu shutdown (hyp stubs restored) is what is missing.  The
> > primary cpu goes through cpu_soft_restart(), and that is what is
> > currently failing.
> 
> Yeah, we will call teardown function manually in soft_restart();

I think the KVM tear down should happen independent of soft_restart().
When soft_restart() is called, KVM should have already been torn down.

-Geoff
