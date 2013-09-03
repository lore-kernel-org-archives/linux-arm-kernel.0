From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Sep 2013 14:34:03 +0100
Subject: [PATCH 13/14] ASoC: kirkwood: add SPDIF output support
In-Reply-To: <20130903115938.GA1560@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
 <20130903111720.GF3084@sirena.org.uk>
 <20130903113832.GF6617@n2100.arm.linux.org.uk>
 <20130903115938.GA1560@sirena.org.uk>
Message-ID: <20130903133403.GG6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 12:59:38PM +0100, Mark Brown wrote:
> The mixer in Haswell is in the DSP block which sits between the front
> and back end DAIs, external devices like the CODEC are connected to the
> back ends.  I fear that your confusion between front and back end may
> have mislead you here.

Here's what Liam says about his driver:

"It will show a simple example of how to connect about 5 FE pcms to
2 BE DAIs".  So this tells us how the driver is structured, and here
is the confirmation of that:

Here's the declarations, with non-relevant information removed:

static struct snd_soc_dai_driver hsw_dais[] = {
        {
                .name  = "System Pin", 
                .playback = {
                        .stream_name = "System Playback",
        },
        {
                /* PCM and compressed */
                .name  = "Offload0 Pin",
                .playback = {
                        .stream_name = "Offload0 Playback",
                },
        },
        {
                /* PCM and compressed */
                .name  = "Offload1 Pin",
                .playback = {
                        .stream_name = "Offload1 Playback",
                },
        },
        {
                .name  = "Loopback Pin",  
                .capture = {
                        .stream_name = "Loopback Capture",
                },
        },
        {
                .name  = "Capture Pin",
                .capture = {
                        .stream_name = "Analog Capture",
                },
        },
};

So, this creates five front end DAIs.  This layer also creates some
widgets:

static const struct snd_soc_dapm_widget widgets[] = {
        /* Backend DAIs  */
        SND_SOC_DAPM_AIF_IN("SSP0 CODEC IN", NULL, 0, SND_SOC_NOPM, 0, 0),
        SND_SOC_DAPM_AIF_OUT("SSP0 CODEC OUT", NULL, 0, SND_SOC_NOPM, 0, 0),
        SND_SOC_DAPM_AIF_IN("SSP1 BT IN", NULL, 0, SND_SOC_NOPM, 0, 0),
        SND_SOC_DAPM_AIF_OUT("SSP1 BT OUT", NULL, 0, SND_SOC_NOPM, 0, 0),
                        
        /* Global Playback Mixer */
        SND_SOC_DAPM_MIXER("Playback VMixer", SND_SOC_NOPM, 0, 0, NULL, 0),
};

and links these to the streams above:

static const struct snd_soc_dapm_route graph[] = {
        /* Playback Mixer */
        {"Playback VMixer", NULL, "System Playback"},
        {"Playback VMixer", NULL, "Offload0 Playback"}, 
        {"Playback VMixer", NULL, "Offload1 Playback"},
                        
        {"SSP0 CODEC OUT", NULL, "Playback VMixer"},
        {"Loopback Capture", NULL, "Playback VMixer"},
                  
        {"Analog Capture", NULL, "SSP0 CODEC IN"},
};

So, what the above ends up with is this:

[s]System Playback ---+                    +-> [aif]SSP0 CODEC OUT
                      |                    |
[s]Offload0 Playback -+-> Playback VMixer -+
                      |                    |
[s]Offload1 Playback -+                    +-> [s]Loopback Capture

[aif]SSP0 CODEC IN -> [s]Analog Capture

The [s] and [aif] annotations label these up as stream widgets which
are created automatically by ASoC, and [aif] widgets from the CPU DAI
layer.

The card layer sets up these links (again, minimised to omit unnecessary
information).  First, let's look at the definition of snd_soc_dai_link,
so we know how to identify front end and back end DAIs:

struct snd_soc_dai_link {
        /* Do not create a PCM for this DAI link (Backend link) */
        unsigned int no_pcm:1;

        /* This DAI link can route to other DAI links at runtime (Frontend)*/
        unsigned int dynamic:1;
};

So, anything with .no_pcm = 1 is a backend, and anything with
.dynamic = 1 is a frontend.  This is backed up by the code:

