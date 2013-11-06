From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 6 Nov 2013 15:25:59 +0100
Subject: [RFC 3/4] ASoC: Allow Aux Codecs to be specified using DT
In-Reply-To: <1382909086-10493-4-git-send-email-sre@debian.org>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-4-git-send-email-sre@debian.org>
Message-ID: <20131106142559.GC15551@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This patch adds support for specifying auxiliary codecs and
> codec configuration via device tree phandles.
> 
> This change adds new fields to snd_soc_aux_dev and snd_soc_codec_conf
> and adds support for the changes to SoC core methods.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  include/sound/soc.h  | 13 +++++++++-
>  sound/soc/soc-core.c | 68 ++++++++++++++++++++++++++++++++++++----------------
>  2 files changed, 59 insertions(+), 22 deletions(-)

> @@ -1527,15 +1529,23 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
>  static int soc_check_aux_dev(struct snd_soc_card *card, int num)
>  {
>  	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
> +	const char *codecname = aux_dev->codec_name;
>  	struct snd_soc_codec *codec;
>  
>  	/* find CODEC from registered CODECs*/
>  	list_for_each_entry(codec, &codec_list, list) {
> -		if (!strcmp(codec->name, aux_dev->codec_name))
> +		if (aux_dev->codec_of_node &&
> +				codec->dev->of_node == aux_dev->codec_of_node)
> +			return 0;
> +		if (aux_dev->codec_name &&
> +				!strcmp(codec->name, aux_dev->codec_name))
>  			return 0;

You can use codecname here.

> -		if (!strcmp(codec->name, aux_dev->codec_name)) {
> -			if (codec->probed) {
> -				dev_err(codec->dev,
> -					"ASoC: codec already probed");
> -				ret = -EBUSY;
> -				goto out;
> -			}
> -			goto found;
> +		if (aux_dev->codec_of_node &&
> +				codec->dev->of_node != aux_dev->codec_of_node)
> +			continue;
> +		if (aux_dev->codec_name &&
> +				strcmp(codec->name, aux_dev->codec_name))
> +			continue;

So in (error) case of ! aux_dev->codec_of_node && ! aux_dev->codec_name 
we match first possible codec?

Given code similarity between this and the one above, should there be
helper function that does the comparison (or even walks the list)?

> @@ -1644,12 +1663,19 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>  		/* check to see if we need to override the compress_type */
>  		for (i = 0; i < card->num_configs; ++i) {
>  			codec_conf = &card->codec_conf[i];
> -			if (!strcmp(codec->name, codec_conf->dev_name)) {
> -				compress_type = codec_conf->compress_type;
> -				if (compress_type && compress_type
> -				    != codec->compress_type)
> -					break;
> -			}
> +
> +			if (codec_conf->of_node &&
> +				codec->dev->of_node != codec_conf->of_node)
> +				continue;
> +
> +			if (codec_conf->dev_name &&
> +				strcmp(codec->name, codec_conf->dev_name))
> +				continue;
> +

..third copy of codec matching.

Thanks for doing all the good work,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
