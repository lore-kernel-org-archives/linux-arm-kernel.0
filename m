From: codekipper@gmail.com (Code Kipper)
Date: Thu, 2 Jun 2016 10:03:21 +0200
Subject: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
In-Reply-To: <20160601175430.11625-3-maxime.ripard@free-electrons.com>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
Message-ID: <CAEKpxBmLb27WYqB5SMhKqTw2cTznNEZVJdxEFKkwCY03JsdyVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

snip
> +
> +       /* Always favor the highest oversampling rate */
> +       for (i = (ARRAY_SIZE(sun4i_i2s_oversample_rates) - 1); i >= 0; i--) {
> +               unsigned int oversample_rate = sun4i_i2s_oversample_rates[i];
> +
> +               bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> +                                                 word_size);
> +               mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> +                                                 clk_rate,
> +                                                 rate);
> +
> +               if ((bclk_div >= 0) && (mclk_div >= 0))
> +                       break;
> +       }
> +
> +       if (bclk_div < 0 && mclk_div < 0)
Hi Maxime,
this wouldn't work if one of the divs returns a valid value and I saw
this when working with this driver. Use if ((bclk_div < 0) ||
(mclk_div < 0)). Rest of the code looks code and I will have a go at
testing with it ASAP,
Great work,
CK
> +               return -EINVAL;
> +
> +       regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
> +                    SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
> +                    SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
> +                    SUN4I_I2S_CLK_DIV_MCLK_EN);
> +
> +       return 0;
> +}
> +
> +static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> +                              struct snd_pcm_hw_params *params,
> +                              struct snd_soc_dai *dai)
> +{
> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +       int sr, wss;
> +       u32 width;
> +
> +       if (params_channels(params) != 2)
> +               return -EINVAL;
> +
> +       /* Enable the first output line */
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                          SUN4I_I2S_CTRL_SDO_EN_MASK,
> +                          SUN4I_I2S_CTRL_SDO_EN(0));
> +
> +       /* Enable the first two channels */
> +       regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
> +                    SUN4I_I2S_TX_CHAN_SEL(2));
> +
> +       /* Map them to the two first samples coming in */
> +       regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
> +                    SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));
> +
> +       switch (params_physical_width(params)) {
> +       case 16:
> +               width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       i2s->playback_dma_data.addr_width = width;
> +
> +       sr = sun4i_i2s_params_to_sr(params);
> +       if (sr < 0)
> +               return -EINVAL;
> +
> +       wss = sun4i_i2s_params_to_wss(params);
> +       if (wss < 0)
> +               return -EINVAL;
> +
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +                          SUN4I_I2S_FMT0_WSS_MASK | SUN4I_I2S_FMT0_SR_MASK,
> +                          SUN4I_I2S_FMT0_WSS(wss) | SUN4I_I2S_FMT0_SR(sr));
> +
> +       return sun4i_i2s_set_clk_rate(i2s, params_rate(params),
> +                                     params_width(params));
> +}
> +
> +static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +        struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +       u32 val;
> +
> +       /* DAI Mode */
> +       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +       case SND_SOC_DAIFMT_I2S:
> +               val = SUN4I_I2S_FMT0_FMT_I2S;
> +               break;
> +       case SND_SOC_DAIFMT_LEFT_J:
> +               val = SUN4I_I2S_FMT0_FMT_LEFT_J;
> +               break;
> +       case SND_SOC_DAIFMT_RIGHT_J:
> +               val = SUN4I_I2S_FMT0_FMT_RIGHT_J;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +                          SUN4I_I2S_FMT0_FMT_MASK,
> +                          val);
> +
> +       /* DAI clock polarity */
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_IB_IF:
> +               /* Invert both clocks */
> +               val = SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED |
> +                       SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
> +               break;
> +       case SND_SOC_DAIFMT_IB_NF:
> +               /* Invert bit clock */
> +               val = SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED |
> +                       SUN4I_I2S_FMT0_LRCLK_POLARITY_NORMAL;
> +               break;
> +       case SND_SOC_DAIFMT_NB_IF:
> +               /* Invert frame clock */
> +               val = SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED |
> +                       SUN4I_I2S_FMT0_BCLK_POLARITY_NORMAL;
> +               break;
> +       case SND_SOC_DAIFMT_NB_NF:
> +               /* Nothing to do for both normal cases */
> +               val = SUN4I_I2S_FMT0_BCLK_POLARITY_NORMAL |
> +                       SUN4I_I2S_FMT0_LRCLK_POLARITY_NORMAL;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +                          SUN4I_I2S_FMT0_BCLK_POLARITY_MASK |
> +                          SUN4I_I2S_FMT0_LRCLK_POLARITY_MASK,
> +                          val);
> +
> +       /* DAI clock master masks */
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               /* BCLK and LRCLK master */
> +               val = SUN4I_I2S_CTRL_MODE_MASTER;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               /* BCLK and LRCLK slave */
> +               val = SUN4I_I2S_CTRL_MODE_SLAVE;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                          SUN4I_I2S_CTRL_MODE_MASK,
> +                          val);
> +
> +       /* Set significant bits in our FIFOs */
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> +                          SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
> +                          SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
> +                          SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
> +                          SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
> +       return 0;
> +}
> +
> +static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
> +{
> +       /* Flush TX FIFO */
> +        regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> +                          SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
> +                          SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> +
> +        /* Clear TX counter */
> +       regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> +
> +        /* Enable TX Block */
> +        regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                          SUN4I_I2S_CTRL_TX_EN,
> +                          SUN4I_I2S_CTRL_TX_EN);
> +
> +        /* Enable TX DRQ */
> +        regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
> +                          SUN4I_I2S_DMA_INT_CTRL_TX_DRQ_EN,
> +                          SUN4I_I2S_DMA_INT_CTRL_TX_DRQ_EN);
> +}
> +
> +
> +static void sun4i_i2s_stop_playback(struct sun4i_i2s *i2s)
> +{
> +        /* Disable TX Block */
> +        regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                          SUN4I_I2S_CTRL_TX_EN,
> +                          0);
> +
> +        /* Disable TX DRQ */
> +        regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
> +                          SUN4I_I2S_DMA_INT_CTRL_TX_DRQ_EN,
> +                          0);
> +}
> +
> +static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
> +                            struct snd_soc_dai *dai)
> +{
> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +                       sun4i_i2s_start_playback(i2s);
> +               else
> +                       return -EINVAL;
> +               break;
> +
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +                       sun4i_i2s_stop_playback(i2s);
> +               else
> +                       return -EINVAL;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
> +                            struct snd_soc_dai *dai)
> +{
> +        struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +       return clk_prepare_enable(i2s->mod_clk);
> +}
> +
> +static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
> +                              struct snd_soc_dai *dai)
> +{
> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +       return clk_disable_unprepare(i2s->mod_clk);
> +}
> +
> +static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
> +       .hw_params      = sun4i_i2s_hw_params,
> +       .set_fmt        = sun4i_i2s_set_fmt,
> +       .shutdown       = sun4i_i2s_shutdown,
> +       .startup        = sun4i_i2s_startup,
> +       .trigger        = sun4i_i2s_trigger,
> +};
> +
> +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +       /* Enable the whole hardware block */
> +       regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +                    SUN4I_I2S_CTRL_GL_EN);
> +
> +       snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data, NULL);
> +
> +       snd_soc_dai_set_drvdata(dai, i2s);
> +
> +       return 0;
> +}
> +
> +static struct snd_soc_dai_driver sun4i_i2s_dai = {
> +       .probe = sun4i_i2s_dai_probe,
> +       .playback = {
> +               .stream_name = "Playback",
> +               .channels_min = 2,
> +               .channels_max = 2,
> +               .rates = SNDRV_PCM_RATE_8000_192000,
> +               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> +       },
> +       .ops = &sun4i_i2s_dai_ops,
> +       .symmetric_rates = 1,
> +};
> +
> +static const struct snd_soc_component_driver sun4i_i2s_component = {
> +       .name   = "sun4i-dai",
> +};
> +
> +static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case SUN4I_I2S_FIFO_TX_REG:
> +               return false;
> +
> +       default:
> +               return true;
> +       }
> +}
> +
> +static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case SUN4I_I2S_FIFO_RX_REG:
> +       case SUN4I_I2S_FIFO_STA_REG:
> +               return false;
> +
> +       default:
> +               return true;
> +       }
> +}
> +
> +static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case SUN4I_I2S_FIFO_RX_REG:
> +       case SUN4I_I2S_INT_STA_REG:
> +       case SUN4I_I2S_RX_CNT_REG:
> +       case SUN4I_I2S_TX_CNT_REG:
> +               return true;
> +
> +       default:
> +               return false;
> +       }
> +}
> +
> +static const struct reg_default sun4i_i2s_reg_defaults[] = {
> +       { SUN4I_I2S_CTRL_REG, 0x00000000 },
> +       { SUN4I_I2S_FMT0_REG, 0x0000000c },
> +       { SUN4I_I2S_FMT1_REG, 0x00004020 },
> +       { SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
> +       { SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
> +       { SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
> +       { SUN4I_I2S_TX_CHAN_SEL_REG, 0x00000001 },
> +       { SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210 },
> +       { SUN4I_I2S_RX_CHAN_SEL_REG, 0x00000001 },
> +       { SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210 },
> +};
> +
> +static const struct regmap_config sun4i_i2s_regmap_config = {
> +       .reg_bits       = 32,
> +       .reg_stride     = 4,
> +       .val_bits       = 32,
> +       .max_register   = SUN4I_I2S_RX_CHAN_MAP_REG,
> +
> +       .cache_type     = REGCACHE_FLAT,
> +       .reg_defaults   = sun4i_i2s_reg_defaults,
> +       .num_reg_defaults       = ARRAY_SIZE(sun4i_i2s_reg_defaults),
> +       .writeable_reg  = sun4i_i2s_wr_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
> +       .volatile_reg   = sun4i_i2s_volatile_reg,
> +};
> +
> +static int sun4i_i2s_runtime_resume(struct device *dev)
> +{
> +       struct sun4i_i2s *i2s = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(i2s->bus_clk);
> +       if (ret) {
> +               dev_err(dev, "Failed to enable bus clock\n");
> +               return ret;
> +       }
> +
> +       regcache_cache_only(i2s->regmap, false);
> +       regcache_mark_dirty(i2s->regmap);
> +
> +       ret = regcache_sync(i2s->regmap);
> +       if (ret) {
> +               dev_err(dev, "Failed to sync regmap cache\n");
> +               goto err_disable_clk;
> +       }
> +
> +       return 0;
> +
> +err_disable_clk:
> +       clk_disable_unprepare(i2s->bus_clk);
> +       return ret;
> +}
> +
> +static int sun4i_i2s_runtime_suspend(struct device *dev)
> +{
> +       struct sun4i_i2s *i2s = dev_get_drvdata(dev);
> +
> +       regcache_cache_only(i2s->regmap, true);
> +
> +       clk_disable_unprepare(i2s->bus_clk);
> +
> +       return 0;
> +}
> +
> +static int sun4i_i2s_probe(struct platform_device *pdev)
> +{
> +       struct sun4i_i2s *i2s;
> +       struct resource *res;
> +       void __iomem *regs;
> +       int irq, ret;
> +
> +       i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> +       if (!i2s)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, i2s);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(regs)) {
> +               dev_err(&pdev->dev, "Can't request IO region\n");
> +               return PTR_ERR(regs);
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "Can't retrieve our interrupt\n");
> +               return irq;
> +       }
> +
> +       i2s->bus_clk = devm_clk_get(&pdev->dev, "apb");
> +       if (IS_ERR(i2s->bus_clk)) {
> +               dev_err(&pdev->dev, "Can't get our bus clock\n");
> +               return PTR_ERR(i2s->bus_clk);
> +       }
> +
> +       i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
> +                                            &sun4i_i2s_regmap_config);
> +       if (IS_ERR(i2s->regmap)) {
> +               dev_err(&pdev->dev, "Regmap initialisation failed\n");
> +               return PTR_ERR(i2s->regmap);
> +       };
> +
> +       i2s->mod_clk = devm_clk_get(&pdev->dev, "mod");
> +       if (IS_ERR(i2s->mod_clk)) {
> +               dev_err(&pdev->dev, "Can't get our mod clock\n");
> +               return PTR_ERR(i2s->mod_clk);
> +       }
> +
> +       i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
> +       i2s->playback_dma_data.maxburst = 4;
> +
> +       pm_runtime_enable(&pdev->dev);
> +       if (!pm_runtime_enabled(&pdev->dev)) {
> +               ret = sun4i_i2s_runtime_resume(&pdev->dev);
> +               if (ret)
> +                       goto err_pm_disable;
> +       }
> +
> +       ret = devm_snd_soc_register_component(&pdev->dev,
> +                                             &sun4i_i2s_component,
> +                                             &sun4i_i2s_dai, 1);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Could not register DAI\n");
> +               goto err_suspend;
> +       }
> +
> +       ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Could not register PCM\n");
> +               goto err_suspend;
> +       }
> +
> +       return 0;
> +
> +err_suspend:
> +       if (!pm_runtime_status_suspended(&pdev->dev))
> +               sun4i_i2s_runtime_suspend(&pdev->dev);
> +err_pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +
> +       return ret;
> +}
> +
> +static int sun4i_i2s_remove(struct platform_device *pdev)
> +{
> +       snd_dmaengine_pcm_unregister(&pdev->dev);
> +
> +       pm_runtime_disable(&pdev->dev);
> +       if (!pm_runtime_status_suspended(&pdev->dev))
> +               sun4i_i2s_runtime_suspend(&pdev->dev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sun4i_i2s_match[] = {
> +       { .compatible = "allwinner,sun4i-a10-i2s", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
> +
> +static const struct dev_pm_ops sun4i_i2s_pm_ops = {
> +       .runtime_resume         = sun4i_i2s_runtime_resume,
> +       .runtime_suspend        = sun4i_i2s_runtime_suspend,
> +};
> +
> +static struct platform_driver sun4i_i2s_driver = {
> +       .probe  = sun4i_i2s_probe,
> +       .remove = sun4i_i2s_remove,
> +       .driver = {
> +               .name           = "sun4i-i2s",
> +               .of_match_table = sun4i_i2s_match,
> +               .pm             = &sun4i_i2s_pm_ops,
> +       },
> +};
> +module_platform_driver(sun4i_i2s_driver);
> +
> +MODULE_AUTHOR("Andrea Venturi <be17068@iperbole.bo.it>");
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_DESCRIPTION("Allwinner A10 I2S driver");
> +MODULE_LICENSE("GPL");
> --
> 2.8.3
>
