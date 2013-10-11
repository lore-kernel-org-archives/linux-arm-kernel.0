From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 11 Oct 2013 12:31:46 +0200
Subject: [PATCH 2/3] ASoC: mxs-saif: Store saif state
In-Reply-To: <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
 <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20131011123146.73ff30ce@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Trigger commands may be passed multiple times. To avoid errors with
> clk_enable/disable, store the saif state and return if saif is already
> running/stopped.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-saif.c | 8 ++++++++
>  sound/soc/mxs/mxs-saif.h | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index b56b8a0..c8ead01 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -503,6 +503,9 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (saif->state == MXS_SAIF_STATE_RUNNING)
> +			return 0;
> +
>  		dev_dbg(cpu_dai->dev, "start\n");
>  
>  		clk_enable(master_saif->clk);
> @@ -543,6 +546,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
>  		}
>  
>  		master_saif->ongoing = 1;
> +		saif->state = MXS_SAIF_STATE_RUNNING;
>
It seems to me that you could use the already existing variable
'ongoing' that already reflects the state like you need it.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
