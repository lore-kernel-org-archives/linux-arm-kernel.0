From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 19 Jun 2017 11:25:13 +0200
Subject: [PATCH v2 12/12] ASoC: Fix use-after-free at card unregistration
In-Reply-To: <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
Message-ID: <s5hefug72iu.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jun 2017 09:27:09 +0200,
Robert Jarzmik wrote:
> 
> From: Takashi Iwai <tiwai@suse.de>
> 
> soc_cleanup_card_resources() call snd_card_free() at the last of its
> procedure.  This turned out to lead to a use-after-free.
> PCM runtimes have been already removed via soc_remove_pcm_runtimes(),
> while it's dereferenced later in soc_pcm_free() called via
> snd_card_free().
> 
> The fix is simple: just move the snd_card_free() call to the beginning
> of the whole procedure.  This also gives another benefit: it
> guarantees that all operations have been shut down before actually
> releasing the resources, which was racy until now.
> 
> Reported-and-tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

This patch must be superfluous :)


Takashi


> ---
>  sound/soc/soc-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2722bb0c5573..98d60f471c5d 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2286,6 +2286,9 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
>  	list_for_each_entry(rtd, &card->rtd_list, list)
>  		flush_delayed_work(&rtd->delayed_work);
>  
> +	/* free the ALSA card at first; this syncs with pending operations */
> +	snd_card_free(card->snd_card);
> +
>  	/* remove and free each DAI */
>  	soc_remove_dai_links(card);
>  	soc_remove_pcm_runtimes(card);
> @@ -2300,9 +2303,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
>  	if (card->remove)
>  		card->remove(card);
>  
> -	snd_card_free(card->snd_card);
>  	return 0;
> -
>  }
>  
>  /* removes a socdev */
> -- 
> 2.1.4
> 
> 
