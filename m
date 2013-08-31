From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 20:14:14 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <52220B9A.9000007@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
Message-ID: <20130831191414.GG6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
> On 08/31/2013 02:34 PM, Russell King - ARM Linux wrote:
> [...]
> > The same conditions apply as per my previous posting - the DAI link
> > needs to be setup and the associated DAPM routes to tell the CPU DAI
> > which outputs are in use, like this:
> > 
> > DAI link:
> >                 .name = "S/PDIF1",
> >                 .stream_name = "IEC958 Playback",
> >                 .platform_name = "mvebu-audio.1",
> >                 .cpu_dai_name = "mvebu-audio.1",
> >                 .codec_dai_name = "dit-hifi",
> >                 .codec_name = "spdif-dit",
> > 
> > static const struct snd_soc_dapm_route routes[] = {
> >         { "Playback", NULL, "spdifdo" },
> > };
> 
> This is still not exactly the right way to implement this though. Add a
> second DAI to your CPU driver, like this:

What you're suggesting is the DPCM solution.

That would be fine _if_ it works, which it doesn't.  Not only does it
cause the kernel to spit out various warnings (caused by the creation
of multiple procfs files with the same name) but it also causes a kernel
oops when VLC tries to use it (due to NULL ops in the ALSA PCM.)

As I said in my cover to this patch series: this is the minimum set of
changes which provide a working solution.

I would like to have the DPCM solution, but at present that's far from
possible.
