From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jul 2011 09:50:30 +0100
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <20110721151413.GD28942@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
Message-ID: <20110722085030.GA3496@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jul 21, 2011 at 04:14:13PM +0100, Russell King - ARM Linux wrote:
> This series fixes a bunch of issues with IRQ migration:
> 
> 1. Preventing affinity changes causing IRQs to be directed to off-line CPUs.
> 2. Preventing oopses with non-GIC interrupt controllers.
> 3. Preventing per-CPU IRQs being candidates for migration.
> 4. Removing the abuse of irqdesc's node member.
> 
> This prevents crashes on OMAP4430 SDP when non-default IRQ affinity
> settings are used and a CPU which owns some IRQs is offlined.
> 
> With this patch set applied, there is no reason core code can't handle
> CPU0 being offlined - on OMAP4, the only remaining issue is CPU0
> being woken from WFI and falsely passing the non-spurious wake-up test.

I have a related patch that allows the kernel to (in theory) boot on a CPU
other than CPU0. This obviously requires the platform code to be able to
deal with that, but it seems to work fine on my RealView-PBX board booting
on CPU1.

The use case I have for this is making the kexec syscall on a CPU with ID !=
0. This CPU will end up becoming the boot CPU in the kexec'd kernel so you
have to do a bit of tweaking to make sure the thread_info->cpu is correct in
order to boot.

I'll post after the merge window.

Will
