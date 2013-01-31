From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Jan 2013 11:15:13 +0800
Subject: Sound/ARM/i.MX/SSI: fix SDMA starvation
In-Reply-To: <201301301444.25814.jbe@pengutronix.de>
References: <201301240956.30641.jbe@pengutronix.de>
 <201301301444.25814.jbe@pengutronix.de>
Message-ID: <20130131031510.GA17607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the fix, Juergen.

The patch subject could be written in a better form with a proper
prefix added.  "git log sound/soc/fsl/fsl_ssi.c" should give example.
To have the patch get in sooner, you should copy Mark Brown on it.

Also MAINTAINERS file gives the following, so you still do not have
the right list copied.

SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
M:      Liam Girdwood <lrg@ti.com>
M:      Mark Brown <broonie@opensource.wolfsonmicro.com>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
L:      alsa-devel at alsa-project.org (moderated for non-subscribers)
W:      http://alsa-project.org/main/index.php/ASoC
S:      Supported
F:      sound/soc/
F:      include/sound/soc*

On Wed, Jan 30, 2013 at 02:44:25PM +0100, Juergen Beisert wrote:
> Juergen Beisert wrote:
> > In cases when capturing is already running and someone enables also
> > playback, the SDMA unit of the i.MX SoC does not see an edge on its TX DMA
> > request line. This is due to the TX FIFOs are empty, and this request line
> > is active all the time, when the CCSR_SSI_SIER_TDMAE bit is set.
> > In this case also the TX FIFO underrun interrupt will flood the system
> > forever.
> >
> > To ensure the first edge happens after enabling the TX side of the SSI unit
> > and to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
> > demand only. To be sure, this patch does the same for the
> > CCSR_SSI_SIER_RDMAE (RX side) bit.
> >
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

I can see the patch does fix the problem.  A small comment below,
otherwise

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> >
> > ---
> >  sound/soc/fsl/fsl_ssi.c |   24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > Index: linux.git/sound/soc/fsl/fsl_ssi.c
> > ===================================================================
> > --- linux.git.orig/sound/soc/fsl/fsl_ssi.c
> > +++ linux.git/sound/soc/fsl/fsl_ssi.c
> > @@ -86,10 +86,9 @@ static inline void write_ssi_mask(u32 __
> >  #endif
> >
> >  /* SIER bitflag of interrupts to enable */
> > -#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
> > -		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
> > -		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
> > -		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
> > +#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TIE | \
> > +		    CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TUE1_EN | \
> > +		    CCSR_SSI_SIER_RFRC_EN | CCSR_SSI_SIER_RIE | \

It takes me sometime to see the real change here is to remove flags
CCSR_SSI_SIER_TDMAE and CCSR_SSI_SIER_RDMAE.  Then the changes below
should look less dramatic and ease the reviewers a little bit, I think.

Shawn

--8<---

@@ -86,10 +86,9 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 #endif

 /* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
+#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_RIE | \
                    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
                    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-                   CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
                    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)


> >  		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
> >
> >  /**
> > @@ -489,6 +488,9 @@ static int fsl_ssi_hw_params(struct snd_
> >   *
> >   * The DMA channel is in external master start and pause mode, which
> >   * means the SSI completely controls the flow of data.
> > + *
> > + * To use the i.MX's SDMA unit it is important to create an edge on the
> > + * corresponding request line. Otherwise the request will be ignored!
> >   */
> >  static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
> >  			   struct snd_soc_dai *dai)
> > @@ -500,20 +502,26 @@ static int fsl_ssi_trigger(struct snd_pc
> >  	switch (cmd) {
> >  	case SNDRV_PCM_TRIGGER_START:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >  			write_ssi_mask(&ssi->scr, 0,
> >  				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
> > -		else
> > +			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TDMAE);
> > +		} else {
> >  			write_ssi_mask(&ssi->scr, 0,
> >  				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
> > +			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_RDMAE);
> > +		}
> >  		break;
> >
> >  	case SNDRV_PCM_TRIGGER_STOP:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >  			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
> > -		else
> > +			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TDMAE, 0);
> > +		} else {
> >  			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
> > +			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_RDMAE, 0);
> > +		}
> >  		break;
> >
> >  	default:
> 
> Any comments on this patch?
> 
> jbe
> 
> -- 
> Pengutronix e.K.                              | Juergen Beisert             |
> Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
> Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
