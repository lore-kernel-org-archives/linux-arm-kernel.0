From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 09:37:51 +0100
Subject: [PATCH 1/5] input: Add new sun4i-ts driver for Allwinner sunxi
 SoC's rtp controller
In-Reply-To: <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20131226093751.3d133371@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hans de Goede,

On Tue, 24 Dec 2013 23:24:03 +0100, Hans de Goede wrote:

> +/* TP_INT_FIFOS irq and fifo status bits */
> +#define TEMP_DATA_PENDING	(1 << 18)
> +#define FIFO_OVERRUN_PENDING	(1 << 17)
> +#define FIFO_DATA_PENDING	(1 << 16)
> +#define TP_IDLE_FLG		(1 << 2)
> +#define TP_UP_PENDING		(1 << 1)
> +#define TP_DOWN_PENDING		(1 << 0)

You could use the BIT() macro for these definitions.


> +	ret = sun4i_ts_register_input(ts, pdev->name);
> +	if (ret)
> +		goto error;
> +
> +	/*
> +	 * Select HOSC clk, clkin = clk / 6, adc samplefreq = clkin / 8192,
> +	 * t_acq = clkin / (16 * 64)
> +	 */
> +	writel(ADC_CLK_SEL(0) | ADC_CLK_DIV(2) | FS_DIV(7) | T_ACQ(63),
> +	       ts->base + TP_CTRL0);
> +
> +	/*
> +	 * sensitive_adjust = 15 : max, which is not all that sensitive,
> +	 * tp_mode = 0 : only x and y coordinates, as we don't use dual touch
> +	 */
> +	writel(TP_SENSITIVE_ADJUST(15) | TP_MODE_SELECT(0),
> +	       ts->base + TP_CTRL2);
> +
> +	/* Enable median filter, type 1 : 5/3 */
> +	writel(FILTER_EN(1) | FILTER_TYPE(1), ts->base + TP_CTRL3);
> +
> +	/* Flush fifo, set trig level to 1, enable data and pen up irqs */
> +	writel(DATA_IRQ_EN(1) | FIFO_TRIG(1) | FIFO_FLUSH(1) | TP_UP_IRQ_EN(1),
> +	       ts->base + TP_INT_FIFOC);
> +
> +	/*
> +	 * Set stylus up debounce to aprox 10 ms, enable debounce, and
> +	 * finally enable tp mode.
> +	 */
> +	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
> +	       ts->base + TP_CTRL1);

It seems weird to do all the hardware initialization *after* the input
device has been registered. We normally initialize all the hardware
*and* then register the device, so that we guarantee that userspace
cannot access the device before it is properly initialized.


> +static const struct of_device_id sun4i_ts_of_match[] = {
> +	{ .compatible = "allwinner,sun4i-ts", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);

You're introducing a new DT binding, so the appropriate documentation
should be written for it.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
