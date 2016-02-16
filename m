From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 18:09:11 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <112888486.mQgaWiH0PI@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <20160216163840.GA7544@sirena.org.uk> <112888486.mQgaWiH0PI@wuerfel>
Message-ID: <12468747.ft2nGomr6c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 17:59:04 Arnd Bergmann wrote:
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -403,8 +403,10 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
>  
>         jack->phantom_jack = !!phantom_jack;
>         jack->type = type;
> -       jack->jack->private_data = jack;
> -       jack->jack->private_free = hda_free_jack_priv;
> +       if (IS_ENABLED(CONFIG_SND_JACK)) {
> +               jack->jack->private_data = jack;
> +               jack->jack->private_free = hda_free_jack_priv;
> +       }
>         state = snd_hda_jack_detect(codec, nid);
>         snd_jack_report(jack->jack, state ? jack->type : 0);
>  

Or another idea: if we pass private_{data,free} into snd_jack_new()
as arguments, the snd_jack structure can become private to
sound/core/jack.c, so we can be sure to never hit this bug
again.

	Arnd
