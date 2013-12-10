From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 10 Dec 2013 16:43:56 +0800
Subject: [PATCH] ARM: pxa: prevent PXA270 occasional reboot freezes
In-Reply-To: <1386650355-2503-1-git-send-email-ynvich@gmail.com>
References: <1386650355-2503-1-git-send-email-ynvich@gmail.com>
Message-ID: <52A6D44C.1010504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 12:39 PM, Sergei Ianovich wrote:
> Erratum 71 of PXA270M Processor Family Specification Update
> (April 19, 2010) explains that watchdog reset time is just
> 8us insead of 10ms in EMTS.
>
> If SDRAM is not reset, it causes memory bus congestion and
> the device hangs. We put SDRAM in selfresh mode before watchdog
> reset, removing potential freezes.
>
> Without this patch PXA270-based ICP DAS LP-8x4x hangs after up to 40
> reboots. With this patch it has successfully rebooted 500 times.
>
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> ---
>   arch/arm/mach-pxa/reset.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
> index 0d5dd64..263b152 100644
> --- a/arch/arm/mach-pxa/reset.c
> +++ b/arch/arm/mach-pxa/reset.c
> @@ -13,6 +13,7 @@
>
>   #include <mach/regs-ost.h>
>   #include <mach/reset.h>
> +#include <mach/smemc.h>
>
>   unsigned int reset_status;
>   EXPORT_SYMBOL(reset_status);
> @@ -81,6 +82,12 @@ static void do_hw_reset(void)
>   	writel_relaxed(OSSR_M3, OSSR);
>   	/* ... in 100 ms */
>   	writel_relaxed(readl_relaxed(OSCR) + 368640, OSMR3);
> +	/*
> +	 * SDRAM hangs on watchdog reset on Marvell PXA270 (erratum 71)
> +	 * we put SDRAM into self-refresh to prevent that
> +	 */
> +	while (1)
> +		writel_relaxed(MDREFR_SLFRSH, MDREFR);
>   }
>
>   void pxa_restart(enum reboot_mode mode, const char *cmd)
> @@ -104,4 +111,3 @@ void pxa_restart(enum reboot_mode mode, const char *cmd)
>   		break;
>   	}
>   }
> -
>

Hi Daniel/Marek/Igor,

Could you help to try this patch? I'm lack of PXA27x board.

Best Regards
Haojian
