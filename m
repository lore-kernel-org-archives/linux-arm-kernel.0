From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 22:47:20 +0800
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <CAOMZO5Ds3ZBhunOh1BSjLz7g=-3mRz_CwpgsPVnabGr=XzMx4g@mail.gmail.com>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
 <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
 <201306221524.33879.marex@denx.de>
 <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
 <20130624072908.GH26254@S2101-09.ap.freescale.net>
 <CAOMZO5Bfetjwinatj4W-nrEvg+3pLfjgF8Zpx_-=n52ZTGHeGA@mail.gmail.com>
 <20130624140754.GF30747@S2101-09.ap.freescale.net>
 <CAOMZO5Ds3ZBhunOh1BSjLz7g=-3mRz_CwpgsPVnabGr=XzMx4g@mail.gmail.com>
Message-ID: <20130624144718.GG30747@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 11:18:52AM -0300, Fabio Estevam wrote:
> I registered it as dummy one (same as done in this patch).
> 
We need to register a real one.

> Then regmap_read fails (from sgtl5000 driver), as it tries to read the
> codec revision via I2C and the clock is not available yet. Then I
> changed to return a -EDEFER_PROBE in case of failure:
> 
> [    1.754258] mxs-lradc 80050000.lradc: Touchscreen not enabled.
> [    1.783755] ******* reading I2C failed
> [    1.789748] i2c 0-000a: Driver sgtl5000 requests probe deferral
> [    1.801720] mxs-sgtl5000 sound.12: ASoC: CODEC (null) not registered
> [    1.809608] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-517)
> [    1.816675] platform sound.12: Driver mxs-sgtl5000 requests probe deferral
> [    1.825852] TCP: cubic registered
> [    1.829375] NET: Registered protocol family 17
> [    1.835999] Key type dns_resolver registered
> [    1.844549] mmc0: new SDHC card at address f955
> [    1.852887] registered taskstats version 1
> [    1.860535] mmcblk0: mmc0:f955 SD04G 3.69 GiB
> [    1.878653] sgtl5000 0-000a: sgtl5000 revision 0x11
> [    1.887430]  mmcblk0: p1 p2 p3
> [    1.894824] mxs-sgtl5000 sound.12: ASoC: CODEC (null) not registered
> [    1.901468] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-517)
> 
> Then it succeeds in the following attemp, but snd_soc_register_card() fails.

This is expected, because CODEC (sgtl5000) gets a probe deferral.
snd_soc_register_card() will always return -EDEFER_PROBE, until sgtl5000
gets the clock to finish its probe.

I will try to see if I can cook up a patch for it.

Shawn
