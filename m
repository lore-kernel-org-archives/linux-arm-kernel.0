From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 27 Aug 2015 17:15:03 -0500
Subject: [PATCH v3 15/31] arm64: SMP support
In-Reply-To: <55DB0A8B.3090700@linaro.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
 <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
 <20150806095621.GB17691@e104818-lin.cambridge.arm.com>
 <55C8843D.8050600@linaro.org> <55C8D9DB.5080207@codeaurora.org>
 <55D7559E.8080609@codeaurora.org> <55DB0A8B.3090700@linaro.org>
Message-ID: <55DF8BE7.2090102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2015 07:14 AM, Hanjun Guo wrote:

>> Actually, I think we need to keep it.  I just heard from another
>> developer who does actually use it for debugging.
>
> Hmm, could you please give a example for how it used?

For KVM guests, it's handy to know what the guests were doing when the 
guest crashes.  However, I still think we should quiesce the stack dumps 
by default.

>> I think the real problem is that emergency_restart() should not be
>> causing these outputs.  Shouldn't machine_restart() change the
>> system_state to SYSTEM_RESTART before it calls smp_send_stop()?
>
> The system_state is set to SYSTEM_RESTART in kernel_restart_prepare(),
> and kernel_restart() will call kernel_restart_prepare() and
> machine_restart(), so if we change the system_state to SYSTEM_RESTART
> in machine_restart(), it seems duplicate.

I don't see where emergency_restart() ever calls 
kernel_restart_prepare().  Here's the call chain:

emergency_restart
machine_emergency_restart
machine_restart
efi_reboot

I don't see where kernel_restart_prepare() is actually called in this chain.

kernel_restart() calls kernel_restart_prepare() and then calls 
machine_restart().  Perhaps machine_emergency_restart() also needs to 
call. kernel_restart_prepare() before calling machine_restart()?  Either 
that, or machine_emergency_restart() needs to manually set system_state 
is set to SYSTEM_RESTART.

  static inline void machine_emergency_restart(void)
  {
+	system_state = SYSTEM_RESTART;
  	machine_restart(NULL);
  }

> Could we just wait longer than one second in the following function?
>
> void smp_send_stop(void)
> {
>          unsigned long timeout;
>
>          if (num_online_cpus() > 1) {
>                  cpumask_t mask;
>
>                  cpumask_copy(&mask, cpu_online_mask);
>                  cpumask_clear_cpu(smp_processor_id(), &mask);
>
>                  smp_cross_call(&mask, IPI_CPU_STOP);
>          }
>
>          /* Wait up to one second for other CPUs to stop */
>          timeout = USEC_PER_SEC;
>          while (num_online_cpus() > 1 && timeout--)
>                  udelay(1);
>
> If we have lots of CPUs, one second seems not enough as it
> print lots dump message.

Yes, that's what we do internally.  However, as the number of cores is 
increased, the problem gets worse.  The default maximum cores is 64, so 
it just seems like this problem is going to get worse and worse as the 
core count grows.  I believe a large core count is going to be standard 
modus operandi for ARM64 servers.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
