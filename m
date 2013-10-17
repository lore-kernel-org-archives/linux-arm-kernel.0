From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 17 Oct 2013 11:42:08 +0200
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131017114208.595a4224@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Xiubo Li <Li.Xiubo@freescale.com> wrote:
[...]
> diff --git a/sound/soc/fsl/fsl-pcm-dma.c b/sound/soc/fsl/fsl-pcm-dma.c
> new file mode 100644
> index 0000000..c4d925e
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-pcm-dma.c
> @@ -0,0 +1,51 @@
[...]
> +
> +static int fsl_sai_probe(struct platform_device *pdev)
> +{
> +	struct of_phandle_args	dma_args;
> +	int index;
> +	struct resource *res;
> +	struct fsl_sai *sai;
> +	int ret = 0;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
> +	if (!sai)
> +		return -ENOMEM;
> +
> +	sai->fbt = FSL_SAI_FBT_MSB;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sai->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(sai->base)) {
> +		ret = PTR_ERR(sai->base);
> +		return ret;
>
could be:
		return PTR_ERR(sai->base);

[...]
> +static const struct of_device_id fsl_sai_ids[] = {
> +	{ .compatible = "fsl,vf610-sai", },
> +	{ /*sentinel*/ },
>
The comma after the last entry in a struct initializer is there to make
patches that append another entry cleaner. Since this entry is and
always must be the last entry, the comma is useless here.

> diff --git a/sound/soc/fsl/fsl-sai.h b/sound/soc/fsl/fsl-sai.h
> new file mode 100644
> index 0000000..ab76a8e
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-sai.h
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __FSL_SAI_H
> +#define __FSL_SAI_H
> +
> +#include <sound/dmaengine_pcm.h>
> +
> +#define FSL_SAI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			 SNDRV_PCM_FMTBIT_S20_3LE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE)
> +
> +#define FSL_SAI_DMABUF_SIZE	(32 * 1024)
> +#define TCD_NUMBER		4
> +#define EDMA_PRIO_HIGH          6
> +
strange indentation with mixed spaces and tabs.

> +/* SAI Transmit and Recieve Configuration 2 Register */
> +#define SAI_TCR2		0x08
> +#define SAI_RCR2		0x88
> +#define SAI_CR2_SYNC		BIT(30)
> +#define SAI_CR2_MSEL_MASK	(0xff << 26)
> +#define SAI_CR2_MSEL_BUS	0
> +#define SAI_CR2_MSEL_MCLK1	BIT(26)
> +#define SAI_CR2_MSEL_MCLK2	BIT(27)
> +#define SAI_CR2_MSEL_MCLK3	(BIT(26)|BIT(27))
>
spaces around '|'?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
