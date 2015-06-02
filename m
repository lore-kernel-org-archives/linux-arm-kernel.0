From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 09:38:04 +0100
Subject: [PATCH] ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump
 available
In-Reply-To: <XNM1$3$0$0$$3$3$3$A$0000051U556d3fe3@hitachi.com>
References: <20150529053844.31162.43927.stgit@arietta>
 <20150529083339.GG2067@n2100.arm.linux.org.uk>
 <XNM1$3$0$0$$3$3$3$A$0000051U556d3fe3@hitachi.com>
Message-ID: <20150602083804.GX2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 02:32:19PM +0900, hiraku.toyooka.gu at hitachi.com wrote:
> Before kexec soft reboot, secondary CPU's IRQs except for per-cpu twd are
> migrated from a CPU going offline to CPU0 by migrate_irqs(). The twd is
> stopped by twd_timer_cpu_notify(). As a result, secondary CPU has no
> interrupt source before entering WFI loop.

I wasn't thinking of SPIs and PPIs, but SGIs - the IPI interrupts coming
from the boot CPU.

> After staring kexec'd kernel, all interrupts are sent to CPU0 by default
> and CPU0 resets the secondary CPUs in socfpga_boot_secondary().
> I think it's the reason why kexec in socfpga succeeds.

If you have a way to reset CPU0, why are you not using this for hotplug
when a CPU is hot-unplugged?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
