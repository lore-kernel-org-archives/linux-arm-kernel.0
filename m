From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Feb 2017 16:28:39 +0000
Subject: [PATCH v1 3/3] ASoC: zx-i2s: support zx296718 SoC for ZTE's i2s
 controller driver
In-Reply-To: <1486389020-29432-3-git-send-email-baoyou.xie@linaro.org>
References: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
 <1486389020-29432-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170206162839.ymtwdvtlsj4rogyw@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 09:50:20PM +0800, Baoyou Xie wrote:

> +static void zx_i2s_set_clk(struct zx_i2s_info *i2s,
> +			   unsigned int ch_num, unsigned int sample_rate)
> +{
> +	unsigned long val = sample_rate * ch_num * CLK_RAT;
> +
> +	clk_set_rate(i2s->dai_wclk, val);
> +
> +	if (i2s->dai_pclk)
> +		clk_set_rate(i2s->dai_pclk, val);
> +}

There's no error checking here, if we don't care if these calls succeed
we could save some power and not enable the clocks.  This function is
also very small and has exactly one user so it's not clear why it's
split out.

>  static const struct of_device_id zx_i2s_dt_ids[] = {
>  	{ .compatible = "zte,zx296702-i2s", },
> +	{ .compatible = "zte,zx296718-i2s", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, zx_i2s_dt_ids);

This adds a new DT binding but does not update the binding document.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/5485d607/attachment.sig>
