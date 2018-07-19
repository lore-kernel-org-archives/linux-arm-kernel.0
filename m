From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jul 2018 23:55:38 +0100
Subject: [PATCH] ARM64: smp: Fix cpu_up() racing with sys_reboot
In-Reply-To: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
References: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
Message-ID: <20180719225538.GN17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 03:18:46PM -0700, Venkata Narendra Kumar Gutta wrote:
> Nothing stops a process from hotplugging in a CPU concurrently
> with a sys_reboot() call. In such a situation we could have
> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
> fact that the CPU is not really offline and call the
> CPU_UP_PREPARE notifier. When this happens stop_machine code will
> complain that the cpu thread already exists and BUG_ON().
> 
> CPU0                      CPU1
> 
>  sys_reboot()
>  kernel_restart()
>  machine_restart()
>  machine_shutdown()
>  smp_send_stop()
>  ...                   ipi_cpu_stop()
> 		       set_cpu_online(1, false)
>                        local_irq_disable()
>                        while(1)
>         <PREEMPT>
>  cpu_up()
>  _cpu_up()
>  if (!cpu_online(1))
>  __cpu_notify(CPU_UP_PREPARE...)
> 
>  cpu_stop_cpu_callback()
>  BUG_ON(stopper->thread)
> 
> This is easily reproducible by hotplugging in and out in a tight
> loop while also rebooting.
> 
> Since the CPU is not really offline and hasn't gone through the
> proper steps to be marked as such, let's mark the CPU as inactive.
> This is just as easily testable as online and avoids any possibility
> of _cpu_up() trying to bring the CPU back online when it never was
> offline to begin with. Based on the similar patchset by for arm
> targets 040c163( "ARM: smp: Fix cpu_up() racing with sys_reboot)"

You really need to use 12 digit commit IDs to refer to commits to
avoid:

$ git log 040c163
fatal: ambiguous argument '040c163': unknown revision or path not in the working tree.

because 7 digits are just too short and given the size of the kernel,
result in conflicting references.

I can find no trace of "040c163" touching arch/arm/kernel/smp.c,
nor can I find a commit with "racing with sys_reboot" touching the
same file.

The commit you reference doesn't seem to be in mainline.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
