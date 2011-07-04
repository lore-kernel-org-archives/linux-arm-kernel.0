From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 4 Jul 2011 10:00:34 +0200
Subject: ASoC: imx dma tx burst size set to 6 and to 4 ?
In-Reply-To: <20110704072851.GC9349@pengutronix.de>
References: <4E0C16D9.4040909@televic.com>
	<20110704072851.GC9349@pengutronix.de>
Message-ID: <CACKLOr1Cv4TVRthYmKh8a=OA6VbHRUhucxxNF9AyBwAhBOfFOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/4 Sascha Hauer <s.hauer@pengutronix.de>:
> (Added Javier to Cc)
>
> On Thu, Jun 30, 2011 at 08:25:29AM +0200, Lambrecht J?rgen wrote:
>> Hello,
>>
>> There is an inconsistency in this code:
>>
>> /sound/soc/imx/imx-ssi.c: ? ? ? ? ssi->dma_params_tx.burstsize = 4;
>> /sound/soc/imx/imx-pcm-dma-mx2.c: ssi->dma_params_tx.burstsize = 6;
>>
>> Datasheet:
>> This sets the field TFWM0 in register SFCSR (SSI_SFCSR_TFWM0): the
>> number of data words needed to set the empty flag (TFE0). Can be set
>> from 1 to 8; FIFO size is 8 words (of 24b). And this is also the DMA
>> burst size.
>>
>> Which is best depends on the application (the higher the more efficient,
>> but the more risk for a FIFO underrun). I would take 4.
>>
>> But I guess it should only be set at 1 place, and what is then the best
>> place?
>
> We need different burstsize settings for the FIQ driver and for the DMA
> driver. For this reason the original intention was to set these values
> in sound/soc/imx/imx-pcm-dma-mx2.c and in sound/soc/imx/imx-pcm-fiq.c.
>
>
>> commit 0a93421b6adf8ba127b3eafc4c16e3a14017e2ae
>> Author: Javier Martin <javier.martin@vista-silicon.com>
>> Date: ? Tue Mar 1 15:02:06 2011 +0100
>>
>> ? ? ASoC: Fix burstsize and DSP_B format problems in imx-ssi.
>>
>> ? ? When choosing IMX_DMA flag, burtsizes are set to its default
>> ? ? value (0) which leads to driver malfunction. Change them to 4.
>>
>> ? ? DSP_B interface needs additional flag to match DSP_B formats
>> ? ? as described in several codecs as wm8741 and aic3205.
>>
>> ? ? Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ? ? Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
>> ? ? Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
>> index 30894ea..bc92ec6 100644
>> --- a/sound/soc/imx/imx-ssi.c
>> +++ b/sound/soc/imx/imx-ssi.c
>> @@ -108,7 +108,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
>> ? ? ? ? ? ? ? break;
>> ? ? ? case SND_SOC_DAIFMT_DSP_B:
>> ? ? ? ? ? ? ? /* data on rising edge of bclk, frame high with data */
>> - ? ? ? ? ? ? strcr |= SSI_STCR_TFSL;
>> + ? ? ? ? ? ? strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0;
>> ? ? ? ? ? ? ? break;
>> ? ? ? case SND_SOC_DAIFMT_DSP_A:
>> ? ? ? ? ? ? ? /* data on rising edge of bclk, frame high 1clk before data */
>> @@ -656,6 +656,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
>> ? ? ? ssi->dma_params_rx.dma_addr = res->start + SSI_SRX0;
>> ? ? ? ssi->dma_params_tx.dma_addr = res->start + SSI_STX0;
>>
>> + ? ? ssi->dma_params_tx.burstsize = 4;
>> + ? ? ssi->dma_params_rx.burstsize = 4;
>> +
>
> Javier, is this hunk necessary? From what I see these values should be
> overwritten later anyway.
>
> Sascha

Hi,
without this hunk, both burstsizes where set to 0. This was checked
experimentally:

- Audio didn't work properly.
- Some runtime printk's showed that burstsizes where set to 0.

It seems assignments in imx-pcm-dma-mx2.c file are done at a place
they do not take effect.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
