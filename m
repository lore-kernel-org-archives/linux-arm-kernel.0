From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Aug 2012 00:24:02 -0700
Subject: [RFC/PATCH] ARM: smp: Fix cpu_up() racing with sys_reboot
In-Reply-To: <1345608229-5707-1-git-send-email-sboyd@codeaurora.org>
References: <1345608229-5707-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <503DC392.4070904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/2012 9:03 PM, Stephen Boyd wrote:
> Nothing stops a process from hotplugging in a CPU concurrently
> with a sys_reboot() call. In such a situation we could have
> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
> fact that the CPU is not really offline and call the
> CPU_UP_PREPARE notifier. When this happens stop_machine code will
> complain that the cpu thread already exists and BUG_ON().
>
> CPU0                      CPU1
>
> sys_reboot()
>  kernel_restart()
>   machine_restart()
>    machine_shutdown()
>     smp_send_stop()
>     ...                   ipi_cpu_stop()
>                            set_cpu_online(1, false)
>                             local_irq_disable()
>                              while(1)
>     <PREEMPT>
> cpu_up()
>  _cpu_up()
>    if (!cpu_online(1))
>     __cpu_notify(CPU_UP_PREPARE...)
>
> cpu_stop_cpu_callback()
>   BUG_ON(stopper->thread)
>
> This is easily reproducible by hotplugging in and out in a tight
> loop while also rebooting.
>
> Since the CPU is not really offline and hasn't gone through the
> proper steps to be marked as such, let's mark the CPU as inactive.
> This is just as easily testable as online and avoids any possibility
> of _cpu_up() trying to bring the CPU back online when it never was
> offline to begin with.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> Perhaps we can take the hotplug lock in the sys_reboot() case but I
> don't think that actually fixes everything. For example, in cases
> where machine_shutdown() is called from emergency_restart() we would
> have to take the hotplug lock which doesn't really seem feasible.

Any comments on this patch?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
