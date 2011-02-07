From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 7 Feb 2011 15:21:44 +0530
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
In-Reply-To: <20110204113053.GF15004@n2100.arm.linux.org.uk>
References: <20110125114635.GB13300@n2100.arm.linux.org.uk>
	<236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
	<20110125121655.GD13300@n2100.arm.linux.org.uk>
	<4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
	<20110125125656.GG13300@n2100.arm.linux.org.uk>
	<20110125130422.GH13300@n2100.arm.linux.org.uk>
	<20110125130611.GA15663@n2100.arm.linux.org.uk>
	<627ff975140c8e4afbad281105b29d35@mail.gmail.com>
	<20110204104113.GD15004@n2100.arm.linux.org.uk>
	<c703383234131695d040a1e5b8a79413@mail.gmail.com>
	<20110204113053.GF15004@n2100.arm.linux.org.uk>
Message-ID: <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, February 04, 2011 5:01 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas at arm.com; linus.ml.walleij at gmail.com; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> ccross at android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
[.....]

> 8<------
> Subject: [PATCH] ARM: smp: add function to set WFI low-power mode
> for SMP CPUs
>
> Add a function to set the SCU low-power mode for SMP CPUs.  This
> centralizes this functionality rather than having to expose the
> SCU register definitions to each platform.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/smp_scu.h |    5 +++++
>  arch/arm/kernel/smp_scu.c      |   24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 0 deletions(-)
>

[....]

> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index 9ab4149..0ba329a 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -50,3 +50,27 @@ void __init scu_enable(void __iomem *scu_base)
>  	 */
>  	flush_cache_all();
>  }
> +
> +/*
> + * Set the executing CPUs power mode as defined.  This will be in
> + * preparation for it executing a WFI instruction.
> + *
> + * This function must be called with preemption disabled, and as it
> + * has the side effect of disabling coherency, caches must have
> been
> + * flushed.  Interrupts must also have been disabled.
> + */
> +int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> +{
> +	unsigned int val;
> +	int cpu = smp_processor_id();
> +	int shift;
shift is unused with this version now so I am removing it.

> +
> +	if (mode > 3 || mode == 1 || cpu > 3)
> +		return -EINVAL;
> +
> +	val = __raw_readb(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
> +	val |= mode;
> +	__raw_writeb(val, scu_base + SCU_CPU_STATUS + cpu);
> +
> +	return 0;
> +}
> --
> 1.6.2.5
