From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 May 2012 14:34:51 -0600
Subject: [PATCH 02/12] pinctrl: basic Nomadik pinctrl interface
In-Reply-To: <1336470270-23518-1-git-send-email-linus.walleij@stericsson.com>
References: <1336470270-23518-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4FAAD4EB.4010007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2012 03:44 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds a scratch pin control interface to the Nomadik pinctrl
> driver, and defines the pins and groups in the DB8500 ASIC. We
> define GPIO ranges to cover the pins exposed. The DB8500 has
> more pins than this but we restrict the driver to the pins that
> can be controlled from the combined GPIO and pin control hardware
> to begin with.

> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c

> +static int nmk_list_groups(struct pinctrl_dev *pctldev, unsigned selector)
> +{
> +	struct nmk_pinctrl *npct = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (selector >= npct->soc->ngroups)
> +		return -EINVAL;

I think all the other drivers removed this error-checking from functions
called by the pinctrl core, assuming that the core would error-check any
user-supplied data and respect limits in the pinctrl device descriptor.

> +static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)

> +	/* Poke in other ASIC variants here */
> +	if (platid->driver_data == PINCTRL_NMK_DB8500)
> +		nmk_pinctrl_db8500_init(&npct->soc);

Other platforms have a unique top-level driver for each variant, with
the probe() function for each variant calling into a utility function.
That way, the common/utility code doesn't need to contain a
table/list/... of all the variants. Can the same approach be used here?
