From: gdavis@mvista.com (George G. Davis)
Date: Wed, 10 Nov 2010 23:41:25 -0500
Subject: arm smp support patch
In-Reply-To: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
Message-ID: <20101111044125.GA5850@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 01:33:20PM -1000, Scott Valentine wrote:
> On arm multi-core platforms that have a gic, the secondary cores fail to
> wake if they are booted in WFI mode, as the gic_dist_init disables all
> interrupts including IPI. I've included a simple patch to the
> gic_dist_init function that enables interrupts 0-15 on SMP enabled
> systems. This patch was made against linux-2.6-HEAD-151f52f.
> 
> 
> diff -uNr a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> --- a/arch/arm/common/gic.c     2010-11-05 15:57:04.000000000 -1000
> +++ b/arch/arm/common/gic.c     2010-11-09 13:08:33.000000000 -1000
> @@ -262,6 +262,13 @@
>         for (i = 0; i < max_irq; i += 32)
>                 writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 /
> 32);
> 
> +#ifdef CONFIG_SMP
> +       /*
> +        * Enable IPI interrupts on SMP systems so we can wake secondary
> cores
> +        */
> +       writel(0x0000ffff, base + GIC_DIST_ENABLE_SET);

The ARM11 MPCore TRM [1] states "Interrupts 0-15 fields are read as one,
that is, always enabled, and write to these fields have no effect."  So
it seems odd that this is needed.  Errata?  FWIW, I've peeked and poked
at GIC_DIST_ENABLE_SET and GIC_DIST_ENABLE_CLEAR via a debugger and the
16 LSBs of both of these registers are stuck-at-one on my ARM11 MPCore
r1p0.

--
Regards,
George

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0360f/CCHGFFFA.html

> +#endif
> +
>         /*
>          * Setup the Linux IRQ subsystem.
>          */
> 
> 
> 
> 
> 
> NOTES:
> 
> After browsing through the Kconfigs, I am confident that this will only
> affect the following platforms (which have ARM_GIC and SMP):
> MACH_REALVIEW, ARCH_OMAP4, ARCH_S5PV310, ARCH_VEXPRESS_CA9X4, ARCH_U8500,
> and ARCH_TEGRA_2x_SOC. The TEGRA_2x appears to use a diffent smp-boot
> mechanism, however. The patch was tested successfully on MACH_CNS3XXX
> using the bsp for the gateworks laguna platform
> (http://svn.gateworks.com/bsp/laguna/trunk/openwrt_patches).
> 
> 
> Scott Valentine
> 
> Concentris Systems LLC
> Manoa Innovation Center, Suite #238
> 2800 Woodlawn Drive
> Honolulu, HI  96822
> 
> http://www.Concentris-Systems.com
> 
> (808) 988-6100
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
