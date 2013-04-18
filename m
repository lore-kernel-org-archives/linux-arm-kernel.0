From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Apr 2013 11:10:19 +0200
Subject: [PATCHv2 2/3] ARM: Detect support for SDIV/UDIV from ISAR0
 register
In-Reply-To: <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130418091019.GA21099@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On Mon, Mar 18, 2013 at 11:28:56AM -0700, Stephen Boyd wrote:
> The ISAR0 register indicates support for the SDIV and UDIV
> instructions in both the Thumb and ARM instruction set. Read the
> register to detect the supported instructions and update the
> elf_hwcap mask as appropriate. This is better than adding more
> and more cpuid checks in proc-v7.S for each new cpu variant that
> supports these instructions.
you pointed out yesterday that this could work on v7-m, too. As I based
my patches on 3.9-rc1 this patch (8164f7af88) wasn't included. When
updating this results in a warning, because I have

	6ebd4d0 (ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n)

from rmk's devel-stable branch.
 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/kernel/setup.c | 20 ++++++++++++++++++++
>  arch/arm/mm/proc-v7.S   |  4 ++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e2c8bbf..f3ac13f 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -353,6 +353,23 @@ void __init early_print(const char *str, ...)
>  	printk("%s", buf);
>  }
>  
> +static void __init cpuid_init_hwcaps(void)
> +{
> +	unsigned int divide_instrs;
> +
> +	if (cpu_architecture() < CPU_ARCH_ARMv7)
> +		return;
> +
> +	divide_instrs = (read_cpuid_ext(CPUID_EXT_ISAR0) & 0x0f000000) >> 24;
The problem is that read_cpuid_ext is called which doesn't map to
something useful for v7-m. So maybe add a check:

	if (!IS_ENABLED(CONFIG_CPU_CP15))
		return;

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
