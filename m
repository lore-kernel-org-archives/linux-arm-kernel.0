From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 13 Jul 2015 16:13:26 -0700
Subject: [PATCH] Input: pmic8xxx-pwrkey - Support shutdown
In-Reply-To: <1436231329-17997-1-git-send-email-sboyd@codeaurora.org>
References: <1436231329-17997-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150713231326.GG15178@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 06 Jul 18:08 PDT 2015, Stephen Boyd wrote:

> On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> via a pin called PS_HOLD. When this pin goes low, the PMIC
> performs a configurable power sequence. Add a .shutdown hook so
> that we can properly configure this power sequence for shutdown
> or restart depending on the system state.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/misc/pmic8xxx-pwrkey.c | 287 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 280 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c

[..]

>  
>  /**
>   * struct pmic8xxx_pwrkey - pmic8xxx pwrkey information
>   * @key_press_irq: key press irq number
> + * @regmap: device regmap

Please also document the shutdown_fn.

>   */
>  struct pmic8xxx_pwrkey {
>  	int key_press_irq;
> +	struct regmap *regmap;
> +	int (*shutdown_fn)(struct pmic8xxx_pwrkey *, bool);
> +};
> +
> +struct pm8xxx_nbs {
> +	int (*shutdown_fn)(struct pmic8xxx_pwrkey *, bool);
>  };

This struct is unused.

[..]

>  static struct platform_driver pmic8xxx_pwrkey_driver = {
>  	.probe		= pmic8xxx_pwrkey_probe,
>  	.remove		= pmic8xxx_pwrkey_remove,
> +	.shutdown	= pmic8xxx_pwrkey_shutdown,

I tried to find pros/cons of using this approach instead of register a
reboot notifier like I did in the pm8941 driver, but I haven't come up
with any good reason to pick one or the other.

>  	.driver		= {
>  		.name	= "pm8xxx-pwrkey",
>  		.pm	= &pm8xxx_pwr_key_pm_ops,

With above nits I think this looks good.

Regards,
Bjorn
