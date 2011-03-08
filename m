From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 Mar 2011 23:30:45 +0000
Subject: [Qualcomm PM8921 MFD v2 4/6] mfd: pm8xxx-mpp: Add pm8xxx MPP
	driver
In-Reply-To: <1299564590-30116-5-git-send-email-adharmap@codeaurora.org>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-5-git-send-email-adharmap@codeaurora.org>
Message-ID: <20110308233045.GB2717@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 10:09:48PM -0800, adharmap at codeaurora.org wrote:

> +	mpp_chip->gpio_chip.label = PM8XXX_MPP_DEV_NAME;
> +	mpp_chip->gpio_chip.direction_input = pm8xxx_mpp_dir_input;
> +	mpp_chip->gpio_chip.direction_output = pm8xxx_mpp_dir_output;
> +	mpp_chip->gpio_chip.to_irq = pm8xxx_mpp_to_irq;
> +	mpp_chip->gpio_chip.get = pm8xxx_mpp_get;
> +	mpp_chip->gpio_chip.set = pm8xxx_mpp_set;
> +	mpp_chip->gpio_chip.dbg_show = pm8xxx_mpp_dbg_show;
> +	mpp_chip->gpio_chip.ngpio = pdata->core_data.nmpps;
> +	mpp_chip->gpio_chip.can_sleep = 1;
> +	mpp_chip->gpio_chip.dev = &pdev->dev;
> +	mpp_chip->gpio_chip.base = pdata->mpp_base;

It's seems really odd that you're adding gpiolib stuff here when you've
also got a separate gpiolib driver.  Possibly this all shouldn't
actually be split up as much as it is - there's also the issue with the
gpiolib driver needing to peer into the interrupt controller.  It might
simplify the code if things were merged more.
