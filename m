From: ido@wizery.com (Ido Yariv)
Date: Thu, 28 Jul 2011 21:34:54 +0300
Subject: [PATCH v2 6/6] arm: davinci: DA850: Add wl1271/wlan support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-7-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>
Message-ID: <20110728183454.GE1985@WorkStation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Mon, Jul 25, 2011 at 11:10:55PM +0530, Nori, Sekhar wrote:
> Adding a new kernel parameter requires update to
> Documentation/kernel-parameters.txt as well.
> 
> I am Ccing a couple of folks in case they have ideas on
> whether there is a better way to pass this information
> to the kernel. I assume there is no way to detect
> this from hardware.

Unfortunately, auto-detection of the reference clock is not currently
possible. However, it might be a better idea to have the ability to
override this value with a wl12xx module parameter instead of a kernel
parameter. I'll drop this kernel parameter.

> > +static struct davinci_mmc_config da850_mmc_wl12xx_config = {
> > +	.get_ro		= NULL,
> > +	.get_cd		= NULL,
> 
> You can get rid of these NULL initializers.

Sure.

> > +	.set_power	= wl12xx_set_power,
> > +	.wires		= 4,
> > +	.max_freq	= 25000000,
> > +	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_NONREMOVABLE |
> > +			  MMC_CAP_POWER_OFF_CARD,
> > +	.version	= MMC_CTLR_VERSION_2,
> > +};

[...]

> > +	ret = gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW, "wl12xx_en");
> > +	if (ret) {
> > +		pr_err("Error initializing the wl12xx enable gpio: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl12xx_irq");
> > +	if (ret) {
> > +		pr_err("Error initializing the wl12xx irq gpio: %d\n", ret);
> > +		gpio_free(DA850_WLAN_EN);
> > +		return;
> > +	}
> > +
> > +	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> > +	da850_wl12xx_wlan_data.board_ref_clock = da850_wl12xx_fref;
> > +
> > +	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> > +	if (ret) {
> > +		pr_err("Error setting wl12xx data: %d\n", ret);
> > +		gpio_free(DA850_WLAN_IRQ);
> > +		gpio_free(DA850_WLAN_EN);
> 
> Why not just use the traditional goto based bail out
> mechanism? You will avoid the multiple gpio_free() calls.

Sure.

Thanks for your review,
Ido.
