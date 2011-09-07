From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 17:07:55 -0700
Subject: [PATCH v6 25/25] gpio/omap: handle set_dataout reg capable IP on
	restore
In-Reply-To: <1314798161-19523-26-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:41 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-26-git-send-email-tarun.kanti@ti.com>
Message-ID: <87mxehusdg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> GPIO IP revisions such as those used in OMAP4 have a set_dataout
> while the previous revisions used a single dataout register.
> Depending on what is available restore the dataout settings
> to the right register.

OK, minor nit below...

> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index a629498..4680b4c 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1334,7 +1334,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  				bank->base + bank->regs->risingdetect);
>  	__raw_writel(bank->context.fallingdetect,
>  				bank->base + bank->regs->fallingdetect);
> -	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
> +	if (bank->regs->set_dataout && bank->regs->clr_dataout)

Why the check for ->clr_dataout here?

> +		__raw_writel(bank->context.dataout,
> +				bank->base + bank->regs->set_dataout);
> +	else
> +		__raw_writel(bank->context.dataout,
> +				bank->base + bank->regs->dataout);
>  	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
>  
>  	if (bank->dbck_enable_mask) {

Kevin
