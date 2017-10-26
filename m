From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 26 Oct 2017 17:32:15 +0200
Subject: [INTERNAL][PATCH 4/7] ASoC: stm32: sai: fix stop management in isr
In-Reply-To: <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
 <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
Message-ID: <s5hmv4ekjr4.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Oct 2017 15:03:20 +0200,
Olivier Moysan wrote:
> 
> Add check on substream validity.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  sound/soc/stm/stm32_sai_sub.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 2af397d..815ef10 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -184,7 +184,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
>  static irqreturn_t stm32_sai_isr(int irq, void *devid)
>  {
>  	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
> -	struct snd_pcm_substream *substream = sai->substream;
>  	struct platform_device *pdev = sai->pdev;
>  	unsigned int sr, imr, flags;
>  	snd_pcm_state_t status = SNDRV_PCM_STATE_RUNNING;
> @@ -199,6 +198,11 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
>  	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
>  			   SAI_XCLRFR_MASK);
>  
> +	if (!sai->substream) {
> +		dev_err(&pdev->dev, "Device stopped. Spurious IRQ 0x%x\n", sr);
> +		return IRQ_NONE;
> +	}
> +
>  	if (flags & SAI_XIMR_OVRUDRIE) {
>  		dev_err(&pdev->dev, "IRQ %s\n",
>  			STM_SAI_IS_PLAYBACK(sai) ? "underrun" : "overrun");
> @@ -227,9 +231,9 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
>  	}
>  
>  	if (status != SNDRV_PCM_STATE_RUNNING) {
> -		snd_pcm_stream_lock(substream);
> -		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> -		snd_pcm_stream_unlock(substream);
> +		snd_pcm_stream_lock(sai->substream);
> +		snd_pcm_stop(sai->substream, SNDRV_PCM_STATE_XRUN);
> +		snd_pcm_stream_unlock(sai->substream);

Actually changing to sai->substream opens a race, so this chunk is a
bad move, at least.  We have no protection of sai->substream in this
context, thus it can hit a NULL dereference...


thanks,

Takashi
