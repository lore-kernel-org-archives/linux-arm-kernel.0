From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Apr 2010 14:41:07 +0100
Subject: [PATCH 2/3] WM8750: Fix SPITZ machine
In-Reply-To: <1270440818-25790-2-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
	<1270440818-25790-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100405134106.GC6580@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 05, 2010 at 06:13:37AM +0200, Marek Vasut wrote:
> This patch registers the WM8750 codec on a proper place on the SPITZ machine
> after the WM8750 driver was converted to new API. Moreover, the incorrect code

We also need this for the Jive machine.  FWIW I'm checking for affected
machines by doing 'grep -l wm8750 sound/soc/*/*.c'.

> is hereby removed from the aSoC driver.

ASoC.

> diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
> index c4cd2ac..d256f5f 100644
> --- a/sound/soc/pxa/spitz.c
> +++ b/sound/soc/pxa/spitz.c
> @@ -322,17 +322,10 @@ static struct snd_soc_card snd_soc_spitz = {
>  	.num_links = 1,
>  };
>  
> -/* spitz audio private data */
> -static struct wm8750_setup_data spitz_wm8750_setup = {
> -	.i2c_bus = 0,
> -	.i2c_address = 0x1b,
> -};
> -
>  /* spitz audio subsystem */
>  static struct snd_soc_device spitz_snd_devdata = {
>  	.card = &snd_soc_spitz,
>  	.codec_dev = &soc_codec_dev_wm8750,
> -	.codec_data = &spitz_wm8750_setup,
>  };

So, this is going to break spitz if not merged in with the patch to
update wm8750 since prior to the conversion of the driver the setup data
is required while after the conversion the setup data structure no
longer exists and will therefore cause compile failures.

As I've mentioned several times before I urge you to look at how this
transition was done for wm8731 for an example of how this sort of change
can be done without too much disruption.
