From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Oct 2017 16:49:04 +0200
Subject: regression introduced by commit 70d435ba1cd6 ("ASoC:
 imx-pcm-dma: simplify pcm_config")
In-Reply-To: <20171004103657.1c6a433d@karo-electronics.de>
References: <20171004103657.1c6a433d@karo-electronics.de>
Message-ID: <1507646944.2398.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Am Mittwoch, den 04.10.2017, 10:36 +0200 schrieb Lothar Wa?mann:
> Hi,
> 
> the commit 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")
> introduced a regression on the Ka-Ro TX series modules (and possibly
> other hardware as well).
> 
> The problem is, that this commit restricts the supported sound
> formats
> to S24_LE only rather than S16_LE, S24_LE, S20_3LE without the
> patch. Therefore aplay fails with the following error messages, when
> trying to play a sound file with S16_LE format:
> > ALSA lib alsa-lib-
> > 1.1.2/src/pcm/pcm_params.c:2162:(snd1_pcm_hw_refine_slave) Slave
> > PCM not usable
> > aplay: set_params:1204: Broken configuration for this PCM: no
> > configurations available
> 
> This is with the simple-sound-card driver as well as the imx-sgtl5000
> driver.
> 
> Can someone tell me on what hardware and with what software has this
> patch been tested?

My primary test hardware was the zii-rdu2 board, the DTS for this board
can be found in recent mainline kernels.

Userspace is based on pulseaudio, which may mask the regression by
resampling to the supported format. Sorry about that.

>From my understanding of the code, it should be possible to fix the
regression without reverting this patch by setting
SND_DMAENGINE_PCM_DAI_FLAG_PACK in the flags field of the DMA params in
fsl_ssi.

Regards,
Lucas
