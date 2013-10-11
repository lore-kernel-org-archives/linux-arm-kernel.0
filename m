From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 12:46:10 +0200
Subject: [PATCH 2/3] ASoC: mxs-saif: Store saif state
In-Reply-To: <20131011123146.73ff30ce@ipc1.ka-ro>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
 <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
 <20131011123146.73ff30ce@ipc1.ka-ro>
Message-ID: <20131011104610.GI19005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 11, 2013 at 12:31:46PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> > Trigger commands may be passed multiple times. To avoid errors with
> > clk_enable/disable, store the saif state and return if saif is already
> > running/stopped.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  sound/soc/mxs/mxs-saif.c | 8 ++++++++
> >  sound/soc/mxs/mxs-saif.h | 5 +++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> > index b56b8a0..c8ead01 100644
> > --- a/sound/soc/mxs/mxs-saif.c
> > +++ b/sound/soc/mxs/mxs-saif.c
> > @@ -503,6 +503,9 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
> >  	case SNDRV_PCM_TRIGGER_START:
> >  	case SNDRV_PCM_TRIGGER_RESUME:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +		if (saif->state == MXS_SAIF_STATE_RUNNING)
> > +			return 0;
> > +
> >  		dev_dbg(cpu_dai->dev, "start\n");
> >  
> >  		clk_enable(master_saif->clk);
> > @@ -543,6 +546,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
> >  		}
> >  
> >  		master_saif->ongoing = 1;
> > +		saif->state = MXS_SAIF_STATE_RUNNING;
> >
> It seems to me that you could use the already existing variable
> 'ongoing' that already reflects the state like you need it.

'ongoing' can only be used if master_saif == saif. Otherwise this
variable does not reflect the state of the saif. For example there could
be parallel audio playback and recording, setting the variable only on
the master_saif->ongoing but not for the second saif.

Regards,

Markus Pargmann


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
