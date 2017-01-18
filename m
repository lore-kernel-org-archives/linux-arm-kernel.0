From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 18 Jan 2017 05:48:24 +0100
Subject: [PATCH v2 1/2] power/reset: at91-reset: add samx7 support
In-Reply-To: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
References: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170118044824.4inln4m2gj2xioob@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, Jan 18, 2017 at 12:07:37AM +0100, Alexandre Belloni wrote:
> From: Szemz? Andr?s <sza@esh.hu>
> 
> Add samx7 support. It is lacking a few bits and needs a new reset function.
> 
> Signed-off-by: Szemz? Andr?s <sza@esh.hu>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/at91-reset.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 568580cf0655..bb2588f0a4c7 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -134,6 +134,15 @@ static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
>  	return NOTIFY_DONE;
>  }
>  
> +static int samx7_restart(struct notifier_block *this, unsigned long mode,
> +			 void *cmd)
> +{
> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
> +	       at91_rstc_base);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static void __init at91_reset_status(struct platform_device *pdev)
>  {
>  	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
> @@ -173,6 +182,7 @@ static const struct of_device_id at91_reset_of_match[] = {
>  	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
>  	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
>  	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
> +	{ .compatible = "atmel,samx7-rstc", .data = samx7_restart },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, at91_reset_of_match);

Thanks, queued into power-supply's for-next branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/c0c70438/attachment.sig>
