From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 02 Feb 2015 17:18:19 +0900
Subject: [PATCH 7/8] arm64/kexec: Add checks for KVM
In-Reply-To: <1422647304.21823.31.camel@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>	
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>	
 <20150126191942.GQ23313@leverpostej> <54CA041C.6020403@linaro.org>	
 <54CA12A1.8090508@arm.com> <20150129184747.GV17721@leverpostej>	
 <54CB206D.7040705@linaro.org> <1422647304.21823.31.camel@infradead.org>
Message-ID: <54CF32CB.1060507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geoff,

On 01/31/2015 04:48 AM, Geoff Levand wrote:
> Hi Takahiro.
>
> On Fri, 2015-01-30 at 15:10 +0900, AKASHI Takahiro wrote:
>> Initially, I thought that we would define kvm_arch_exit() and call it
>> somewhere in the middle of kexec path (no idea yet).
>> But Geoff suggested me to implement a new hvc call, HVC_CPU_SHUTDOWN(??),
>> and make it called via cpu_notifier(CPU_DYING_FROZEN) initiated by
>> machine_shutdown() from kernel_kexec().
>
> As an initial implementation we can hook into the CPU_DYING_FROZEN
> notifier sent to hyp_init_cpu_notify().  The longer term solution
> should use kvm_arch_hardware_enable() and kvm_arch_hardware_disable().

Are these two different approaches? I mean,
kexec will initiate cpu hotplug:
kernel_exec() -> machine_shutdown() -> disable_nonboot_cpu()
    -> _cpu_down() -> cpu_notify_nofail(CPU_DEAD|...)

On the other hand, kvm already has a hook into kvm_arch_hardware_disable():
   (ignoring kvm_usage_count here)
kvm_cpu_hotplug(CPU_DYING) -> hardware_disable()
    -> hardware_disable_nolock() -> kvm_arch_hardware_disable()

So it seems that we don't have to add a new hook at hyp_init_cpu_notify()
if kvm_arch_hardware_disable() is properly implemented.
disable_nonboot_cpu() will not inovke cpu hotplug on *boot* cpu, and
we should handle it in a separate way though.

Do I misunderstand anything here?


-Takahiro AKASHI

> The calls to cpu_notifier(CPU_DYING_FROZEN) are part of cpu hot
> plug, and independent of kexec.  If someone were to add spin-table
> cpu un-plug, then it would be used for that also.  It seems we should
> be able to test without kexec by using cpu hot plug.
>
> To tear down KVM you need to get back to hyp mode, and hence
> the need for HVC_CPU_SHUTDOWN.  The sequence I envisioned would
> be like this:
>
> cpu_notifier(CPU_DYING_FROZEN)
>   -> kvm_cpu_shutdown()
>      prepare for hvc
>      -> HVC_CPU_SHUTDOWN
>         now in hyp mode, do KVM tear down, restore default exception vectors
>
> Once the default exception vectors are restored soft_restart()
> can then execute the cpu_reset routine in EL2.
>
> Some notes are here for those with access:  https://cards.linaro.org/browse/KWG-611
>
> -Geoff
>
