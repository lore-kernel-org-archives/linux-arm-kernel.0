From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 27 Jan 2014 08:06:23 +0100
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: atmel_ssc_dai: make option
 to choose clock
In-Reply-To: <1390805726-1841-2-git-send-email-voice.shen@atmel.com>
References: <1390805726-1841-1-git-send-email-voice.shen@atmel.com>
 <1390805726-1841-2-git-send-email-voice.shen@atmel.com>
Message-ID: <52E6056F.2050008@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 07:55 AM, Bo Shen wrote:
> When SSC works in slave mode, according to the hardware design, the
> clock can get from TK pin, also can get from RK pin. So, add one
> parameter to choose where the clock from.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> Changes in v2: None
> 
>  sound/soc/atmel/atmel_ssc_dai.c | 16 ++++++++++++----
>  sound/soc/atmel/atmel_ssc_dai.h |  1 +
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 8697ced..03eb0be 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -340,6 +340,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
>  	int id = dai->id;
> +	struct snd_soc_card *card = dai->card;
>  	struct atmel_ssc_info *ssc_p = &ssc_info[id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir, channels, bits;
> @@ -347,6 +348,9 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  	int start_event;
>  	int ret;
>  
> +	ssc_p->clk_from_rk_pin =
> +		((struct atmel_ssc_info *)(card->drvdata))->clk_from_rk_pin;

This is a layering violation. The DAI driver is not supposed to make any
assumptions what drvdata is attached to the card. Use the set_sysclk API to
set the source clock.

- Lars
