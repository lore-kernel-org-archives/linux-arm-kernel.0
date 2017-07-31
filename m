From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 31 Jul 2017 10:10:41 +0200
Subject: [PATCH] Staging: vc04_services: Fix WARN_ON instead of BUG_ON
In-Reply-To: <1501485243-11977-1-git-send-email-jananis37@gmail.com>
References: <1501485243-11977-1-git-send-email-jananis37@gmail.com>
Message-ID: <573937bd-6e1e-90f7-3884-c749c2504326@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.07.2017 um 09:14 schrieb janani-sankarababu:
> This patch is to replace the use of BUG_ON macro with WARN_ON
> inorder to prevent the crashing of the kernel.

Unfortunately it isn't always that simple. checkpatch isn't smart. It's
preferred to handle error cases instead of flooding the kernel log.

>
> Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> index f484bb0..30bc246 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> @@ -91,7 +91,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
>  	if (mutex_lock_interruptible(&chip->audio_mutex))
>  		return -EINTR;
>  
> -	BUG_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));
> +	WARN_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));

The complete logic seems strange to me and the statement before didn't
even check for chip.

Regards
Stefan

>  
>  	if (kcontrol->private_value == PCM_PLAYBACK_VOLUME)
>  		ucontrol->value.integer.value[0] = chip2alsa(chip->volume);
