From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 20:09:49 +0100
Subject: [PATCH v1 1/4] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
Message-ID: <20151019190949.GP32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 09:01:06AM +0800, Shunqian Zheng wrote:

> +config SND_SOC_INNO_RK3036
> +	tristate "Inno codec driver for RK3036 SoC"
> +	depends on ARCH_ROCKCHIP
> +

There doesn't appear to be any build dependency here so can we have an
|| COMPILE_TEST please and also add to SND_SOC_ALL_CODECS.

> +#define DEBUG

Please remove this for upstream.

> +static int rk3036_codec_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				       unsigned int fre, int dir)
> +{
> +	/* Nothing to be done here */
> +	return 0;
> +}

Remove empty functions, if they can be empty they can just be omitted.

> +static int rk3036_codec_dai_digital_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int val = 0;
> +
> +	dev_dbg(codec->dev, "rk3036_codec dai mute : %d\n", mute);
> +	if (mute)
> +		val |= INNO_REG_09_HP_OUTR_MUTE_YES |
> +		       INNO_REG_09_HP_OUTL_MUTE_YES;
> +	else
> +		val |= INNO_REG_09_HP_OUTR_MUTE_NO |
> +		       INNO_REG_09_HP_OUTL_MUTE_NO;

Does the device actually need muting to avoid audio issues?  If not it
looks like this is something that might be better made a user visible
control instead.

> +static void rk3036_codec_power_off(struct snd_soc_codec *codec)
> +{
> +	struct inno_reg_val *reg_val;
> +	int i;

> +static void rk3036_codec_power_on(struct snd_soc_codec *codec)
> +{
> +	struct inno_reg_val *reg_val;
> +	int i;

I'd expect to see these be part of the set_bias_level() operation.

> +	dev_dbg(codec->dev, "rk3036_codec power on\n");
> +	/* set a big current for capacitor discharging. */
> +	snd_soc_write(codec, INNO_REG_10, INNO_REG_10_MAX_CUR);
> +	mdelay(10);
> +	/* start precharge */
> +	snd_soc_write(codec, INNO_REG_06, INNO_REG_06_DAC_PRECHARGE);
> +	mdelay(100);
> +
> +	for (i = 0; i < ARRAY_SIZE(inno_codec_open_path); i++) {
> +		reg_val = &inno_codec_open_path[i];
> +		snd_soc_write(codec, reg_val->reg, reg_val->val);
> +		mdelay(5);
> +	}

This looks suspicious...  why isn't the power up sequence managed via
DAPM?

> +static struct regmap *rk3036_codec_get_regmap(struct device *dev)
> +{
> +	struct rk3036_codec_priv *priv = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "rk3036_codec get regmap\n");
> +	return priv->regmap;
> +}

There's already dev_get_regmap().

> +static int codec_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct rk3036_codec_priv *priv = context;
> +	void __iomem *base = priv->base;
> +
> +	*val = readl(base + reg);
> +	return 0;
> +}

> +static struct regmap_bus codec_regmap_bus = {
> +	.reg_read = codec_reg_read,
> +	.reg_write = codec_reg_write,

This looks like it's just regmap_mmio, why not just use that?

> +	ret = regmap_write(grf, 0x00140, BIT(16 + 10) | BIT(10));
> +	if (ret != 0) {

Can we have some defines for this rather than all the magic numbers?

> +static void rk3036_codec_platform_shutdown(struct platform_device *pdev)
> +{
> +	/*TODO:*/
> +}

If you use DAPM you shouldn't need to do anything here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/e5b6a9c2/attachment.sig>
