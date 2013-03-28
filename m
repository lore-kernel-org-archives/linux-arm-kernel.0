From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Mar 2013 15:22:55 +0000
Subject: [PATCHv3 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <1363198676-30417-4-git-send-email-sboyd@codeaurora.org>
References: <1363198676-30417-1-git-send-email-sboyd@codeaurora.org>
 <1363198676-30417-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130328152255.GD30477@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This works on my A9x4 coretile, bringing CPUs up and down via
/sys/devices/system/cpu/*/online, so:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Otherwise, is there any reason we couldn't now use the twd driver on a UP
system? Or would the overhead of handling frequency change make this pointless?

On Wed, Mar 13, 2013 at 06:17:49PM +0000, Stephen Boyd wrote:
> Separate the smp_twd timers from the local timer API. This will
> allow us to remove ARM local timer support in the near future and
> gets us closer to moving this driver to drivers/clocksource.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Changes since v2:
>  * Fix booting on qemu and omap
> 
>  arch/arm/Kconfig          |  2 +-
>  arch/arm/kernel/smp_twd.c | 64 +++++++++++++++++++++++++++++++----------------
>  2 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5b71469..5ad2ccf 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1527,6 +1527,7 @@ config SMP
>  	depends on HAVE_SMP
>  	depends on MMU
>  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> +	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)

Could you not depend on your "Push selects for TWD/SCU into machine entries"
for this?

Mark.
