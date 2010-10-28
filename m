From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 29 Oct 2010 03:55:26 +0900
Subject: [GIT PULL] genesis updates for 2.6.37-rc1
In-Reply-To: <20101028100912.GC3122@n2100.arm.linux.org.uk>
References: <20101025014825.GD2173@linux-sh.org>
	<20101028100912.GC3122@n2100.arm.linux.org.uk>
Message-ID: <20101028185525.GA14720@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 28, 2010 at 11:09:12AM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 25, 2010 at 10:48:25AM +0900, Paul Mundt wrote:
> > Please pull from:
> > 
> > 	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git
> 
> I'm seeing a merge conflict against current mainline.  I'm not convinced
> that there's a simple solution to this - it looks to me like the
> snd_soc_register_codec() is not correctly placed here - as the codec
> code references the hdmi data structure, but it's registered before the
> hdmi data structure is setup.
> 
I was afraid that would happen. The ordering is certainly suspect, so
I've moved it down and reworked it a bit. This seems to work ok:

---

diff --cc drivers/video/sh_mobile_hdmi.c
index ef989d9,f0ff284..0000000
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@@ -224,60 -227,8 +229,60 @@@ static u8 hdmi_read(struct sh_hdmi *hdm
  	return ioread8(hdmi->base + reg);
  }
  
 +/*
 + *	HDMI sound
 + */
 +static unsigned int sh_hdmi_snd_read(struct snd_soc_codec *codec,
 +				     unsigned int reg)
 +{
 +	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
 +
 +	return hdmi_read(hdmi, reg);
 +}
 +
 +static int sh_hdmi_snd_write(struct snd_soc_codec *codec,
 +			     unsigned int reg,
 +			     unsigned int value)
 +{
 +	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
 +
 +	hdmi_write(hdmi, value, reg);
 +	return 0;
 +}
 +
 +static struct snd_soc_dai_driver sh_hdmi_dai = {
 +	.name = "sh_mobile_hdmi-hifi",
 +	.playback = {
 +		.stream_name = "Playback",
 +		.channels_min = 2,
 +		.channels_max = 8,
 +		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100  |
 +			 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200  |
 +			 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
 +			 SNDRV_PCM_RATE_192000,
 +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 +	},
 +};
 +
 +static int sh_hdmi_snd_probe(struct snd_soc_codec *codec)
 +{
 +	dev_info(codec->dev, "SH Mobile HDMI Audio Codec");
 +
 +	return 0;
 +}
 +
 +static struct snd_soc_codec_driver soc_codec_dev_sh_hdmi = {
 +	.probe		= sh_hdmi_snd_probe,
 +	.read		= sh_hdmi_snd_read,
 +	.write		= sh_hdmi_snd_write,
 +};
 +
 +/*
 + *	HDMI video
 + */
 +
  /* External video parameter settings */
- static void hdmi_external_video_param(struct sh_hdmi *hdmi)
+ static void sh_hdmi_external_video_param(struct sh_hdmi *hdmi)
  {
  	struct fb_var_screeninfo *var = &hdmi->var;
  	u16 htotal, hblank, hdelay, vtotal, vblank, vdelay, voffset;
@@@ -964,11 -1079,7 +1152,8 @@@ static int __init sh_hdmi_probe(struct 
  		return -ENOMEM;
  	}
  
- 	ret =  snd_soc_register_codec(&pdev->dev,
- 			&soc_codec_dev_sh_hdmi, &sh_hdmi_dai, 1);
- 	if (ret < 0)
- 		goto esndreg;
+ 	mutex_init(&hdmi->mutex);
 +
  	hdmi->dev = &pdev->dev;
  
  	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
@@@ -1041,8 -1136,8 +1210,17 @@@
  		goto ereqirq;
  	}
  
++	ret = snd_soc_register_codec(&pdev->dev,
++			&soc_codec_dev_sh_hdmi, &sh_hdmi_dai, 1);
++	if (ret < 0) {
++		dev_err(&pdev->dev, "codec registration failed\n");
++		goto ecodec;
++	}
++
  	return 0;
  
++ecodec:
++	free_irq(irq, hdmi);
  ereqirq:
  	pm_runtime_disable(&pdev->dev);
  	iounmap(hdmi->base);
@@@ -1066,17 -1159,19 +1242,21 @@@ static int __exit sh_hdmi_remove(struc
  	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
  	struct sh_hdmi *hdmi = platform_get_drvdata(pdev);
  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &pdata->lcd_chan->board_cfg;
  	int irq = platform_get_irq(pdev, 0);
  
 +	snd_soc_unregister_codec(&pdev->dev);
 +
- 	pdata->lcd_chan->board_cfg.display_on = NULL;
- 	pdata->lcd_chan->board_cfg.display_off = NULL;
- 	pdata->lcd_chan->board_cfg.board_data = NULL;
+ 	board_cfg->display_on = NULL;
+ 	board_cfg->display_off = NULL;
+ 	board_cfg->board_data = NULL;
+ 	board_cfg->owner = NULL;
  
+ 	/* No new work will be scheduled, wait for running ISR */
  	free_irq(irq, hdmi);
- 	pm_runtime_disable(&pdev->dev);
+ 	/* Wait for already scheduled work */
  	cancel_delayed_work_sync(&hdmi->edid_work);
+ 	pm_runtime_disable(&pdev->dev);
  	clk_disable(hdmi->hdmi_clk);
  	clk_put(hdmi->hdmi_clk);
  	iounmap(hdmi->base);
