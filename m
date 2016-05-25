From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 25 May 2016 12:14:23 +0200
Subject: [PATCH v2 1/4] reset: Add support for the Amlogic Meson SoC
 Reset Controller
In-Reply-To: <1464169758-26975-2-git-send-email-narmstrong@baylibre.com>
References: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
 <1464169758-26975-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464171263.3545.40.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

looks fine, just two comments below.

Am Mittwoch, den 25.05.2016, 11:49 +0200 schrieb Neil Armstrong:
> This patch adds the platform driver for the Amlogic Meson SoC Reset
> Controller.
> 
> The Meson8b and GXBB SoCs are supported.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-meson.c | 137 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 drivers/reset/reset-meson.c
> 
[...]
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> new file mode 100644
> index 0000000..98087ae
> --- /dev/null
> +++ b/drivers/reset/reset-meson.c
[...]
> +static int meson_reset_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct meson_reset *data =
> +		container_of(rcdev, struct meson_reset, rcdev);
> +	unsigned int bank = id / BITS_PER_REG;
> +	unsigned int offset = id % BITS_PER_REG;
> +	void *reg_addr = data->reg_base + (bank << 2);

We lost the __iomem here.

> +
> +	if (bank >= REG_COUNT)
> +		return -EINVAL;
> +
> +	writel(BIT(offset), reg_addr);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops meson_reset_ops = {
> +	.reset		= meson_reset_reset,
> +};
> +
> +static const struct of_device_id meson_reset_dt_ids[] = {
> +	 { .compatible = "amlogic,meson8b-reset", },
> +	 { .compatible = "amlogic,meson-gxbb-reset", },
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
[...]
> +MODULE_ALIAS("platform:meson_reset");

And I think you can drop the MODULE_ALIAS since of: modaliases will be
generated from the MODULE_DEVICE_TABLE above. This driver is only ever
going to be probed from device tree, isn't it?

> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
> +MODULE_LICENSE("Dual BSD/GPL");

regards
Philipp
