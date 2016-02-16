From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 16 Feb 2016 18:10:02 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <112888486.mQgaWiH0PI@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5h4md87hnu.wl-tiwai@suse.de>
 <20160216163840.GA7544@sirena.org.uk>
 <112888486.mQgaWiH0PI@wuerfel>
Message-ID: <s5hr3gc60ph.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2016 17:59:04 +0100,
Arnd Bergmann wrote:
> 
> On Tuesday 16 February 2016 16:38:40 Mark Brown wrote:
> > On Tue, Feb 16, 2016 at 05:18:29PM +0100, Takashi Iwai wrote:
> > > Arnd Bergmann wrote:
> > 
> > > > Another option might would be to change snd_jack_new() to return
> > > > an error if that SND_JACK is disabled, and then require all users
> > > > to handle the error gracefully, i.e. not fail the probe() function
> > > > but just not use the jack.
> > 
> > > Yes, I thought of that, too.  If select is no good option, it's a good
> > > alternative, indeed.
> > 
> > It's going to be a bunch of work to implement though.
> > 
> 
> I've already sent a v2 to change the snd_jack_new() function, feel free
> to ignore that. I also saw now that the same bug is present in hda_jack.c,
> but I think the other drivers are fine.
> 
> How about this approach below? That should also make it possible to
> use the jack APIs without using a error return.

I prefer setting NULL explicitly in snd_jack_new(), and let callers
checking NULL.  Then we can avoid ugly IS_ENABLE() while the compiler
should be still capable to optimize out.

OTOH, I think it'd be a waste of time to bikeshedding too much, so I
don't care so much which to take :)


Takashi

---
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 23bede121c78..a27c253a3207 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -99,6 +99,7 @@ void snd_jack_report(struct snd_jack *jack, int status);
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
 			       struct snd_jack **jack, bool initial_kctl, bool phantom_jack)
 {
+	*jack = NULL;
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index a33234e04d4f..babd3a8864a1 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -403,10 +403,12 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 
 	jack->phantom_jack = !!phantom_jack;
 	jack->type = type;
-	jack->jack->private_data = jack;
-	jack->jack->private_free = hda_free_jack_priv;
-	state = snd_hda_jack_detect(codec, nid);
-	snd_jack_report(jack->jack, state ? jack->type : 0);
+	if (jack->jack) {
+		jack->jack->private_data = jack;
+		jack->jack->private_free = hda_free_jack_priv;
+		state = snd_hda_jack_detect(codec, nid);
+		snd_jack_report(jack->jack, state ? jack->type : 0);
+	}
 
 	return 0;
 }
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8ee78dbd4c60..34a7b3aaba11 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2158,8 +2158,10 @@ static int add_acomp_jack_kctl(struct hda_codec *codec,
 	if (err < 0)
 		return err;
 	per_pin->acomp_jack = jack;
-	jack->private_data = per_pin;
-	jack->private_free = free_acomp_jack_priv;
+	if (jack) {
+		jack->private_data = per_pin;
+		jack->private_free = free_acomp_jack_priv;
+	}
 	return 0;
 }
 
