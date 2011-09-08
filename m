From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 8 Sep 2011 21:16:54 +0200
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAORVsuX0NnDBtLOJwQF-qgo4hq9wp2+d=HcLLtJzYGsuzc_z1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> OMAP WakeupGen is the interrupt controller extension used along
> with ARM GIC to wake the CPU out from low power states on
> external interrupts.
>
> The WakeupGen unit is responsible for generating wakeup event
... for generating the wakeup events
> from the incoming interrupts and enable bits. It is implemented
> in MPU always ON power domain. During normal operation,
in the MPU...
> WakeupGen delivers external interrupts directly to the GIC.
... delivers the external interrupts

>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/mach-omap2/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/include/mach/omap-wakeupgen.h | ? 39 ++++
> ?arch/arm/mach-omap2/omap-wakeupgen.c ? ? ? ? ? ? ?| ?241 +++++++++++++++++++++
> ?arch/arm/mach-omap2/omap4-common.c ? ? ? ? ? ? ? ?| ? ?3 +
> ?4 files changed, 284 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> ?create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
>
...

> + */
> +int __init omap_wakeupgen_init(void)
> +{
> + ? ? ? int i;
> + ? ? ? unsigned int boot_cpu = smp_processor_id();
> +
> + ? ? ? /* Not supported on OMAP4 ES1.0 silicon */
> + ? ? ? if (omap_rev() == OMAP4430_REV_ES1_0) {
> + ? ? ? ? ? ? ? WARN(1, "WakeupGen: Not supported on OMAP4430 ES1.0\n");
> + ? ? ? ? ? ? ? return -EPERM;
> + ? ? ? }
> +
> + ? ? ? /* Static mapping, never released */
> + ? ? ? wakeupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
> + ? ? ? if (WARN_ON(!wakeupgen_base))
> + ? ? ? ? ? ? ? return -ENODEV;
-ENOMEM os required as discussed in the other patches of the series.

Regards,
Jean
