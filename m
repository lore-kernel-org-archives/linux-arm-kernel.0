From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 10 Aug 2015 14:23:07 +0200
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <20150810103921.GR7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <s5hk2t35ui4.wl-tiwai@suse.de>
 <20150810103921.GR7557@n2100.arm.linux.org.uk>
Message-ID: <s5hegjb5o44.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Aug 2015 12:39:21 +0200,
Russell King - ARM Linux wrote:
> 
> On Mon, Aug 10, 2015 at 12:05:07PM +0200, Takashi Iwai wrote:
> > On Sat, 08 Aug 2015 18:10:06 +0200,
> > Russell King wrote:
> > > +static irqreturn_t snd_dw_hdmi_irq(int irq, void *data)
> > > +{
> > > +	struct snd_dw_hdmi *dw = data;
> > > +	struct snd_pcm_substream *substream;
> > > +	unsigned stat;
> > > +
> > > +	stat = readb_relaxed(dw->data.base + HDMI_IH_AHBDMAAUD_STAT0);
> > > +	if (!stat)
> > > +		return IRQ_NONE;
> > > +
> > > +	writeb_relaxed(stat, dw->data.base + HDMI_IH_AHBDMAAUD_STAT0);
> > > +
> > > +	substream = dw->substream;
> > > +	if (stat & HDMI_IH_AHBDMAAUD_STAT0_DONE && substream) {
> > > +		snd_pcm_period_elapsed(substream);
> > > +		if (dw->substream)
> > > +			dw_hdmi_start_dma(dw);
> > > +	}
> > 
> > Don't we need locking?
> 
> Possibly.
> 
> > In theory, the trigger can be issued while the irq is being handled.
> 
> Well, we can't have a lock around the whole of the above, because that
> results in deadlock (as snd_pcm_period_elapsed() can end up calling into
> the trigger method.)

Yes, and a usual workaround is to unlock temporarily at calling
snd_pcm_period_elapsed(), then relock or call it at the end of 
handler.

> I'm not happy to throw a spinlock around this
> because of the in-built format conversion (something else I'm really not
> happy about - which has to exist here because alsalib is soo painful
> to add custom sample reformatting to - such modules have to be built
> as part of alsalib itself rather than an add-on module.)

I admit that alsa-lib code is very horrible to follow -- but I guess
the change you'd need for iec958 plugin would be fairly small.  We can
add a config option and let iec958 behaving slightly differently
depending on it.

Meanwhile, having an in-kernel workaround makes it much easier to
deploy, so I think it's OK to have this in driver for now.

> > > +static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
> > > +{
> > > +	struct snd_dw_hdmi *dw = substream->private_data;
> > > +	int ret = 0;
> > > +
> > > +	switch (cmd) {
> > > +	case SNDRV_PCM_TRIGGER_START:
> > > +		dw->buf_offset = 0;
> > > +		dw->substream = substream;
> > > +		dw_hdmi_start_dma(dw);
> > > +		dw_hdmi_audio_enable(dw->data.hdmi);
> > > +		substream->runtime->delay = substream->runtime->period_size;
> > > +		break;
> > > +
> > > +	case SNDRV_PCM_TRIGGER_STOP:
> > > +		dw_hdmi_stop_dma(dw);
> > > +		dw_hdmi_audio_disable(dw->data.hdmi);
> > > +		break;
> > > +
> > > +	default:
> > > +		ret = -EINVAL;
> > > +		break;
> > 
> > SNDRV_PCM_TRIGGER_SUSPEND may be passed at suspend, too.
> 
> I think rather than adding code which would be difficult for me to test,
> I'd instead remove the suspend/resume callbacks, or at least disable them
> until someone can test that feature, or is willing to implement it.

That's fine.

> > > +static snd_pcm_uframes_t dw_hdmi_pointer(struct snd_pcm_substream *substream)
> > > +{
> > > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > > +	struct snd_dw_hdmi *dw = substream->private_data;
> > > +
> > > +	return bytes_to_frames(runtime, dw->buf_offset);
> > 
> > So, this returns the offset that has been reformatted.  Does the
> > hardware support any better position reporting?  We may give the delay
> > from the driver if possible.
> 
> Basically, no.  Reading a 32-bit DMA position as separate bytes while
> DMA is active is racy.
> 
> This is the best we can do, and the way we report the position has been
> arrived at after what's getting on for two years of testing with
> pulseaudio, vlc direct access & spdif pass-through, aplay, etc:
> 
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Thu Nov 7 16:01:45 2013 +0000
> 
>     drm: bridge/dw_hdmi-ahb-audio: add audio driver

OK, then this is a driver with the low update granularity.  Hopefully
we'll get some good API to indicate that in near future, as we've been
discussing about it for a while.


thanks,

Takashi
