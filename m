From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 24 Jan 2010 20:42:33 +0000
Subject: [PATCH] spinlock: don't use deprecated barriers on ARMv7
In-Reply-To: <1263397536-15736-1-git-send-email-rabin@rab.in>
References: <1263397536-15736-1-git-send-email-rabin@rab.in>
Message-ID: <20100124204233.GA25665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 09:15:36PM +0530, Rabin Vincent wrote:
> On ARMv7, the use of the cp15 operations for barriers is deprecated in
> favour of the isb, dsb, and dmb instructions.  Change the locking
> functions to use the appropriate type of dsb for the architecture being
> built for.

Umm...

> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 058e7e9..0b371ba 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -164,6 +164,14 @@ extern unsigned int user_debug;
>  #define set_mb(var, value)	do { var = value; smp_mb(); } while (0)
>  #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
>  
> +static inline void smp_sev(void)
> +{
> +#if defined(CONFIG_SMP) && defined(CONFIG_CPU_32v6K)
> +	dsb();
> +	__asm__ __volatile__ ("sev" : : : "memory");

Why are you introducing a compiler memory barrier where there was none
before?