        /* ASoC PCM operations */
        if (rtd->dai_link->dynamic) {
                rtd->ops.open           = dpcm_fe_dai_open;
                rtd->ops.hw_params      = dpcm_fe_dai_hw_params;
                rtd->ops.prepare        = dpcm_fe_dai_prepare;
                rtd->ops.trigger        = dpcm_fe_dai_trigger;
                rtd->ops.hw_free        = dpcm_fe_dai_hw_free;
                rtd->ops.close          = dpcm_fe_dai_close;
                rtd->ops.pointer        = soc_pcm_pointer;
                rtd->ops.ioctl          = soc_pcm_ioctl;
        } else {
                rtd->ops.open           = soc_pcm_open;
                rtd->ops.hw_params      = soc_pcm_hw_params;
                rtd->ops.prepare        = soc_pcm_prepare;
                rtd->ops.trigger        = soc_pcm_trigger;
                rtd->ops.hw_free        = soc_pcm_hw_free;
                rtd->ops.close          = soc_pcm_close;
                rtd->ops.pointer        = soc_pcm_pointer;
                rtd->ops.ioctl          = soc_pcm_ioctl;
        }

.dynamic can't be a backend, because why would we assign it front-end
DAI operations if it were set true.  So, it's quite clear that
.dynamic marks a frontend DAI.

static struct snd_soc_dai_link haswell_dais[] = {
        /* Front End DAI links */
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ note that comment
        {
                .name = "System",  
                .stream_name = "System Playback",  
                .cpu_dai_name = "System Pin",  
                .platform_name = "hsw-pcm-audio",
                .dynamic = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .dpcm_playback = 1,
        },
Clearly, "System Playback" is a front end stream - not only does this has
.dynamic = 1, but also it binds it to the dummy codec.
        {
                .name = "Offload0",
                .stream_name = "Offload0 Playback",
                .cpu_dai_name = "Offload0 Pin",
                .platform_name = "hsw-pcm-audio",
                .dynamic = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .dpcm_playback = 1,
        },
Again, another front end stream.
        {
                .name = "Offload1",
                .stream_name = "Offload1 Playback",
                .cpu_dai_name = "Offload1 Pin",  
                .platform_name = "hsw-pcm-audio",
                .dynamic = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .dpcm_playback = 1,
        },
And again.
        { 
                .name = "Loopback",
                .stream_name = "Loopback",
                .cpu_dai_name = "Loopback Pin",
                .platform_name = "hsw-pcm-audio",
                .dynamic = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .dpcm_capture = 1,
        },
And again.
        { 
                .name = "Capture",
                .stream_name = "Capture",
                .cpu_dai_name = "Capture Pin",
                .platform_name = "hsw-pcm-audio",
                .dynamic = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POS$
                .dpcm_capture = 1,
        },
And again.

So... let's mark what's a front-end DAI stream:

[FE:s]System Playback ---+                    +-> [aif]SSP0 CODEC OUT
                         |                    |
[FE:s]Offload0 Playback -+-> Playback VMixer -+
                         |                    |
[FE:s]Offload1 Playback -+                    +-> [FE:s]Loopback Capture

[aif]SSP0 CODEC IN -> [FE:s]Analog Capture

Now for the backends.  The card layer creates these two DAI links:
        /* Back End DAI links */
        { 
                /* SSP0 - Codec */ 
                .name = "Codec",
                .cpu_dai_name = "snd-soc-dummy-dai",
                .platform_name = "snd-soc-dummy",
                .no_pcm = 1,
                .codec_name = "rt5640.0-001c",
                .codec_dai_name = "rt5640-aif1",
                .dpcm_playback = 1,
                .dpcm_capture = 1,
        },
        {
                /* SSP1 - BT */
                .name = "SSP1-Codec",
                .cpu_dai_name = "snd-soc-dummy-dai",
                .platform_name = "snd-soc-dummy",
                .no_pcm = 1,
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
	}

We shall ignore the second, because that's just a dummy.  The first isn't.

As it nas .no_pcm = 1, and the dummy dai for the CPU Dai, this is clearly
a backend.  So, "rt5640-aif1" is the backend DAI which is the _codec_
DAI.

The RT5640 Codec driver creates this:

struct snd_soc_dai_driver rt5640_dai[] = {  
        {
                .name = "rt5640-aif1",
                .id = RT5640_AIF1,
                .playback = {
                        .stream_name = "AIF1 Playback",
                },
                .capture = {
                        .stream_name = "AIF1 Capture",
                },
...

which creates two streams called "AIF1 Playback" and "AIF1 Capture".
These are the codec streams.  Let's call them "[BE:s]AIF1 Playback" and
"[BE:s]AIF1 Capture" so we can clearly understand that these are backend
DAI streams.

What does the card layer do to connect these two together?

static const struct snd_soc_dapm_route hsw_map[] = {
        {"Headphones", NULL, "HPOR"},
        {"Headphones", NULL, "HPOL"},
        {"IN2P", NULL, "Mic"},
                
        /* CODEC BE connections */
        {"SSP0 CODEC IN", NULL, "AIF1 Capture"},
        {"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
};

Note the last two lines.  So, let's add them to this diagram:

[FE:s]System Playback ---+                    +-> [aif]SSP0 CODEC OUT -> [BE:s]AIF1 Playback
                         |                    |
[FE:s]Offload0 Playback -+-> Playback VMixer -+
                         |                    |
[FE:s]Offload1 Playback -+                    +-> [FE:s]Loopback Capture

[BE:s]AIF1 Capture -> [aif]SSP0 CODEC IN -> [FE:s]Analog Capture

And here we have the complete structure.  The DAPM routes and DAPM widgets
sit between the front end DAI streams, and the back end DAI streams - and
the back end DAI streams belong to the codec.

What am I doing in my driver?

Firstly, here's the front end driver:

static struct snd_soc_dai_driver kirkwood_i2s_dai = {
        .playback = {
                .stream_name = "dma-tx",
        },
        .capture = {
                .stream_name = "dma-rx",
        },
};

So here we have two streams, one called "dma-tx" and the other called
"dma-rx".  These are equivalent to "System Playback" and "Analog
Capture" from Liam's driver.

static const struct snd_soc_dapm_widget widgets[] = {
        /* These widget names come from the names from the functional spec */
        SND_SOC_DAPM_AIF_OUT_E("i2sdo", "dma-tx",
                0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_i2s,
                SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
        SND_SOC_DAPM_AIF_OUT_E("spdifdo", "dma-tx",
                0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_spdif,
                SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
        SND_SOC_DAPM_AIF_IN("i2sdi", "dma-rx",
                0, SND_SOC_NOPM, 0, 0),
};

Onto these two streams, I attach some widgets:

             +-> [aif]i2sdo
[FE:s]dma-tx-+
             +-> [aif]spdifdo

[aif]i2sdi-->[FE:s]dma-rx

The DAI links are setup:

static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
        {
                .name = "S/PDIF1",
                .stream_name = "Audio Playback",
                .platform_name = "mvebu-audio.1",
                .cpu_dai_name = "mvebu-audio.1",
                .codec_name = "snd-soc-dummy",
                .codec_dai_name = "snd-soc-dummy-dai",
                .dynamic = 1,
        }, {
                .name = "Codec",
                .stream_name = "IEC958 Playback",
                .cpu_dai_name = "snd-soc-dummy-dai",
                .platform_name = "snd-soc-dummy",
                .no_pcm = 1,
                .codec_dai_name = "dit-hifi",
                .codec_name = "spdif-dit",
        },
};

The first is the frontend - note the .dynamic = 1 in there and the
dummy codec.  The second is the backend, which is the spdif transmitter.
The SPDIF transmitter gives us this:

static struct snd_soc_dai_driver dit_stub_dai = {
        .name           = "dit-hifi",
        .playback       = {
                .stream_name    = "spdif-Playback",

So, it has a stream called "spdif-Playback" (you know full well why I had
to add the "spdif-" prefix here, so I won't explain that.)  This gives us
a backend _codec_ stream of "spdif-Playback" which I'll mark up as
"[BE]spdif-Playback".  This is no different from Liam's RT5640 Codec
driver, and is equivalent to the "AIF1 Playback" there.

How do I connect these together?

static const struct snd_soc_dapm_route routes[] = {
        { "spdif-Playback", NULL, "spdifdo" },
};

So, we end up with this (I'm ignoring the capture side here):

             +-> [aif]i2sdo -> (not connected at present)
[FE:s]dma-tx-+
             +-> [aif]spdifdo -> [BE:s]spdif-Playback

Now, let's go and compare that back to the structure of Liam's original
driver:

[FE:s]System Playback ---+                    +-> [aif]SSP0 CODEC OUT -> [BE:s]AIF1 Playback
                         |                    |
[FE:s]Offload0 Playback -+-> Playback VMixer -+
                         |                    |
[FE:s]Offload1 Playback -+                    +-> [FE:s]Loopback Capture

[BE:s]AIF1 Capture -> [aif]SSP0 CODEC IN -> [FE:s]Analog Capture

and we can see that both of these are doing the same thing.  Front end
CPU DAI streams are connected through widgets to backend _codec_ streams.

So, what I've been trying to find out from you is: you're saying that my
driver is somehow incorrect, and needs to create more front-end DAIs.
I'm saying that it is conformant with Liam's example.

The hardware as a whole - the entire platform - is structured like this:

                                       I2S enable
                                            v
                                   +-> I2S formatter -----.
                                   |                      +-> HDMI chip
<system memory> -> dma -> tx fifo -+                    +-'
                    ^              +-> SPDIF formatter -+
                    |                       ^           +-> TOSlink out
               dma enable              SPDIF enable

where "dma enable" is provided internally in the hardware as the logical
OR of I2S enable and SPDIF enable.  There is no software control of that.

Comparing that with the structure I'm creating, the "dma-tx" stream
represents the DMA and TX fifo.  The "i2sdo" AIF widget represents the
I2S formatted output.  The "spdifdo" AIF widget represents the SPDIF
formatted output.  The "spdif-Playback" backend stream represents the
TOSlink output, and the HDMI chip is currently not represented as it
appears ASoC doesn't need to know about it with properly formatted SPDIF.

Now, if you still disagree that my approach is compliant with Liam's,
then please describe _and_ more importantly draw diagrams as I have done
above - and as I've done in the past for you - to illustrate what you
believe to be a _correct_ solution to this.
