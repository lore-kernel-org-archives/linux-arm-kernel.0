From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 22 Jul 2011 11:05:01 +0530
Subject: [PATCH 0/4] Fix CPU hotplug IRQ migration
In-Reply-To: <20110721151413.GD28942@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
Message-ID: <4E290C05.7020209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Colin,

On 7/21/2011 8:44 PM, Russell King - ARM Linux wrote:
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
Firstly thanks for fixing the IRQ migration and affinity issues
with hotplug code. Colin found the hotplug irq affinity issue
last week.

Colin quoted ..
----------------------------------
The irq affinity mask is not kept up to date by the ARM irq
code.  In particular, migrate_one_irq is not called when
the irq node does not match the cpu going offline, and
when it is called, it doesn't update the irq affinity
mask before calling the irq chip's set_affinity function.
This causes the use of the affinity mask in the mask
and unmask functions to be unreliable, possibly unmasking
an interrupt on a cpu that is offline.
----------------------------------

Need to check if this series addresses above issue as well.

> With this patch set applied, there is no reason core code can't handle
> CPU0 being offlined - on OMAP4, the only remaining issue is CPU0
> being woken from WFI and falsely passing the non-spurious wake-up test.
There is one as commented in other thread. The Secure code runs only
on CPU0 so if you offline the CPU0, all the secure services are not
available.

Regards
Santosh
