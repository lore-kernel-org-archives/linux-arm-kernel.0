From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Jan 2017 16:57:10 +0100
Subject: [PATCH 4/8] clk: renesas: cpg-mssr: Add support for reset control
In-Reply-To: <1484921306-9967-5-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
 <1484921306-9967-5-git-send-email-geert+renesas@glider.be>
Message-ID: <1484927830.2897.51.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Fri, 2017-01-20 at 15:08 +0100, Geert Uytterhoeven wrote:
> Add optional support for the Reset Control feature of the Renesas Clock
> Pulse Generator / Module Standby and Software Reset module on R-Car
> Gen2, R-Car Gen3, and RZ/G1 SoCs.

Is there a reason to make this optional?

> This allows to reset SoC devices using the Reset Controller API.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me,

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Just a small issue below,

> ---
>  drivers/clk/renesas/renesas-cpg-mssr.c | 122 +++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
> index f1161a585c57e433..ea4af714ac14603a 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
[...]
> +static int cpg_mssr_reset(struct reset_controller_dev *rcdev,
> +			  unsigned long id)
> +{
> +	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
> +	unsigned int reg = id / 32;
> +	unsigned int bit = id % 32;
> +	u32 bitmask = BIT(bit);

Here you have a bitmask = BIT(bit) variable.

> +	unsigned long flags;
> +	u32 value;
> +
> +	dev_dbg(priv->dev, "reset %u%02u\n", reg, bit);
> +
> +	/* Reset module */
> +	spin_lock_irqsave(&priv->rmw_lock, flags);
> +	value = readl(priv->base + SRCR(reg));
> +	value |= bitmask;

Here you use it.

> +	writel(value, priv->base + SRCR(reg));
> +	spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +
> +	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
> +	udelay(35);
> +
> +	/* Release module from reset state */
> +	writel(bitmask, priv->base + SRSTCLR(reg));
> +
> +	return 0;
> +}
> +
> +static int cpg_mssr_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
> +	unsigned int reg = id / 32;
> +	unsigned int bit = id % 32;

Here you haven't.

> +	unsigned long flags;
> +	u32 value;
> +
> +	dev_dbg(priv->dev, "assert %u%02u\n", reg, bit);
> +
> +	spin_lock_irqsave(&priv->rmw_lock, flags);
> +	value = readl(priv->base + SRCR(reg));
> +	writel(value | BIT(bit), priv->base + SRCR(reg));

Here you don't.

> +	spin_unlock_irqrestore(&priv->rmw_lock, flags);
> +	return 0;
> +}
> +
> +static int cpg_mssr_deassert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
> +	unsigned int reg = id / 32;
> +	unsigned int bit = id % 32;
> +
> +	dev_dbg(priv->dev, "deassert %u%02u\n", reg, bit);
> +
> +	writel(BIT(bit), priv->base + SRSTCLR(reg));

And here ...

> +	return 0;
> +}
> +
> +static int cpg_mssr_status(struct reset_controller_dev *rcdev,
> +			   unsigned long id)
> +{
> +	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
> +	unsigned int reg = id / 32;
> +	unsigned int bit = id % 32;
> +
> +	return !!(readl(priv->base + SRCR(reg)) & BIT(bit));

And here neither.

I'd choose one variant over the other for consistency.

regards
Philipp
