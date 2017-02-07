From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 7 Feb 2017 16:26:35 +0800
Subject: [PATCH v2 3/3] ASoC: zx-i2s: support zx296718 SoC for ZTE's i2s
 controller driver
In-Reply-To: <1486436571-8682-3-git-send-email-baoyou.xie@linaro.org>
References: <1486436571-8682-1-git-send-email-baoyou.xie@linaro.org>
 <1486436571-8682-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170207082633.GH3407@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 11:02:51AM +0800, Baoyou Xie wrote:
> This patch adds zx296718 SoC support for ZTE's i2s controller driver.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  sound/soc/zte/zx-i2s.c | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
> index ed7a56d..2afac69 100644
> --- a/sound/soc/zte/zx-i2s.c
> +++ b/sound/soc/zte/zx-i2s.c
> @@ -95,12 +95,13 @@
>  struct zx_i2s_info {
>  	struct snd_dmaengine_dai_dma_data	dma_playback;
>  	struct snd_dmaengine_dai_dma_data	dma_capture;
> -	struct clk				*dai_clk;
> +	struct clk				*dai_wclk, *dai_pclk;
>  	void __iomem				*reg_base;
>  	int					master;
>  	resource_size_t				mapbase;
>  };
>  
> +

This newline is unnecessary.

>  static void zx_i2s_tx_en(void __iomem *base, bool on)
>  {
>  	unsigned long val;
> @@ -274,9 +275,14 @@ static int zx_i2s_hw_params(struct snd_pcm_substream *substream,
>  	val |= ZX_I2S_TIMING_CHN(ch_num);
>  	writel_relaxed(val, i2s->reg_base + ZX_I2S_TIMING_CTRL);
>  
> -	if (i2s->master)
> -		ret = clk_set_rate(i2s->dai_clk,
> -				   params_rate(params) * ch_num * CLK_RAT);
> +	if (i2s->master) {
> +		unsigned long rate = params_rate(params) * ch_num * CLK_RAT;
> +
> +		ret = clk_set_rate(i2s->dai_wclk, rate);
> +		if (!ret && i2s->dai_pclk)
> +			ret = clk_set_rate(i2s->dai_pclk, rate);

The 'pclk' is APB bus clock fed into I2S controller.  I don't think we
need to set its frequency per audio frequency.

> +	}
> +
>  	return ret;
>  }
>  
> @@ -328,8 +334,19 @@ static int zx_i2s_startup(struct snd_pcm_substream *substream,
>  			  struct snd_soc_dai *dai)
>  {
>  	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(zx_i2s->dai_wclk);
> +	if (ret)
> +		return ret;
>  
> -	return clk_prepare_enable(zx_i2s->dai_clk);
> +	ret = clk_prepare_enable(zx_i2s->dai_pclk);
> +	if (ret) {
> +		clk_disable_unprepare(zx_i2s->dai_wclk);
> +		return ret;
> +	}
> +
> +	return ret;
>  }
>  
>  static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
> @@ -337,7 +354,8 @@ static void zx_i2s_shutdown(struct snd_pcm_substream *substream,
>  {
>  	struct zx_i2s_info *zx_i2s = dev_get_drvdata(dai->dev);
>  
> -	clk_disable_unprepare(zx_i2s->dai_clk);
> +	clk_disable_unprepare(zx_i2s->dai_wclk);
> +	clk_disable_unprepare(zx_i2s->dai_pclk);
>  }
>  
>  static struct snd_soc_dai_ops zx_i2s_dai_ops = {
> @@ -381,10 +399,16 @@ static int zx_i2s_probe(struct platform_device *pdev)
>  	if (!zx_i2s)
>  		return -ENOMEM;
>  
> -	zx_i2s->dai_clk = devm_clk_get(&pdev->dev, "tx");
> -	if (IS_ERR(zx_i2s->dai_clk)) {
> -		dev_err(&pdev->dev, "Fail to get clk\n");
> -		return PTR_ERR(zx_i2s->dai_clk);
> +	zx_i2s->dai_wclk = devm_clk_get(&pdev->dev, "tx");
> +	if (IS_ERR(zx_i2s->dai_wclk)) {
> +		dev_err(&pdev->dev, "Fail to get wclk\n");
> +		return PTR_ERR(zx_i2s->dai_wclk);
> +	}
> +
> +	zx_i2s->dai_pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(zx_i2s->dai_pclk)) {
> +		dev_info(&pdev->dev, "have no pclk\n");
> +		zx_i2s->dai_pclk = NULL;
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -414,6 +438,7 @@ static int zx_i2s_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id zx_i2s_dt_ids[] = {
>  	{ .compatible = "zte,zx296702-i2s", },
> +	{ .compatible = "zte,zx296718-i2s", },

The I2S controller on ZX296702 actually has both wclk and pclk too, same
as ZX296718 I2S.  The problem is that the driver currently doesn't
handle pclk.  This is something we need to fix, regardless of ZX296718
support.

That said, ZX296718 I2S is compatible with ZX296702 one, and we do not
need to introduce new compatible string.  Instead, we can code the
compatible string on ZX296718 like below.

  compatible = "zte,zx296718-i2s", "zte,zx296702-i2s";

With the pclk handling added, the driver should just work for ZX296718.

Shawn

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, zx_i2s_dt_ids);
> -- 
> 2.7.4
> 
