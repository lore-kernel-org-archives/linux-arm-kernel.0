From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 16:13:31 +0800
Subject: [PATCH] ARM: imx: improve the comment of CCM lpm SW workaround
In-Reply-To: <1387908047-1848-1-git-send-email-b20788@freescale.com>
References: <1387908047-1848-1-git-send-email-b20788@freescale.com>
Message-ID: <20131224081329.GF3872@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 01:00:47PM -0500, Anson Huang wrote:
> Improve the comment of SW workaround for CCM lpm issue using
> hardware errata description to avoid confusion.
> 
> TKT194736:

This is not the errata number that will be seen by people publicly.
That's why I did not give it in the original commit d48866f (ARM: imx:
ensure dsm_request signal is not asserted when setting LPM).  But if you
check the log of that commit, you will find we already have the
information you're adding here.

The good thing is we have that errata publicly available now as below.

ERR007265 CCM: When improper low-power sequence is used, the SoC
enters low power mode before the ARM core executes WFI

http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf?fpsp=1

So if you want to make it clear, you should quote the errata info that
is publicly available to people.

Shawn

> Chip will enter low power mode before ARM A9 CPU executes
> WFI when improper low power sequence is used.
> 
> SW workaround:
> 1) SW will trigger irq #32(IOMUX) to be always pending manually by setting IOMUX_GPR1_GINT bit,
> 2) SW should then Unmask it in GPC before setting CCM LPM
> 3) SW should Mask it right after CCM LPM is set (set bit0-1 of CCM_CLPCR)
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/pm-imx6q.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
> index aecd9f8..8da4732 100644
> --- a/arch/arm/mach-imx/pm-imx6q.c
> +++ b/arch/arm/mach-imx/pm-imx6q.c
> @@ -156,10 +156,13 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
>  	}
>  
>  	/*
> -	 * Unmask the always pending IOMUXC interrupt #32 as wakeup source to
> -	 * deassert dsm_request signal, so that we can ensure dsm_request
> -	 * is not asserted when we're going to write CLPCR register to set LPM.
> -	 * After setting up LPM bits, we need to mask this wakeup source.
> +	 * TKT194736:
> +	 * Chip will enter low power mode before ARM A9 CPU executes WFI when improper low power sequence is used.
> +	 *
> +	 * SW workaround:
> +	 * 1) SW will trigger irq #32(IOMUXC) to be always pending manually by setting IOMUX_GPR1_GINT bit,
> +	 * 2) SW should then Unmask it in GPC before setting CCM LPM
> +	 * 3) SW should Mask it right after CCM LPM is set (set bit0-1 of CCM_CLPCR)
>  	 */
>  	iomuxc_irq_desc = irq_to_desc(32);
>  	imx_gpc_irq_unmask(&iomuxc_irq_desc->irq_data);
> @@ -219,6 +222,8 @@ void __init imx6q_pm_init(void)
>  	WARN_ON(!ccm_base);
>  
>  	/*
> +	 * This is for SW workaround step #1 of TKT194736, see comments
> +	 * in imx6q_set_lpm for details of this errata.
>  	 * Force IOMUXC irq pending, so that the interrupt to GPC can be
>  	 * used to deassert dsm_request signal when the signal gets
>  	 * asserted unexpectedly.
> -- 
> 1.7.9.5
> 
> 
