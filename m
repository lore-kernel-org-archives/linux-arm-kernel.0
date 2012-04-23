From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 10:46:39 +0100
Subject: [PATCH v4 2/3] Cortex-M3: Add base support for Cortex-M3
In-Reply-To: <1333573807-23709-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120404210838.GA23126@pengutronix.de>
 <1333573807-23709-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120423094639.GK24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 11:10:06PM +0200, Uwe Kleine-K?nig wrote:
> diff --git a/arch/arm/include/asm/irqflags.h b/arch/arm/include/asm/irqflags.h
> index 1e6cca5..ac4d548 100644
> --- a/arch/arm/include/asm/irqflags.h
> +++ b/arch/arm/include/asm/irqflags.h
> @@ -10,6 +10,18 @@
>   */
>  #if __LINUX_ARM_ARCH__ >= 6
>  
> +#ifdef CONFIG_CPU_V7M
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +	unsigned long flags;
> +
> +	asm volatile(
> +		"	mrs	%0, primask	@ arch_local_irq_save\n"
> +		"	cpsid	i"
> +		: "=r" (flags) : : "memory", "cc");

Wouldn't it produce a smaller patch to define something for "primask"
vs "cpsr", rather than having to re-implement the entire function ?

> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index 451808b..696bbf4 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -39,16 +39,25 @@
>  #define FIQ26_MODE	0x00000001
>  #define IRQ26_MODE	0x00000002
>  #define SVC26_MODE	0x00000003
> +#ifndef CONFIG_CPU_V7M
>  #define USR_MODE	0x00000010
> +#define SVC_MODE	0x00000013
> +#else
> +#define USR_MODE	0x00000000
> +#define SVC_MODE	0x00000000
> +#endif

Note that these definitions are exported to userspace.  Do we want to expose
this kind of change there?

>  #define FIQ_MODE	0x00000011
>  #define IRQ_MODE	0x00000012
> -#define SVC_MODE	0x00000013
>  #define ABT_MODE	0x00000017
>  #define UND_MODE	0x0000001b
>  #define SYSTEM_MODE	0x0000001f
>  #define MODE32_BIT	0x00000010
>  #define MODE_MASK	0x0000001f
> +#ifndef CONFIG_CPU_V7M
>  #define PSR_T_BIT	0x00000020
> +#else
> +#define PSR_T_BIT	0x01000000
> +#endif

Ditto.  Note also that these bits changing will be visible via the pt_regs
to userspace too.  Maybe overloading these constants like this and making
them depend on the kernel configuration is not a good idea for userspace.

Maybe giving the V7M definitions a new prefix would be a better idea?
