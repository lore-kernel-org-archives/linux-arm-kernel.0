From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2016 15:32:03 +0100
Subject: [PATCH v6 4/4] arm/arm64: arch_timer: Use archdata to indicate
 vdso suitability
In-Reply-To: <1474533318-7796-4-git-send-email-oss@buserror.net>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
 <1474533318-7796-4-git-send-email-oss@buserror.net>
Message-ID: <20160923143203.GZ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It helps to add the appropriate people to your email if you want to get
a change into the kernel.  Will has had to point this message out to me.

On Thu, Sep 22, 2016 at 03:35:18AM -0500, Scott Wood wrote:
> Instead of comparing the name to a magic string, use archdata to
> explicitly communicate whether the arch timer is suitable for
> direct vdso access.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/include/asm/clocksource.h   |  8 ++++++++
>  arch/arm/kernel/vdso.c               |  2 +-
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/clocksource.h |  8 ++++++++
>  arch/arm64/kernel/vdso.c             |  2 +-
>  drivers/clocksource/arm_arch_timer.c | 11 +++--------
>  7 files changed, 23 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/include/asm/clocksource.h
>  create mode 100644 arch/arm64/include/asm/clocksource.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a9c4e48..b2113c2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1,6 +1,7 @@
>  config ARM
>  	bool
>  	default y
> +	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> diff --git a/arch/arm/include/asm/clocksource.h b/arch/arm/include/asm/clocksource.h
> new file mode 100644
> index 0000000..0b350a7
> --- /dev/null
> +++ b/arch/arm/include/asm/clocksource.h
> @@ -0,0 +1,8 @@
> +#ifndef _ASM_CLOCKSOURCE_H
> +#define _ASM_CLOCKSOURCE_H
> +
> +struct arch_clocksource_data {
> +	bool vdso_direct;	/* Usable for direct VDSO access? */
> +};
> +
> +#endif
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index 994e971..a0affd1 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -270,7 +270,7 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
>  	if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
>  		return false;
>  
> -	if (strcmp(tk->tkr_mono.clock->name, "arch_sys_counter") != 0)
> +	if (!tk->tkr_mono.clock->archdata.vdso_direct)
>  		return false;
>  
>  	return true;

For the ARM bits: 

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
