From: liam.r.girdwood@linux.intel.com (Liam Girdwood)
Date: Tue, 13 Aug 2013 15:59:12 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130812082837.GB23006@n2100.arm.linux.org.uk>
References: <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
Message-ID: <1376405952.2617.101.camel@loki>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-08-12 at 09:28 +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 12, 2013 at 08:40:15AM +0100, Liam Girdwood wrote:
> > Russell, I'm just back from holiday now and have done a quick re test on
> > Haswell. I can see the correct DAPM path and DPCM state as expected for
> > Haswell, but let me get through my Inbox today and I'll see where we
> > have some differences tomorrow.
> 
> Liam, welcome back.
> 
> Looking at this last night, I notice this:
> 
>  * Creates a new internal PCM instance with no userspace device or procfs
>  * entries. This is used by ASoC Back End PCMs in order to create a PCM that
>  * will only be used internally by kernel drivers. i.e. it cannot be opened
>  * by userspace. It provides existing ASoC components drivers with a substream
>  * and access to any private data.
>  *
>  * The pcm operators have to be set afterwards to the new instance
>  * via snd_pcm_set_ops().
> 
> Note the final paragraph.  So, soc-pcm.c does this:
> 
>         /* create the PCM */
>         if (rtd->dai_link->no_pcm) {
>                 snprintf(new_name, sizeof(new_name), "(%s)",
>                         rtd->dai_link->stream_name);
> 
>                 ret = snd_pcm_new_internal(rtd->card->snd_card, new_name, num,
>                                 playback, capture, &pcm);
>         } else {
> ...
>         if (rtd->dai_link->no_pcm) {
>                 if (playback)
>                         pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data = rtd;
>                 if (capture)
>                         pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data = rtd;
>                 goto out;
>         }
> ...
>         if (playback)
>                 snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &rtd->ops);
> 
>         if (capture)
>                 snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &rtd->ops);
> ...
> out:
>         dev_info(rtd->card->dev, " %s <-> %s mapping ok\n", codec_dai->name,
>                 cpu_dai->name);
>         return ret;
> 
> Hence, soc-pcm.c never sets the ops for the 'internal' stream, which,
> because it uses the dummy DAI, has both a playback and a capture
> stream.
> 
> The above is the only place where the ops are set on the ALSA stream(s)
> by ASoC, which means there's no way that the internal streams can ever
> have a non-NULL ops pointer, and suggests a possible reason why I get
> this oops.

Ah, Ok. The OMAP4 ABE driver always had ops so never hit this (probably
true for Qualcomm driver too). I think we need a check at some point so
that we don't dereference this if no ops are set.

Iiuc, there should be no harm in setting the ops (since ASoC checks for
NULL) for either playback or capture as a workaround in the short term
until the fix is upstream.   

Liam
