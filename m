From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 31 Jul 2017 11:45:19 +0300
Subject: [PATCH] Staging: vc04_services: Fix WARN_ON instead of BUG_ON
In-Reply-To: <1501485243-11977-1-git-send-email-jananis37@gmail.com>
References: <1501485243-11977-1-git-send-email-jananis37@gmail.com>
Message-ID: <20170731084519.s7zy3cvejtvcqbf2@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 12:44:03PM +0530, janani-sankarababu wrote:
> This patch is to replace the use of BUG_ON macro with WARN_ON
> inorder to prevent the crashing of the kernel.
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
                                      ^^^^^^
We dereference chip here.

>  		return -EINTR;
>  
> -	BUG_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));
> +	WARN_ON(!chip && !(chip->avail_substreams & AVAIL_SUBSTREAMS_MASK));
                ^^^^^
Too late.

regards,
dan carpenter
