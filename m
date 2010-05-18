From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 18 May 2010 13:36:54 +0800
Subject: [PATCH v2] NUC900/audio: add nuc900 audio driver support
In-Reply-To: <4BF202A7.30602@gmail.com>
References: <4BF01069.6060102@gmail.com>
	<20100517024425.GA2485@opensource.wolfsonmicro.com>
	<4BF0E184.204@gmail.com>
	<20100517134622.GA5257@opensource.wolfsonmicro.com>
	<4BF202A7.30602@gmail.com>
Message-ID: <AANLkTinEdWDeirWSdypHD3LBFmtPdMgSqr955X5NwCn0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear sirs,

Submit wrong patch file, drop it.
I will resubmit it.

2010/5/18 Wan ZongShun <mcuos.com@gmail.com>

> Dear Mark,
>
> I have modified some codes according to your comments,
> now I submit the patch as v2 again.
>
> Thanks a lot for your help.
>
> From 35d6ecb61972919a8c7fd418766bd303dde687b3 Mon Sep 17 00:00:00 2001
> From: zswan <zswan@zswan-marvell.(none)>
> Date: Tue, 18 May 2010 10:51:12 +0800
> Subject: [PATCH 3/3] add-nuc900-audio-driver-support-v5.patch
>
> ---
>  sound/soc/Kconfig               |    1 +
>  sound/soc/Makefile              |    1 +
>  sound/soc/nuc900/Kconfig        |   27 +++
>  sound/soc/nuc900/Makefile       |   11 +
>  sound/soc/nuc900/nuc900-ac97.c  |  443
> +++++++++++++++++++++++++++++++++++++++
>  sound/soc/nuc900/nuc900-audio.c |   81 +++++++
>  sound/soc/nuc900/nuc900-auido.h |  121 +++++++++++
>  sound/soc/nuc900/nuc900-pcm.c   |  352 +++++++++++++++++++++++++++++++
>  8 files changed, 1037 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/nuc900/Kconfig
>  create mode 100644 sound/soc/nuc900/Makefile
>  create mode 100644 sound/soc/nuc900/nuc900-ac97.c
>  create mode 100644 sound/soc/nuc900/nuc900-audio.c
>  create mode 100644 sound/soc/nuc900/nuc900-auido.h
>  create mode 100644 sound/soc/nuc900/nuc900-pcm.c
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index b1749bc..6e04fc2 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -30,6 +30,7 @@ source "sound/soc/blackfin/Kconfig"
>  source "sound/soc/davinci/Kconfig"
>  source "sound/soc/fsl/Kconfig"
>  source "sound/soc/imx/Kconfig"
> +source "sound/soc/nuc900/Kconfig"
>  source "sound/soc/omap/Kconfig"
>  source "sound/soc/pxa/Kconfig"
>  source "sound/soc/s3c24xx/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 1470141..ccec241 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SND_SOC)   += blackfin/
>  obj-$(CONFIG_SND_SOC)  += davinci/
>  obj-$(CONFIG_SND_SOC)  += fsl/
>  obj-$(CONFIG_SND_SOC)   += imx/
> +obj-$(CONFIG_SND_SOC)  += nuc900/
>  obj-$(CONFIG_SND_SOC)  += omap/
>  obj-$(CONFIG_SND_SOC)  += pxa/
>  obj-$(CONFIG_SND_SOC)  += s3c24xx/
> diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nuc900/Kconfig
> new file mode 100644
> index 0000000..a0ed1c6
> --- /dev/null
> +++ b/sound/soc/nuc900/KconfigFrom 35d6ecb61972919a8c7fd418766bd303dde687b3
> Mon Sep 17 00:00:00 2001
> From: zswan <zswan@zswan-marvell.(none)>
> Date: Tue, 18 May 2010 10:51:12 +0800
> Subject: [PATCH 3/3] add-nuc900-audio-driver-support-v5.patch
>
> ---
>  sound/soc/Kconfig               |    1 +
>  sound/soc/Makefile              |    1 +
>  sound/soc/nuc900/Kconfig        |   27 +++
>  sound/soc/nuc900/Makefile       |   11 +
>  sound/soc/nuc900/nuc900-ac97.c  |  443
> +++++++++++++++++++++++++++++++++++++++
>  sound/soc/nuc900/nuc900-audio.c |   81 +++++++
>  sound/soc/nuc900/nuc900-auido.h |  121 +++++++++++
>  sound/soc/nuc900/nuc900-pcm.c   |  352 +++++++++++++++++++++++++++++++
>  8 files changed, 1037 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/nuc900/Kconfig
>  create mode 100644 sound/soc/nuc900/Makefile
>  create mode 100644 sound/soc/nuc900/nuc900-ac97.c
>  create mode 100644 sound/soc/nuc900/nuc900-audio.c
>  create mode 100644 sound/soc/nuc900/nuc900-auido.h
>  create mode 100644 sound/soc/nuc900/nuc900-pcm.c
>
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index b1749bc..6e04fc2 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -30,6 +30,7 @@ source "sound/soc/blackfin/Kconfig"
>  source "sound/soc/davinci/Kconfig"
>  source "sound/soc/fsl/Kconfig"
>  source "sound/soc/imx/Kconfig"
> +source "sound/soc/nuc900/Kconfig"
>  source "sound/soc/omap/Kconfig"
>  source "sound/soc/pxa/Kconfig"
>  source "sound/soc/s3c24xx/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 1470141..ccec241 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SND_SOC)   += blackfin/
>  obj-$(CONFIG_SND_SOC)  += davinci/
>  obj-$(CONFIG_SND_SOC)  += fsl/
>  obj-$(CONFIG_SND_SOC)   += imx/
> +obj-$(CONFIG_SND_SOC)  += nuc900/
>  obj-$(CONFIG_SND_SOC)  += omap/
>  obj-$(CONFIG_SND_SOC)  += pxa/
>  obj-$(CONFIG_SND_SOC)  += s3c24xx/
> diff --git a/sound/soc/nuc900/Kconfig b/sound/soc/nuc900/Kconfig
> new file mode 100644
> index 0000000..a0ed1c6
> --- /dev/null
> +++ b/sound/soc/nuc900/Kconfig
> @@ -0,0 +1,27 @@
> +##
> +## NUC900 series AC97 API
> +##
> +config SND_SOC_NUC900
> +       tristate "SoC Audio for NUC900 series"
> +       depends on ARCH_W90X900
> +       help
> +         This option enables support for AC97 mode on the NUC900 SoC.
> +
> +config SND_SOC_NUC900_AC97
> +       tristate
> +       select AC97_BUS
> +       select SND_AC97_CODEC
> +       select SND_SOC_AC97_BUS
> +
> +
> +##
> +## Boards
> +##
> +config SND_SOC_NUC900EVB
> +       tristate "NUC900 AC97 support for demo board"
> +       depends on SND_SOC_NUC900
> +       select SND_SOC_NUC900_AC97
> +       select SND_SOC_AC97_CODEC
> +       help
> +         Select this option to enable audio (AC97) on the
> +         NUC900 demoboard.
> diff --git a/sound/soc/nuc900/Makefile b/sound/soc/nuc900/Makefile
> new file mode 100644
> index 0000000..7e46c71
> --- /dev/null
> +++ b/sound/soc/nuc900/Makefile
> @@ -0,0 +1,11 @@
> +# NUC900 series audio
> +snd-soc-nuc900-pcm-objs := nuc900-pcm.o
> +snd-soc-nuc900-ac97-objs := nuc900-ac97.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900) += snd-soc-nuc900-pcm.o
> +obj-$(CONFIG_SND_SOC_NUC900_AC97) += snd-soc-nuc900-ac97.o
> +
> +# Boards
> +snd-soc-nuc900-audio-objs := nuc900-audio.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900EVB) += snd-soc-nuc900-audio.o
> diff --git a/sound/soc/nuc900/nuc900-ac97.c
> b/sound/soc/nuc900/nuc900-ac97.c
> new file mode 100644
> index 0000000..2c345e2
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -0,0 +1,443 @@
> +/*
> + * Copyright (c) 2009-2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/suspend.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <linux/device.h>
> +#include <linux/clk.h>
> +
> +#include <mach/mfp.h>
> +
> +#include "nuc900-auido.h"
> +
> +static DEFINE_MUTEX(ac97_mutex);
> +struct nuc900_audio *nuc900_ac97_data;
> +
> +static int nuc900_checkready(void)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +/* AC97 controller reads codec register */
> +static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
> +                                       unsigned short reg)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long timeout = 0x10000, val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       val = nuc900_checkready();
> +       if (!!val) {
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +               goto out;
> +       }
> +
> +       /* set the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, R_WB | reg);
> +
> +       /* set the valid frame bit and valid slots */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       val |= (VALID_FRAME | SLOT1_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       udelay(100);
> +
> +       /* polling the AC_R_FINISH */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= AC_R_FINISH;
> +       while (!val && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout) {
> +               dev_err(nuc900_audio->dev, "AC97 read register time out
> !\n");
> +               val = -EPERM;
> +               goto out;
> +       }
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0) ;
> +       val &= ~SLOT1_VALID;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       if (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS1) >> 2 != reg) {
> +               dev_err(nuc900_audio->dev,
> +                               "R_INDEX of REG_ACTL_ACIS1 not match!\n");
> +       }
> +
> +       udelay(100);
> +       val = (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS2) & 0xFFFF);
> +
> +out:
> +       mutex_unlock(&ac97_mutex);
> +       return val;
> +}
> +
> +/* AC97 controller writes to codec register */
> +static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> +                               unsigned short val)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long tmp, timeout = 0x10000;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       tmp = nuc900_checkready();
> +       if (!!tmp)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       /* clear the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, reg);
> +
> +       /* write register value */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS2, val);
> +
> +       /* set the valid frame bit and valid slots */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp |= SLOT1_VALID | SLOT2_VALID | VALID_FRAME;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       udelay(100);
> +
> +       /* polling the AC_W_FINISH */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       tmp &= AC_W_FINISH;
> +       while (tmp && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout)
> +               dev_err(nuc900_audio->dev, "AC97 write register time out
> !\n");
> +
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp &= ~(SLOT1_VALID | SLOT2_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* warm reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_W_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = nuc900_checkready();
> +       if (!!val)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       mutex_unlock(&ac97_mutex);
> +}
> +
> +static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* reset Audio Controller */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= ACTL_RESET_BIT;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= (~ACTL_RESET_BIT);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* reset AC-link interface */
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= ~AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* cold reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_C_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= (~AC_C_RES);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +/* AC97 controller operations */
> +struct snd_ac97_bus_ops soc_ac97_ops = {
> +       .read           = nuc900_ac97_read,
> +       .write          = nuc900_ac97_write,
> +       .reset          = nuc900_ac97_cold_reset,
> +       .warm_reset     = nuc900_ac97_warm_reset,
> +}
> +EXPORT_SYMBOL_GPL(soc_ac97_ops);
> +
> +static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
> +                               int cmd, struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       int ret, stype = SUBSTREAM_TYPE(substream);
> +       unsigned long val, tmp;
> +
> +       ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp |= (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +                       tmp |= (P_DMA_END_IRQ | P_DMA_MIDDLE_IRQ);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, tmp);
> +                       val |= AC_PLAY;
> +               } else {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +                       tmp |= (R_DMA_END_IRQ | R_DMA_MIDDLE_IRQ);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, tmp);
> +                       val |= AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp &= ~(SLOT3_VALID | SLOT4_VALID);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR,
> RESET_PRSR);
> +                       val &= ~AC_PLAY;
> +               } else {
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR,
> RESET_PRSR);
> +                       val &= ~AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int nuc900_ac97_probe(struct platform_device *pdev,
> +                                       struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* enable unit clock */
> +       clk_enable(nuc900_audio->clk);
> +
> +       /* enable audio controller and AC-link interface */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (IIS_AC_PIN_SEL | ACLINK_EN);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +       return 0;
> +}
> +
> +static void nuc900_ac97_remove(struct platform_device *pdev,
> +                                               struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       clk_disable(nuc900_audio->clk);
> +}
> +
> +static struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
> +       .trigger        = nuc900_ac97_trigger,
> +};
> +
> +struct snd_soc_dai nuc900_ac97_dai = {
> +       .name                   = "nuc900-ac97",
> +       .probe                  = nuc900_ac97_probe,
> +       .remove                 = nuc900_ac97_remove,
> +       .ac97_control           = 1,
> +       .playback = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .capture = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .ops = &nuc900_ac97_dai_ops,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_ac97_dai);
> +
> +static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
> +{
> +       struct nuc900_audio *nuc900_audio;
> +       int ret;
> +
> +       if (nuc900_ac97_data)
> +               return -EBUSY;
> +
> +       nuc900_audio = kzalloc(sizeof(struct nuc900_audio), GFP_KERNEL);
> +       if (!nuc900_audio)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&nuc900_audio->lock);
> +
> +       nuc900_audio->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!nuc900_audio->res) {
> +               ret = -ENODEV;
> +               goto out0;
> +       }
> +
> +       if (!request_mem_region(nuc900_audio->res->start,
> +                       resource_size(nuc900_audio->res), pdev->name)) {
> +               ret = -EBUSY;
> +               goto out0;
> +       }
> +
> +       nuc900_audio->mmio = ioremap(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +       if (!nuc900_audio->mmio) {
> +               ret = -ENOMEM;
> +               goto out1;
> +       }
> +
> +       nuc900_audio->clk = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(nuc900_audio->clk)) {
> +               ret = PTR_ERR(nuc900_audio->clk);
> +               goto out2;
> +       }
> +
> +       nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> +       if (!nuc900_audio->irq_num) {
> +               ret = -EBUSY;
> +               goto out2;
> +       }
> +
> +       nuc900_ac97_data = nuc900_audio;
> +
> +       nuc900_audio->dev = nuc900_ac97_dai.dev =  &pdev->dev;
> +
> +       ret = snd_soc_register_dai(&nuc900_ac97_dai);
> +       if (ret)
> +               goto out3;
> +
> +       mfp_set_groupg(nuc900_audio->dev); /* enbale ac97 multifunction
> pin*/
> +
> +       return 0;
> +
> +out3:
> +       clk_put(nuc900_audio->clk);
> +out2:
> +       iounmap(nuc900_audio->mmio);
> +out1:
> +       release_mem_region(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +out0:
> +       kfree(nuc900_audio);
> +       return ret;
> +}
> +
> +static int __devexit nuc900_ac97_drvremove(struct platform_device *pdev)
> +{
> +
> +       snd_soc_unregister_dai(&nuc900_ac97_dai);
> +
> +       clk_put(nuc900_ac97_data->clk);
> +       iounmap(nuc900_ac97_data->mmio);
> +       release_mem_region(nuc900_ac97_data->res->start,
> +                               resource_size(nuc900_ac97_data->res));
> +
> +       nuc900_ac97_data = NULL;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver nuc900_ac97_driver = {
> +       .driver = {
> +               .name   = "nuc900-audio",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe          = nuc900_ac97_drvprobe,
> +       .remove         = __devexit_p(nuc900_ac97_drvremove),
> +};
> +
> +static int __init nuc900_ac97_init(void)
> +{
> +       return platform_driver_register(&nuc900_ac97_driver);
> +}
> +
> +static void __exit nuc900_ac97_exit(void)
> +{
> +       platform_driver_unregister(&nuc900_ac97_driver);
> +}
> +
> +module_init(nuc900_ac97_init);
> +module_exit(nuc900_ac97_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("NUC900 AC97 SoC driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:nuc900-ac97");
> +
> diff --git a/sound/soc/nuc900/nuc900-audio.c
> b/sound/soc/nuc900/nuc900-audio.c
> new file mode 100644
> index 0000000..b33d5b8
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-audio.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/timer.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include "../codecs/ac97.h"
> +#include "nuc900-auido.h"
> +
> +static struct snd_soc_dai_link nuc900evb_ac97_dai = {
> +       .name           = "AC97",
> +       .stream_name    = "AC97 HiFi",
> +       .cpu_dai        = &nuc900_ac97_dai,
> +       .codec_dai      = &ac97_dai,
> +};
> +
> +static struct snd_soc_card nuc900evb_audio_machine = {
> +       .name           = "NUC900EVB_AC97",
> +       .dai_link       = &nuc900evb_ac97_dai,
> +       .num_links      = 1,
> +       .platform       = &nuc900_soc_platform,
> +};
> +
> +static struct snd_soc_device nuc900evb_ac97_devdata = {
> +       .card           = &nuc900evb_audio_machine,
> +       .codec_dev      = &soc_codec_dev_ac97,
> +};
> +
> +static struct platform_device *nuc900evb_asoc_dev;
> +
> +static int __init nuc900evb_audio_init(void)
> +{
> +       int ret;
> +
> +       ret = -ENOMEM;
> +       nuc900evb_asoc_dev = platform_device_alloc("soc-audio", -1);
> +       if (!nuc900evb_asoc_dev)
> +               goto out;
> +
> +       /* nuc900 board audio device */
> +       platform_set_drvdata(nuc900evb_asoc_dev, &nuc900evb_ac97_devdata);
> +
> +       nuc900evb_ac97_devdata.dev = &nuc900evb_asoc_dev->dev;
> +       ret = platform_device_add(nuc900evb_asoc_dev);
> +
> +       if (ret) {
> +               platform_device_put(nuc900evb_asoc_dev);
> +               nuc900evb_asoc_dev = NULL;
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static void __exit nuc900evb_audio_exit(void)
> +{
> +       platform_device_unregister(nuc900evb_asoc_dev);
> +}
> +
> +module_init(nuc900evb_audio_init);
> +module_exit(nuc900evb_audio_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NUC900 Series ASoC audio support");
> +MODULE_AUTHOR("Wan ZongShun");
> diff --git a/sound/soc/nuc900/nuc900-auido.h
> b/sound/soc/nuc900/nuc900-auido.h
> new file mode 100644
> index 0000000..95ac4ef
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-auido.h
> @@ -0,0 +1,121 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#ifndef _NUC900_AUDIO_H
> +#define _NUC900_AUDIO_H
> +
> +#include <linux/io.h>
> +
> +/* Audio Control Registers */
> +#define ACTL_CON               0x00
> +#define ACTL_RESET             0x04
> +#define ACTL_RDSTB             0x08
> +#define ACTL_RDST_LENGTH       0x0C
> +#define ACTL_RDSTC             0x10
> +#define ACTL_RSR               0x14
> +#define ACTL_PDSTB             0x18
> +#define ACTL_PDST_LENGTH       0x1C
> +#define ACTL_PDSTC             0x20
> +#define ACTL_PSR               0x24
> +#define ACTL_IISCON            0x28
> +#define ACTL_ACCON             0x2C
> +#define ACTL_ACOS0             0x30
> +#define ACTL_ACOS1             0x34
> +#define ACTL_ACOS2             0x38
> +#define ACTL_ACIS0             0x3C
> +#define ACTL_ACIS1             0x40
> +#define ACTL_ACIS2             0x44
> +#define ACTL_COUNTER           0x48
> +
> +/* bit definition of REG_ACTL_CON register */
> +#define R_DMA_IRQ              0x1000
> +#define T_DMA_IRQ              0x0800
> +#define IIS_AC_PIN_SEL         0x0100
> +#define FIFO_TH                        0x0080
> +#define ADC_EN                 0x0010
> +#define M80_EN                 0x0008
> +#define ACLINK_EN              0x0004
> +#define IIS_EN                 0x0002
> +
> +/* bit definition of REG_ACTL_RESET register */
> +#define W5691_PLAY             0x20000
> +#define ACTL_RESET_BIT         0x10000
> +#define RECORD_RIGHT_CHNNEL    0x08000
> +#define RECORD_LEFT_CHNNEL     0x04000
> +#define PLAY_RIGHT_CHNNEL      0x02000
> +#define PLAY_LEFT_CHNNEL       0x01000
> +#define DAC_PLAY               0x00800
> +#define ADC_RECORD             0x00400
> +#define M80_PLAY               0x00200
> +#define AC_RECORD              0x00100
> +#define AC_PLAY                        0x00080
> +#define IIS_RECORD             0x00040
> +#define IIS_PLAY               0x00020
> +#define DAC_RESET              0x00010
> +#define ADC_RESET              0x00008
> +#define M80_RESET              0x00004
> +#define AC_RESET               0x00002
> +#define IIS_RESET              0x00001
> +
> +/* bit definition of REG_ACTL_ACCON register */
> +#define AC_BCLK_PU_EN          0x20
> +#define AC_R_FINISH            0x10
> +#define AC_W_FINISH            0x08
> +#define AC_W_RES               0x04
> +#define AC_C_RES               0x02
> +
> +/* bit definition of ACTL_RSR register */
> +#define R_FIFO_EMPTY           0x04
> +#define R_DMA_END_IRQ          0x02
> +#define R_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_PSR register */
> +#define P_FIFO_EMPTY           0x04
> +#define P_DMA_END_IRQ          0x02
> +#define P_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_ACOS0 register */
> +#define SLOT1_VALID            0x01
> +#define SLOT2_VALID            0x02
> +#define SLOT3_VALID            0x04
> +#define SLOT4_VALID            0x08
> +#define VALID_FRAME            0x10
> +
> +/* bit definition of ACTL_ACOS1 register */
> +#define R_WB                   0x80
> +
> +#define CODEC_READY            0x10
> +#define RESET_PRSR             0x00
> +#define AUDIO_WRITE(addr, val) __raw_writel(val, addr)
> +#define AUDIO_READ(addr)       __raw_readl(addr)
> +#define PCM_TX                 0
> +#define PCM_RX                 1
> +#define SUBSTREAM_TYPE(substream) \
> +       ((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX :
> PCM_RX)
> +
> +struct nuc900_audio {
> +       void __iomem *mmio;
> +       spinlock_t lock;
> +       dma_addr_t dma_addr[2];
> +       unsigned long buffersize[2];
> +       unsigned long irq_num;
> +       struct snd_pcm_substream *substream;
> +       struct resource *res;
> +       struct clk *clk;
> +       struct device *dev;
> +
> +};
> +
> +extern struct nuc900_audio *nuc900_ac97_data;
> +extern struct snd_soc_dai nuc900_ac97_dai;
> +extern struct snd_soc_platform nuc900_soc_platform;
> +
> +#endif /*end _NUC900_AUDIO_H */
> diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
> new file mode 100644
> index 0000000..32a503c
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-pcm.c
> @@ -0,0 +1,352 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <mach/hardware.h>
> +
> +#include "nuc900-auido.h"
> +
> +static const struct snd_pcm_hardware nuc900_pcm_hardware = {
> +       .info                   = SNDRV_PCM_INFO_INTERLEAVED |
> +                                       SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +                                       SNDRV_PCM_INFO_MMAP |
> +                                       SNDRV_PCM_INFO_MMAP_VALID |
> +                                       SNDRV_PCM_INFO_PAUSE |
> +                                       SNDRV_PCM_INFO_RESUME,
> +       .formats                = SNDRV_PCM_FMTBIT_S16_LE,
> +       .channels_min           = 1,
> +       .channels_max           = 2,
> +       .buffer_bytes_max       = 4*1024,
> +       .period_bytes_min       = 1*1024,
> +       .period_bytes_max       = 4*1024,
> +       .periods_min            = 1,
> +       .periods_max            = 1024,
> +};
> +
> +static int nuc900_dma_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, stype = SUBSTREAM_TYPE(substream);
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       ret = snd_pcm_lib_malloc_pages(substream,
> params_buffer_bytes(params));
> +       if (ret < 0)
> +               return ret;
> +
> +       nuc900_audio->substream = substream;
> +       nuc900_audio->dma_addr[stype] = runtime->dma_addr;
> +       nuc900_audio->buffersize[stype] = params_buffer_bytes(params);
> +
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +
> +       return ret;
> +}
> +
> +static void nuc900_update_dma_register(struct snd_pcm_substream
> *substream,
> +                               dma_addr_t dma_addr, size_t count)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       void __iomem *mmio_addr, *mmio_len;
> +
> +       if (SUBSTREAM_TYPE(substream) == PCM_TX) {
> +               mmio_addr = nuc900_audio->mmio + ACTL_PDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_PDST_LENGTH;
> +       } else {
> +               mmio_addr = nuc900_audio->mmio + ACTL_RDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_RDST_LENGTH;
> +       }
> +
> +       AUDIO_WRITE(mmio_addr, dma_addr);
> +       AUDIO_WRITE(mmio_len, count);
> +}
> +
> +static void nuc900_dma_start(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static void nuc900_dma_stop(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val &= ~(T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)
> +{
> +       struct snd_pcm_substream *substream = dev_id;
> +       struct nuc900_audio *nuc900_audio =
> substream->runtime->private_data;
> +       unsigned long val;
> +
> +       spin_lock(&nuc900_audio->lock);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +
> +       if (val & R_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> R_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +
> +               if (val & R_DMA_MIDDLE_IRQ) {
> +                       val |= R_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +
> +               if (val & R_DMA_END_IRQ) {
> +                       val |= R_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +       } else if (val & T_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> T_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +
> +               if (val & P_DMA_MIDDLE_IRQ) {
> +                       val |= P_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +
> +               if (val & P_DMA_END_IRQ) {
> +                       val |= P_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +       } else {
> +               dev_err(nuc900_audio->dev, "Wrong DMA interrupt
> status!\n");
> +               spin_unlock(&nuc900_audio->lock);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_unlock(&nuc900_audio->lock);
> +
> +       snd_pcm_period_elapsed(substream);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int nuc900_dma_hw_free(struct snd_pcm_substream *substream)
> +{
> +       snd_pcm_lib_free_pages(substream);
> +       return 0;
> +}
> +
> +static int nuc900_dma_prepare(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, val, stype = SUBSTREAM_TYPE(substream);;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       nuc900_update_dma_register(substream,
> +               nuc900_audio->dma_addr[stype],
> nuc900_audio->buffersize[stype]);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +
> +       switch (runtime->channels) {
> +       case 1:
> +               if (PCM_TX == stype) {
> +                       val &= ~(PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +                       val |= PLAY_RIGHT_CHNNEL;
> +               } else {
> +                       val &= ~(RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +                       val |= RECORD_RIGHT_CHNNEL;
> +               }
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       case 2:
> +               if (PCM_TX == stype)
> +                       val |= (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +               else
> +                       val |= (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +       return 0;
> +}
> +
> +static int nuc900_dma_trigger(struct snd_pcm_substream *substream, int
> cmd)
> +{
> +       int ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               nuc900_dma_start(substream);
> +               break;
> +
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               nuc900_dma_stop(substream);
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +int nuc900_dma_getposition(struct snd_pcm_substream *substream,
> +                                       dma_addr_t *src, dma_addr_t *dst)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       if (src != NULL)
> +               *src = AUDIO_READ(nuc900_audio->mmio + ACTL_PDSTC);
> +
> +       if (dst != NULL)
> +               *dst = AUDIO_READ(nuc900_audio->mmio + ACTL_RDSTC);
> +
> +       return 0;
> +}
> +
> +static snd_pcm_uframes_t nuc900_dma_pointer(struct snd_pcm_substream
> *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       dma_addr_t src, dst;
> +       unsigned long res;
> +
> +       nuc900_dma_getposition(substream, &src, &dst);
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +               res = dst - runtime->dma_addr;
> +       else
> +               res = src - runtime->dma_addr;
> +
> +       return bytes_to_frames(substream->runtime, res);
> +}
> +
> +static int nuc900_dma_open(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio;
> +
> +       snd_soc_set_runtime_hwparams(substream, &nuc900_pcm_hardware);
> +
> +       nuc900_audio = nuc900_ac97_data;
> +
> +       if (request_irq(nuc900_audio->irq_num, nuc900_dma_interrupt,
> +                       IRQF_DISABLED, "nuc900-dma", substream))
> +               return -EBUSY;
> +
> +       runtime->private_data = nuc900_audio;
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_close(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       free_irq(nuc900_audio->irq_num, substream);
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_mmap(struct snd_pcm_substream *substream,
> +       struct vm_area_struct *vma)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +       return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +                                       runtime->dma_area,
> +                                       runtime->dma_addr,
> +                                       runtime->dma_bytes);
> +}
> +
> +static struct snd_pcm_ops nuc900_dma_ops = {
> +       .open           = nuc900_dma_open,
> +       .close          = nuc900_dma_close,
> +       .ioctl          = snd_pcm_lib_ioctl,
> +       .hw_params      = nuc900_dma_hw_params,
> +       .hw_free        = nuc900_dma_hw_free,
> +       .prepare        = nuc900_dma_prepare,
> +       .trigger        = nuc900_dma_trigger,
> +       .pointer        = nuc900_dma_pointer,
> +       .mmap           = nuc900_dma_mmap,
> +};
> +
> +static void nuc900_dma_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +       snd_pcm_lib_preallocate_free_for_all(pcm);
> +}
> +
> +static u64 nuc900_pcm_dmamask = DMA_BIT_MASK(32);
> +static int nuc900_dma_new(struct snd_card *card,
> +       struct snd_soc_dai *dai, struct snd_pcm *pcm)
> +{
> +       if (!card->dev->dma_mask)
> +               card->dev->dma_mask = &nuc900_pcm_dmamask;
> +       if (!card->dev->coherent_dma_mask)
> +               card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +       snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> +               card->dev, 4 * 1024, (4 * 1024) - 1);
> +
> +       return 0;
> +}
> +
> +struct snd_soc_platform nuc900_soc_platform = {
> +       .name           = "nuc900-dma",
> +       .pcm_ops        = &nuc900_dma_ops,
> +       .pcm_new        = nuc900_dma_new,
> +       .pcm_free       = nuc900_dma_free_dma_buffers,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_soc_platform);
> +
> +static int __init nuc900_soc_platform_init(void)
> +{
> +       return snd_soc_register_platform(&nuc900_soc_platform);
> +}
> +
> +static void __exit nuc900_soc_platform_exit(void)
> +{
> +       snd_soc_unregister_platform(&nuc900_soc_platform);
> +}
> +
> +module_init(nuc900_soc_platform_init);
> +module_exit(nuc900_soc_platform_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("nuc900 Audio DMA module");
> +MODULE_LICENSE("GPL");
> --
> 1.6.3.3
>
> @@ -0,0 +1,27 @@
> +##
> +## NUC900 series AC97 API
> +##
> +config SND_SOC_NUC900
> +       tristate "SoC Audio for NUC900 series"
> +       depends on ARCH_W90X900
> +       help
> +         This option enables support for AC97 mode on the NUC900 SoC.
> +
> +config SND_SOC_NUC900_AC97
> +       tristate
> +       select AC97_BUS
> +       select SND_AC97_CODEC
> +       select SND_SOC_AC97_BUS
> +
> +
> +##
> +## Boards
> +##
> +config SND_SOC_NUC900EVB
> +       tristate "NUC900 AC97 support for demo board"
> +       depends on SND_SOC_NUC900
> +       select SND_SOC_NUC900_AC97
> +       select SND_SOC_AC97_CODEC
> +       help
> +         Select this option to enable audio (AC97) on the
> +         NUC900 demoboard.
> diff --git a/sound/soc/nuc900/Makefile b/sound/soc/nuc900/Makefile
> new file mode 100644
> index 0000000..7e46c71
> --- /dev/null
> +++ b/sound/soc/nuc900/Makefile
> @@ -0,0 +1,11 @@
> +# NUC900 series audio
> +snd-soc-nuc900-pcm-objs := nuc900-pcm.o
> +snd-soc-nuc900-ac97-objs := nuc900-ac97.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900) += snd-soc-nuc900-pcm.o
> +obj-$(CONFIG_SND_SOC_NUC900_AC97) += snd-soc-nuc900-ac97.o
> +
> +# Boards
> +snd-soc-nuc900-audio-objs := nuc900-audio.o
> +
> +obj-$(CONFIG_SND_SOC_NUC900EVB) += snd-soc-nuc900-audio.o
> diff --git a/sound/soc/nuc900/nuc900-ac97.c
> b/sound/soc/nuc900/nuc900-ac97.c
> new file mode 100644
> index 0000000..2c345e2
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -0,0 +1,443 @@
> +/*
> + * Copyright (c) 2009-2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/suspend.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include <linux/device.h>
> +#include <linux/clk.h>
> +
> +#include <mach/mfp.h>
> +
> +#include "nuc900-auido.h"
> +
> +static DEFINE_MUTEX(ac97_mutex);
> +struct nuc900_audio *nuc900_ac97_data;
> +
> +static int nuc900_checkready(void)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +/* AC97 controller reads codec register */
> +static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
> +                                       unsigned short reg)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long timeout = 0x10000, val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       val = nuc900_checkready();
> +       if (!!val) {
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +               goto out;
> +       }
> +
> +       /* set the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, R_WB | reg);
> +
> +       /* set the valid frame bit and valid slots */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       val |= (VALID_FRAME | SLOT1_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       udelay(100);
> +
> +       /* polling the AC_R_FINISH */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= AC_R_FINISH;
> +       while (!val && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout) {
> +               dev_err(nuc900_audio->dev, "AC97 read register time out
> !\n");
> +               val = -EPERM;
> +               goto out;
> +       }
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0) ;
> +       val &= ~SLOT1_VALID;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);
> +
> +       if (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS1) >> 2 != reg) {
> +               dev_err(nuc900_audio->dev,
> +                               "R_INDEX of REG_ACTL_ACIS1 not match!\n");
> +       }
> +
> +       udelay(100);
> +       val = (AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS2) & 0xFFFF);
> +
> +out:
> +       mutex_unlock(&ac97_mutex);
> +       return val;
> +}
> +
> +/* AC97 controller writes to codec register */
> +static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> +                               unsigned short val)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long tmp, timeout = 0x10000;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       tmp = nuc900_checkready();
> +       if (!!tmp)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       /* clear the R_WB bit and write register index */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS1, reg);
> +
> +       /* write register value */
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS2, val);
> +
> +       /* set the valid frame bit and valid slots */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp |= SLOT1_VALID | SLOT2_VALID | VALID_FRAME;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       udelay(100);
> +
> +       /* polling the AC_W_FINISH */
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       tmp &= AC_W_FINISH;
> +       while (tmp && timeout--)
> +               mdelay(1);
> +
> +       if (!timeout)
> +               dev_err(nuc900_audio->dev, "AC97 write register time out
> !\n");
> +
> +       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +       tmp &= ~(SLOT1_VALID | SLOT2_VALID);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +static void nuc900_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* warm reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_W_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = nuc900_checkready();
> +       if (!!val)
> +               dev_err(nuc900_audio->dev, "AC97 codec is not ready\n");
> +
> +       mutex_unlock(&ac97_mutex);
> +}
> +
> +static void nuc900_ac97_cold_reset(struct snd_ac97 *ac97)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* reset Audio Controller */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= ACTL_RESET_BIT;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= (~ACTL_RESET_BIT);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* reset AC-link interface */
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val |= AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +       val &= ~AC_RESET;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +       udelay(1000);
> +
> +       /* cold reset AC 97 */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val |= AC_C_RES;
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +       val &= (~AC_C_RES);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);
> +
> +       udelay(1000);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +}
> +
> +/* AC97 controller operations */
> +struct snd_ac97_bus_ops soc_ac97_ops = {
> +       .read           = nuc900_ac97_read,
> +       .write          = nuc900_ac97_write,
> +       .reset          = nuc900_ac97_cold_reset,
> +       .warm_reset     = nuc900_ac97_warm_reset,
> +}
> +EXPORT_SYMBOL_GPL(soc_ac97_ops);
> +
> +static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
> +                               int cmd, struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       int ret, stype = SUBSTREAM_TYPE(substream);
> +       unsigned long val, tmp;
> +
> +       ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp |= (SLOT3_VALID | SLOT4_VALID | VALID_FRAME);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +                       tmp |= (P_DMA_END_IRQ | P_DMA_MIDDLE_IRQ);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, tmp);
> +                       val |= AC_PLAY;
> +               } else {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +                       tmp |= (R_DMA_END_IRQ | R_DMA_MIDDLE_IRQ);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, tmp);
> +                       val |= AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +               if (PCM_TX == stype) {
> +                       tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
> +                       tmp &= ~(SLOT3_VALID | SLOT4_VALID);
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, tmp);
> +
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR,
> RESET_PRSR);
> +                       val &= ~AC_PLAY;
> +               } else {
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR,
> RESET_PRSR);
> +                       val &= ~AC_RECORD;
> +               }
> +
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int nuc900_ac97_probe(struct platform_device *pdev,
> +                                       struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +       unsigned long val;
> +
> +       mutex_lock(&ac97_mutex);
> +
> +       /* enable unit clock */
> +       clk_enable(nuc900_audio->clk);
> +
> +       /* enable audio controller and AC-link interface */
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (IIS_AC_PIN_SEL | ACLINK_EN);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +
> +       mutex_unlock(&ac97_mutex);
> +
> +       return 0;
> +}
> +
> +static void nuc900_ac97_remove(struct platform_device *pdev,
> +                                               struct snd_soc_dai *dai)
> +{
> +       struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +       clk_disable(nuc900_audio->clk);
> +}
> +
> +static struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
> +       .trigger        = nuc900_ac97_trigger,
> +};
> +
> +struct snd_soc_dai nuc900_ac97_dai = {
> +       .name                   = "nuc900-ac97",
> +       .probe                  = nuc900_ac97_probe,
> +       .remove                 = nuc900_ac97_remove,
> +       .ac97_control           = 1,
> +       .playback = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .capture = {
> +               .rates          = SNDRV_PCM_RATE_8000_48000,
> +               .formats        = SNDRV_PCM_FMTBIT_S16_LE,
> +               .channels_min   = 1,
> +               .channels_max   = 2,
> +       },
> +       .ops = &nuc900_ac97_dai_ops,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_ac97_dai);
> +
> +static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
> +{
> +       struct nuc900_audio *nuc900_audio;
> +       int ret;
> +
> +       if (nuc900_ac97_data)
> +               return -EBUSY;
> +
> +       nuc900_audio = kzalloc(sizeof(struct nuc900_audio), GFP_KERNEL);
> +       if (!nuc900_audio)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&nuc900_audio->lock);
> +
> +       nuc900_audio->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!nuc900_audio->res) {
> +               ret = -ENODEV;
> +               goto out0;
> +       }
> +
> +       if (!request_mem_region(nuc900_audio->res->start,
> +                       resource_size(nuc900_audio->res), pdev->name)) {
> +               ret = -EBUSY;
> +               goto out0;
> +       }
> +
> +       nuc900_audio->mmio = ioremap(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +       if (!nuc900_audio->mmio) {
> +               ret = -ENOMEM;
> +               goto out1;
> +       }
> +
> +       nuc900_audio->clk = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(nuc900_audio->clk)) {
> +               ret = PTR_ERR(nuc900_audio->clk);
> +               goto out2;
> +       }
> +
> +       nuc900_audio->irq_num = platform_get_irq(pdev, 0);
> +       if (!nuc900_audio->irq_num) {
> +               ret = -EBUSY;
> +               goto out2;
> +       }
> +
> +       nuc900_ac97_data = nuc900_audio;
> +
> +       nuc900_audio->dev = nuc900_ac97_dai.dev =  &pdev->dev;
> +
> +       ret = snd_soc_register_dai(&nuc900_ac97_dai);
> +       if (ret)
> +               goto out3;
> +
> +       mfp_set_groupg(nuc900_audio->dev); /* enbale ac97 multifunction
> pin*/
> +
> +       return 0;
> +
> +out3:
> +       clk_put(nuc900_audio->clk);
> +out2:
> +       iounmap(nuc900_audio->mmio);
> +out1:
> +       release_mem_region(nuc900_audio->res->start,
> +                                       resource_size(nuc900_audio->res));
> +out0:
> +       kfree(nuc900_audio);
> +       return ret;
> +}
> +
> +static int __devexit nuc900_ac97_drvremove(struct platform_device *pdev)
> +{
> +
> +       snd_soc_unregister_dai(&nuc900_ac97_dai);
> +
> +       clk_put(nuc900_ac97_data->clk);
> +       iounmap(nuc900_ac97_data->mmio);
> +       release_mem_region(nuc900_ac97_data->res->start,
> +                               resource_size(nuc900_ac97_data->res));
> +
> +       nuc900_ac97_data = NULL;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver nuc900_ac97_driver = {
> +       .driver = {
> +               .name   = "nuc900-audio",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe          = nuc900_ac97_drvprobe,
> +       .remove         = __devexit_p(nuc900_ac97_drvremove),
> +};
> +
> +static int __init nuc900_ac97_init(void)
> +{
> +       return platform_driver_register(&nuc900_ac97_driver);
> +}
> +
> +static void __exit nuc900_ac97_exit(void)
> +{
> +       platform_driver_unregister(&nuc900_ac97_driver);
> +}
> +
> +module_init(nuc900_ac97_init);
> +module_exit(nuc900_ac97_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("NUC900 AC97 SoC driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:nuc900-ac97");
> +
> diff --git a/sound/soc/nuc900/nuc900-audio.c
> b/sound/soc/nuc900/nuc900-audio.c
> new file mode 100644
> index 0000000..b33d5b8
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-audio.c
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/timer.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include "../codecs/ac97.h"
> +#include "nuc900-auido.h"
> +
> +static struct snd_soc_dai_link nuc900evb_ac97_dai = {
> +       .name           = "AC97",
> +       .stream_name    = "AC97 HiFi",
> +       .cpu_dai        = &nuc900_ac97_dai,
> +       .codec_dai      = &ac97_dai,
> +};
> +
> +static struct snd_soc_card nuc900evb_audio_machine = {
> +       .name           = "NUC900EVB_AC97",
> +       .dai_link       = &nuc900evb_ac97_dai,
> +       .num_links      = 1,
> +       .platform       = &nuc900_soc_platform,
> +};
> +
> +static struct snd_soc_device nuc900evb_ac97_devdata = {
> +       .card           = &nuc900evb_audio_machine,
> +       .codec_dev      = &soc_codec_dev_ac97,
> +};
> +
> +static struct platform_device *nuc900evb_asoc_dev;
> +
> +static int __init nuc900evb_audio_init(void)
> +{
> +       int ret;
> +
> +       ret = -ENOMEM;
> +       nuc900evb_asoc_dev = platform_device_alloc("soc-audio", -1);
> +       if (!nuc900evb_asoc_dev)
> +               goto out;
> +
> +       /* nuc900 board audio device */
> +       platform_set_drvdata(nuc900evb_asoc_dev, &nuc900evb_ac97_devdata);
> +
> +       nuc900evb_ac97_devdata.dev = &nuc900evb_asoc_dev->dev;
> +       ret = platform_device_add(nuc900evb_asoc_dev);
> +
> +       if (ret) {
> +               platform_device_put(nuc900evb_asoc_dev);
> +               nuc900evb_asoc_dev = NULL;
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +static void __exit nuc900evb_audio_exit(void)
> +{
> +       platform_device_unregister(nuc900evb_asoc_dev);
> +}
> +
> +module_init(nuc900evb_audio_init);
> +module_exit(nuc900evb_audio_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NUC900 Series ASoC audio support");
> +MODULE_AUTHOR("Wan ZongShun");
> diff --git a/sound/soc/nuc900/nuc900-auido.h
> b/sound/soc/nuc900/nuc900-auido.h
> new file mode 100644
> index 0000000..95ac4ef
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-auido.h
> @@ -0,0 +1,121 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#ifndef _NUC900_AUDIO_H
> +#define _NUC900_AUDIO_H
> +
> +#include <linux/io.h>
> +
> +/* Audio Control Registers */
> +#define ACTL_CON               0x00
> +#define ACTL_RESET             0x04
> +#define ACTL_RDSTB             0x08
> +#define ACTL_RDST_LENGTH       0x0C
> +#define ACTL_RDSTC             0x10
> +#define ACTL_RSR               0x14
> +#define ACTL_PDSTB             0x18
> +#define ACTL_PDST_LENGTH       0x1C
> +#define ACTL_PDSTC             0x20
> +#define ACTL_PSR               0x24
> +#define ACTL_IISCON            0x28
> +#define ACTL_ACCON             0x2C
> +#define ACTL_ACOS0             0x30
> +#define ACTL_ACOS1             0x34
> +#define ACTL_ACOS2             0x38
> +#define ACTL_ACIS0             0x3C
> +#define ACTL_ACIS1             0x40
> +#define ACTL_ACIS2             0x44
> +#define ACTL_COUNTER           0x48
> +
> +/* bit definition of REG_ACTL_CON register */
> +#define R_DMA_IRQ              0x1000
> +#define T_DMA_IRQ              0x0800
> +#define IIS_AC_PIN_SEL         0x0100
> +#define FIFO_TH                        0x0080
> +#define ADC_EN                 0x0010
> +#define M80_EN                 0x0008
> +#define ACLINK_EN              0x0004
> +#define IIS_EN                 0x0002
> +
> +/* bit definition of REG_ACTL_RESET register */
> +#define W5691_PLAY             0x20000
> +#define ACTL_RESET_BIT         0x10000
> +#define RECORD_RIGHT_CHNNEL    0x08000
> +#define RECORD_LEFT_CHNNEL     0x04000
> +#define PLAY_RIGHT_CHNNEL      0x02000
> +#define PLAY_LEFT_CHNNEL       0x01000
> +#define DAC_PLAY               0x00800
> +#define ADC_RECORD             0x00400
> +#define M80_PLAY               0x00200
> +#define AC_RECORD              0x00100
> +#define AC_PLAY                        0x00080
> +#define IIS_RECORD             0x00040
> +#define IIS_PLAY               0x00020
> +#define DAC_RESET              0x00010
> +#define ADC_RESET              0x00008
> +#define M80_RESET              0x00004
> +#define AC_RESET               0x00002
> +#define IIS_RESET              0x00001
> +
> +/* bit definition of REG_ACTL_ACCON register */
> +#define AC_BCLK_PU_EN          0x20
> +#define AC_R_FINISH            0x10
> +#define AC_W_FINISH            0x08
> +#define AC_W_RES               0x04
> +#define AC_C_RES               0x02
> +
> +/* bit definition of ACTL_RSR register */
> +#define R_FIFO_EMPTY           0x04
> +#define R_DMA_END_IRQ          0x02
> +#define R_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_PSR register */
> +#define P_FIFO_EMPTY           0x04
> +#define P_DMA_END_IRQ          0x02
> +#define P_DMA_MIDDLE_IRQ       0x01
> +
> +/* bit definition of ACTL_ACOS0 register */
> +#define SLOT1_VALID            0x01
> +#define SLOT2_VALID            0x02
> +#define SLOT3_VALID            0x04
> +#define SLOT4_VALID            0x08
> +#define VALID_FRAME            0x10
> +
> +/* bit definition of ACTL_ACOS1 register */
> +#define R_WB                   0x80
> +
> +#define CODEC_READY            0x10
> +#define RESET_PRSR             0x00
> +#define AUDIO_WRITE(addr, val) __raw_writel(val, addr)
> +#define AUDIO_READ(addr)       __raw_readl(addr)
> +#define PCM_TX                 0
> +#define PCM_RX                 1
> +#define SUBSTREAM_TYPE(substream) \
> +       ((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX :
> PCM_RX)
> +
> +struct nuc900_audio {
> +       void __iomem *mmio;
> +       spinlock_t lock;
> +       dma_addr_t dma_addr[2];
> +       unsigned long buffersize[2];
> +       unsigned long irq_num;
> +       struct snd_pcm_substream *substream;
> +       struct resource *res;
> +       struct clk *clk;
> +       struct device *dev;
> +
> +};
> +
> +extern struct nuc900_audio *nuc900_ac97_data;
> +extern struct snd_soc_dai nuc900_ac97_dai;
> +extern struct snd_soc_platform nuc900_soc_platform;
> +
> +#endif /*end _NUC900_AUDIO_H */
> diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
> new file mode 100644
> index 0000000..32a503c
> --- /dev/null
> +++ b/sound/soc/nuc900/nuc900-pcm.c
> @@ -0,0 +1,352 @@
> +/*
> + * Copyright (c) 2010 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <mach/hardware.h>
> +
> +#include "nuc900-auido.h"
> +
> +static const struct snd_pcm_hardware nuc900_pcm_hardware = {
> +       .info                   = SNDRV_PCM_INFO_INTERLEAVED |
> +                                       SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +                                       SNDRV_PCM_INFO_MMAP |
> +                                       SNDRV_PCM_INFO_MMAP_VALID |
> +                                       SNDRV_PCM_INFO_PAUSE |
> +                                       SNDRV_PCM_INFO_RESUME,
> +       .formats                = SNDRV_PCM_FMTBIT_S16_LE,
> +       .channels_min           = 1,
> +       .channels_max           = 2,
> +       .buffer_bytes_max       = 4*1024,
> +       .period_bytes_min       = 1*1024,
> +       .period_bytes_max       = 4*1024,
> +       .periods_min            = 1,
> +       .periods_max            = 1024,
> +};
> +
> +static int nuc900_dma_hw_params(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, stype = SUBSTREAM_TYPE(substream);
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       ret = snd_pcm_lib_malloc_pages(substream,
> params_buffer_bytes(params));
> +       if (ret < 0)
> +               return ret;
> +
> +       nuc900_audio->substream = substream;
> +       nuc900_audio->dma_addr[stype] = runtime->dma_addr;
> +       nuc900_audio->buffersize[stype] = params_buffer_bytes(params);
> +
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +
> +       return ret;
> +}
> +
> +static void nuc900_update_dma_register(struct snd_pcm_substream
> *substream,
> +                               dma_addr_t dma_addr, size_t count)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       void __iomem *mmio_addr, *mmio_len;
> +
> +       if (SUBSTREAM_TYPE(substream) == PCM_TX) {
> +               mmio_addr = nuc900_audio->mmio + ACTL_PDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_PDST_LENGTH;
> +       } else {
> +               mmio_addr = nuc900_audio->mmio + ACTL_RDSTB;
> +               mmio_len = nuc900_audio->mmio + ACTL_RDST_LENGTH;
> +       }
> +
> +       AUDIO_WRITE(mmio_addr, dma_addr);
> +       AUDIO_WRITE(mmio_len, count);
> +}
> +
> +static void nuc900_dma_start(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val |= (T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static void nuc900_dma_stop(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long val;
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +       val &= ~(T_DMA_IRQ | R_DMA_IRQ);
> +       AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val);
> +}
> +
> +static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)
> +{
> +       struct snd_pcm_substream *substream = dev_id;
> +       struct nuc900_audio *nuc900_audio =
> substream->runtime->private_data;
> +       unsigned long val;
> +
> +       spin_lock(&nuc900_audio->lock);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_CON);
> +
> +       if (val & R_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> R_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_RSR);
> +
> +               if (val & R_DMA_MIDDLE_IRQ) {
> +                       val |= R_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +
> +               if (val & R_DMA_END_IRQ) {
> +                       val |= R_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_RSR, val);
> +               }
> +       } else if (val & T_DMA_IRQ) {
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_CON, val |
> T_DMA_IRQ);
> +
> +               val = AUDIO_READ(nuc900_audio->mmio + ACTL_PSR);
> +
> +               if (val & P_DMA_MIDDLE_IRQ) {
> +                       val |= P_DMA_MIDDLE_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +
> +               if (val & P_DMA_END_IRQ) {
> +                       val |= P_DMA_END_IRQ;
> +                       AUDIO_WRITE(nuc900_audio->mmio + ACTL_PSR, val);
> +               }
> +       } else {
> +               dev_err(nuc900_audio->dev, "Wrong DMA interrupt
> status!\n");
> +               spin_unlock(&nuc900_audio->lock);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_unlock(&nuc900_audio->lock);
> +
> +       snd_pcm_period_elapsed(substream);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int nuc900_dma_hw_free(struct snd_pcm_substream *substream)
> +{
> +       snd_pcm_lib_free_pages(substream);
> +       return 0;
> +}
> +
> +static int nuc900_dma_prepare(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +       unsigned long flags, val, stype = SUBSTREAM_TYPE(substream);;
> +
> +       spin_lock_irqsave(&nuc900_audio->lock, flags);
> +
> +       nuc900_update_dma_register(substream,
> +               nuc900_audio->dma_addr[stype],
> nuc900_audio->buffersize[stype]);
> +
> +       val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
> +
> +       switch (runtime->channels) {
> +       case 1:
> +               if (PCM_TX == stype) {
> +                       val &= ~(PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +                       val |= PLAY_RIGHT_CHNNEL;
> +               } else {
> +                       val &= ~(RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +                       val |= RECORD_RIGHT_CHNNEL;
> +               }
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       case 2:
> +               if (PCM_TX == stype)
> +                       val |= (PLAY_LEFT_CHNNEL | PLAY_RIGHT_CHNNEL);
> +               else
> +                       val |= (RECORD_LEFT_CHNNEL | RECORD_RIGHT_CHNNEL);
> +               AUDIO_WRITE(nuc900_audio->mmio + ACTL_RESET, val);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       spin_unlock_irqrestore(&nuc900_audio->lock, flags);
> +       return 0;
> +}
> +
> +static int nuc900_dma_trigger(struct snd_pcm_substream *substream, int
> cmd)
> +{
> +       int ret = 0;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +               nuc900_dma_start(substream);
> +               break;
> +
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +               nuc900_dma_stop(substream);
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +int nuc900_dma_getposition(struct snd_pcm_substream *substream,
> +                                       dma_addr_t *src, dma_addr_t *dst)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       if (src != NULL)
> +               *src = AUDIO_READ(nuc900_audio->mmio + ACTL_PDSTC);
> +
> +       if (dst != NULL)
> +               *dst = AUDIO_READ(nuc900_audio->mmio + ACTL_RDSTC);
> +
> +       return 0;
> +}
> +
> +static snd_pcm_uframes_t nuc900_dma_pointer(struct snd_pcm_substream
> *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       dma_addr_t src, dst;
> +       unsigned long res;
> +
> +       nuc900_dma_getposition(substream, &src, &dst);
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +               res = dst - runtime->dma_addr;
> +       else
> +               res = src - runtime->dma_addr;
> +
> +       return bytes_to_frames(substream->runtime, res);
> +}
> +
> +static int nuc900_dma_open(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio;
> +
> +       snd_soc_set_runtime_hwparams(substream, &nuc900_pcm_hardware);
> +
> +       nuc900_audio = nuc900_ac97_data;
> +
> +       if (request_irq(nuc900_audio->irq_num, nuc900_dma_interrupt,
> +                       IRQF_DISABLED, "nuc900-dma", substream))
> +               return -EBUSY;
> +
> +       runtime->private_data = nuc900_audio;
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_close(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct nuc900_audio *nuc900_audio = runtime->private_data;
> +
> +       free_irq(nuc900_audio->irq_num, substream);
> +
> +       return 0;
> +}
> +
> +static int nuc900_dma_mmap(struct snd_pcm_substream *substream,
> +       struct vm_area_struct *vma)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +       return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +                                       runtime->dma_area,
> +                                       runtime->dma_addr,
> +                                       runtime->dma_bytes);
> +}
> +
> +static struct snd_pcm_ops nuc900_dma_ops = {
> +       .open           = nuc900_dma_open,
> +       .close          = nuc900_dma_close,
> +       .ioctl          = snd_pcm_lib_ioctl,
> +       .hw_params      = nuc900_dma_hw_params,
> +       .hw_free        = nuc900_dma_hw_free,
> +       .prepare        = nuc900_dma_prepare,
> +       .trigger        = nuc900_dma_trigger,
> +       .pointer        = nuc900_dma_pointer,
> +       .mmap           = nuc900_dma_mmap,
> +};
> +
> +static void nuc900_dma_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +       snd_pcm_lib_preallocate_free_for_all(pcm);
> +}
> +
> +static u64 nuc900_pcm_dmamask = DMA_BIT_MASK(32);
> +static int nuc900_dma_new(struct snd_card *card,
> +       struct snd_soc_dai *dai, struct snd_pcm *pcm)
> +{
> +       if (!card->dev->dma_mask)
> +               card->dev->dma_mask = &nuc900_pcm_dmamask;
> +       if (!card->dev->coherent_dma_mask)
> +               card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +
> +       snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> +               card->dev, 4 * 1024, (4 * 1024) - 1);
> +
> +       return 0;
> +}
> +
> +struct snd_soc_platform nuc900_soc_platform = {
> +       .name           = "nuc900-dma",
> +       .pcm_ops        = &nuc900_dma_ops,
> +       .pcm_new        = nuc900_dma_new,
> +       .pcm_free       = nuc900_dma_free_dma_buffers,
> +}
> +EXPORT_SYMBOL_GPL(nuc900_soc_platform);
> +
> +static int __init nuc900_soc_platform_init(void)
> +{
> +       return snd_soc_register_platform(&nuc900_soc_platform);
> +}
> +
> +static void __exit nuc900_soc_platform_exit(void)
> +{
> +       snd_soc_unregister_platform(&nuc900_soc_platform);
> +}
> +
> +module_init(nuc900_soc_platform_init);
> +module_exit(nuc900_soc_platform_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("nuc900 Audio DMA module");
> +MODULE_LICENSE("GPL");
> --
> 1.6.3.3
>
>


-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org<addr%3Alinux-arm-kernel@lists.infradead.org>
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com <addr%3ANUC900@googlegroups.com>
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100518/02ab9008/attachment-0001.htm>
