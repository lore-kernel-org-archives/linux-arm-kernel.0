From: info@lategoodbye.de (Stefan Wahren)
Date: Mon, 23 Nov 2015 18:01:41 +0100
Subject: [PATCH] dmaengine: bcm2835-dma: Convert to use DMA pool
In-Reply-To: <20151123132033.GA24432@camel2.lan>
References: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
 <20151123132033.GA24432@camel2.lan>
Message-ID: <56534675.6040601@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Am 23.11.2015 um 14:20 schrieb Matthias Reichl:
> On Mon, Nov 16, 2015 at 01:09:03PM +0200, Peter Ujfalusi wrote:
>> f93178291712 dmaengine: bcm2835-dma: Fix memory leak when stopping a
>> 	     running transfer
>>
>> Fixed the memleak, but introduced another issue: the terminate_all callback
>> might be called with interrupts disabled and the dma_free_coherent() is
>> not allowed to be called when IRQs are disabled.
>> Convert the driver to use dma_pool_* for managing the list of control
>> blocks for the transfer.
>>
>> Fixes: f93178291712 ("dmaengine: bcm2835-dma: Fix memory leak when stopping a running transfer")
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> Tested-by: Matthias Reichl <hias@horus.com>

good job!

Stefan

>
> Thanks a lot, the fix seems to be working fine with mainline 4.4-rc1,
> 4.4-rc2 and the 4.3 Raspberry Pi tree.
>
> On the RPi tree you can simply enable the rpi-dac overlay for testing,
> "dtoverlay=rpi-dac" in config.txt, it'll work without any additional
> hardware.
>
> As Peter mentioned I extended his patch to the non-mainlined slave_sg
> code in the RPi tree. I've been using this during the last week and
> haven't noticed any issues.
>
> For testing with 4.4-rc mainline I used the (quick-and-dirty) code
> below. It adds the missing PCM configuration to bcm2835-i2s, adds
> some DT fixes (so DT and bcm2835-i2s are similar to the RPi tree)
> and installs a card with a dummy-codec. You can then use aplay to
> test the DMA code path and don't need any additional hardware.
>
> I've checked the I2S GPIOs on a RPi B+ with my scope, PCM-clock
> and frame-clock are fine and pcm-data-out also looks OK.
>
> There's a small gotcha though: bcm2835-i2s hasn't been converted
> to the new clock driver yet and also can't coexist with it
> (overlapping iomem regions...). Fortunately, this can be solved
> by disabling the new clock driver in the devicetree.
>
> Here are the steps I used for testing:
>
> - revert commits 121432c7a02f and 94cb7f76caa0 to disable the
>    new clock driver in DT
> - apply the test-code patch below
> - make bcm2835_defconfig
> - enable bcm2835-dma and bcm2835-i2s in kernel config:
>    CONFIG_SOUND=y
>    CONFIG_SND=y
>    CONFIG_SND_SOC=y
>    CONFIG_SND_BCM2835_SOC_I2S=y
>    CONFIG_DMADEVICES=y
>    CONFIG_DMA_BCM2835=y
> - (optionally) apply Peter's DMA patch
> - on the RPi use aplay to play a 44.1kHz 16-bit stereo WAV
>    (32bit and other sample rates will work, too)
>
> so long,
>
> Hias
>
> ---
>
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index 2029394..c3a1cfc 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -102,13 +102,13 @@
>
>   		i2s: i2s at 7e203000 {
>   			compatible = "brcm,bcm2835-i2s";
> -			reg = <0x7e203000 0x20>,
> -			      <0x7e101098 0x02>;
> +			reg = <0x7e203000 0x24>,
> +			      <0x7e101098 0x08>;
>
>   			dmas = <&dma 2>,
>   			       <&dma 3>;
>   			dma-names = "tx", "rx";
> -			status = "disabled";
> +			status = "okay";
>   		};
>
>   		spi: spi at 7e204000 {
> @@ -189,4 +189,9 @@
>   			clock-frequency = <250000000>;
>   		};
>   	};
> +
> +	sound {
> +		compatible = "brcm,i2s-dummy-card";
> +		i2s-controller = <&i2s>;
> +	};
>   };
> diff --git a/sound/soc/bcm/Makefile b/sound/soc/bcm/Makefile
> index bc816b7..d599b62 100644
> --- a/sound/soc/bcm/Makefile
> +++ b/sound/soc/bcm/Makefile
> @@ -1,5 +1,7 @@
>   # BCM2835 Platform Support
>   snd-soc-bcm2835-i2s-objs := bcm2835-i2s.o
> +snd-soc-i2s-dummy-card-objs := i2s-dummy-card.o
>
>   obj-$(CONFIG_SND_BCM2835_SOC_I2S) += snd-soc-bcm2835-i2s.o
> +obj-$(CONFIG_SND_BCM2835_SOC_I2S) += snd-soc-i2s-dummy-card.o
>
> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 8c435be..b1ff172 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -784,6 +784,24 @@ static const struct snd_soc_component_driver bcm2835_i2s_component = {
>   	.name		= "bcm2835-i2s-comp",
>   };
>
> +static const struct snd_pcm_hardware bcm2835_pcm_hardware = {
> +	.info			= SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_JOINT_DUPLEX,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= SZ_64K - 4,
> +	.periods_min		= 2,
> +	.periods_max		= 255,
> +	.buffer_bytes_max	= SZ_512K
> +};
> +
> +static const struct snd_dmaengine_pcm_config bcm2835_dmaengine_pcm_config = {
> +	.pcm_hardware = &bcm2835_pcm_hardware,
> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> +	.prealloc_buffer_size = SZ_1M,
> +};
> +
>   static int bcm2835_i2s_probe(struct platform_device *pdev)
>   {
>   	struct bcm2835_i2s_dev *dev;
> @@ -848,7 +866,9 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> -	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> +	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
> +			&bcm2835_dmaengine_pcm_config,
> +			SND_DMAENGINE_PCM_FLAG_COMPAT);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
>   		return ret;
> diff --git a/sound/soc/bcm/i2s-dummy-card.c b/sound/soc/bcm/i2s-dummy-card.c
> new file mode 100644
> index 0000000..b3ad842
> --- /dev/null
> +++ b/sound/soc/bcm/i2s-dummy-card.c
> @@ -0,0 +1,87 @@
> +/*
> + * Dummy card driver for testing bcm2835-i2s
> + *
> + * Author:	Matthias Reichl <hias@horus.com>
> + *		Copyright 2015
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +
> +static struct snd_soc_dai_link snd_i2s_dummy_card_dai[] = {
> +{
> +	.name		= "i2s-dummy",
> +	.stream_name	= "i2s-dummy HiFi",
> +	.codec_name	= "snd-soc-dummy",
> +	.codec_dai_name	= "snd-soc-dummy-dai",
> +	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +				SND_SOC_DAIFMT_CBS_CFS,
> +},
> +};
> +
> +static struct snd_soc_card snd_i2s_dummy_card = {
> +	.name		= "i2s_dummy_card",
> +	.dai_link	= snd_i2s_dummy_card_dai,
> +	.num_links	= ARRAY_SIZE(snd_i2s_dummy_card_dai),
> +};
> +
> +static int snd_i2s_dummy_card_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct device_node *i2s_node;
> +
> +	if (!pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "no of_node, exiting\n");
> +		return -ENODEV;
> +	}
> +
> +	i2s_node = of_parse_phandle(pdev->dev.of_node, "i2s-controller", 0);
> +
> +	if (!i2s_node) {
> +		dev_err(&pdev->dev, "error getting i2s-controller, exiting\n");
> +		return -ENODEV;
> +	}
> +
> +	snd_i2s_dummy_card.dev = &pdev->dev;
> +	snd_i2s_dummy_card_dai[0].cpu_of_node = i2s_node;
> +	snd_i2s_dummy_card_dai[0].platform_of_node = i2s_node;
> +
> +	ret = devm_snd_soc_register_card(&pdev->dev, &snd_i2s_dummy_card);
> +	if (ret)
> +		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id snd_i2s_dummy_card_of_match[] = {
> +	{ .compatible = "brcm,i2s-dummy-card", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, snd_i2s_dummy_card_of_match);
> +
> +static struct platform_driver snd_i2s_dummy_card_driver = {
> +	.driver	= {
> +		.name = "snd-i2s-dummy-card",
> +		.of_match_table = snd_i2s_dummy_card_of_match,
> +	},
> +	.probe	= snd_i2s_dummy_card_probe,
> +};
> +
> +module_platform_driver(snd_i2s_dummy_card_driver);
> +
> +MODULE_AUTHOR("Matthias Reichl <hias@horus.com>");
> +MODULE_DESCRIPTION("ASoC dummy card driver for testing bcm2835-i2s");
> +MODULE_LICENSE("GPL v2");
>
