From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 14 May 2016 17:07:02 +0200
Subject: [RFC PATCH 1/3] reset: Add support for the Amlogic Meson GXBB
 Reset Controller
In-Reply-To: <1463148012-25988-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 13 May 2016 16:00:10 +0200")
References: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
 <1463148012-25988-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2oa881xwp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds the platform driver for the Amlogic Meson GXBB Reset
> Controller.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[...]

> +static int meson_gxbb_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct meson_gxbb_reset *data =
> +		container_of(rcdev, struct meson_gxbb_reset, rcdev);
> +	unsigned int bank = id / BITS_PER_REG;
> +	unsigned int offset = id % BITS_PER_REG;
> +	void *reg_addr = data->reg_base + (bank << 2);
> +
> +	if (bank >= REG_COUNT)
> +		return -EINVAL;
> +
> +	writel(readl(reg_addr) | BIT(offset), reg_addr);

The spec lists these registers as 16-bit registers, so probably readw/writew
are more appropriate here.

> +	return 0;
> +}
> +
> +static int meson_gxbb_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct meson_gxbb_reset *data =
> +		container_of(rcdev, struct meson_gxbb_reset, rcdev);
> +	unsigned int bank = id / BITS_PER_REG;
> +	unsigned int offset = id % BITS_PER_REG;
> +	void *reg_addr = data->reg_base + (bank << 2);
> +
> +	if (bank >= REG_COUNT)
> +		return -EINVAL;
> +
> +	writel(readl(reg_addr) & ~BIT(offset), reg_addr);

and here.

> +	return 0;
> +}

Kevin
