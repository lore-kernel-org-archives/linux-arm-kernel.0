From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 05 Apr 2015 18:46:13 +0200
Subject: [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <20150405162034.GH13898@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk>
 <s5ha8ymy3e2.wl-tiwai@suse.de>
 <20150405162034.GH13898@n2100.arm.linux.org.uk>
Message-ID: <s5h4mouy14a.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Sun, 5 Apr 2015 17:20:34 +0100,
Russell King - ARM Linux wrote:
> 
> On Sun, Apr 05, 2015 at 05:57:09PM +0200, Takashi Iwai wrote:
> > > diff --git a/include/sound/pcm_drm_eld.h b/include/sound/pcm_drm_eld.h
> > > new file mode 100644
> > > index 000000000000..93357b25d2e2
> > > --- /dev/null
> > > +++ b/include/sound/pcm_drm_eld.h
> > > @@ -0,0 +1,6 @@
> > > +#ifndef __SOUND_PCM_DRM_ELD_H
> > > +#define __SOUND_PCM_DRM_ELD_H
> > > +
> > > +int snd_pcm_hw_constraint_eld(struct snd_pcm_runtime *runtime, void *eld);
> > > +
> > > +#endif
> > 
> > IMO, a single line of function declaration can be merged to
> > sound/pcm.h.
> 
> Ok.
> 
> > > diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> > > index 313f22e9d929..b534c8a6046b 100644
> > > --- a/sound/core/Kconfig
> > > +++ b/sound/core/Kconfig
> > > @@ -6,6 +6,9 @@ config SND_PCM
> > >  	tristate
> > >  	select SND_TIMER
> > >  
> > > +config SND_PCM_ELD
> > > +	bool
> > 
> > I don't mind much adding this one, but a new Kconfig is always a
> > question.  I'd like to hear other's opinion, too.
> 
> That's more a question whether you want it always included in the build
> or not, especially as it is dependent on DRM header files.

OK, then it makes sense to split.


> > > +printk("%s: r %d-%d c %d-%d m %x\n", __func__, r->min, r->max, c->min, c->max, rate_mask);
> > 
> > I guess this will be removed in the final version? ;)
> 
> Of course.
> 
> > > +static int eld_limit_channels(struct snd_pcm_hw_params *params,
> > > +			      struct snd_pcm_hw_rule *rule)
> > > +{
> > > +	struct snd_interval *var = hw_param_interval(params, rule->var);
> > > +	struct snd_interval t = { .min = 1, .max = 2, .integer = 1, };
> > > +	unsigned int i;
> > > +	const u8 *sad, *eld = rule->private;
> > > +
> > > +	sad = drm_eld_sad(eld);
> > > +	if (sad) {
> > > +		for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3) {
> > > +			switch (sad[0] & 0x78) {
> > > +			case 0x08:
> > > +				t.max = max(t.max, (sad[0] & 7) + 1u);
> > > +				break;
> > 
> > What about the minimal channel?
> 
> There isn't a minimum.  The SAD describes only the _maximum_ number of
> channels.  For example, if a TV supports 5.1 audio, at 32, 44.1 and 48
> kHz, it can do that with just one SAD entry which indicates support for
> six channels of audio at those sample rates.  However, it will happily
> accept 2 channel audio at those sample rates too.

Alright, I remembered wrong.  I took a look at the existing HD-audio
ELD parser code, and it also handles only the max channels.

> > Ideally, we should either give a list of channel numbers or process
> > the hw_constraints dynamically to narrow the min/max matching with the
> > eld.
> 
> The ELD can change as a result of the HDMI sink deciding to change its
> EDID (it does happen) or if the device is unplugged and re-plugged.  If
> I wanted to restrict the maximum channel/rates by building some sort of
> table, I'd do this at open time and avoid the complexity of having rule
> callbacks.

Right, this is the easiest approach.

> Since (afaik) ALSA has a lack of support for dynamic reconfiguration
> according to the attached device changing, the best we can do without
> a huge amount of re-work of HDMI support across all adapters is to
> process the capabilities of the attached device at prepare time
> according to the current capabilities.

Yeah, reconfiguration is tricky.  BTW, how is the HDMI unplug handled
during playback?

> Implementing dynamic reconfiguration in ALSA is not something I want to
> get involved with, and as we /already/ have HDMI support merged in the
> kernel, this is not a blocker for at least trying to get some semblence
> of sanity, rather than having every driver re-implementing stuff like
> this.

Well, I didn't mean about the dynamic reconfiguration.  I thought of
rather min/max pairs, but it was just a wrong assumption.  Scratch
it.

One another question: don't we need to deal with the sample bits in
sad[2]?


Takashi
