From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 11 Dec 2017 18:21:58 +0900
Subject: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
In-Reply-To: <20171206125817.GF1827@finisterre>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
 <20171205121440.GC11658@finisterre>
 <004801d36e57$ea1940d0$be4bc270$@socionext.com>
 <20171206125817.GF1827@finisterre>
Message-ID: <001501d37261$7ea89d10$7bf9d730$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> One example is how all the drivers that use the generic dmaengine code
> instantiate their DMA drivers, or how all the drivers for CODECs that
> have both I2C and SPIi control interfaces instantiate - given that the
> device specific code here seems to be mostly data tables that's probably
> the closest thing.

Thank you. I'm checking the ALSA drivers of other companies, I found Qualcomm's
QTi LPASS driver is similar with my wanted.


> > Thanks, I'll try it. Is there Documentation in
sound/designes/compress-offload.rst?
> > And best sample is... Intel's driver?
> 
> Yes.

I read Intel's driver, I understand how to define the compress CPU DAI and
snd_compr_ops. The driver of Intel Atom (at sst-mfld-platform-pcm.c) defines
following DAI:
{
	.name = "compress-cpu-dai",
	.compress_new = snd_soc_new_compress,
	.ops = &sst_compr_dai_ops,
	.playback = {
		.stream_name = "Compress Playback",
		.channels_min = 1,
	},
},

But I can't find how to use/map this DAI in machine driver or Device-Tree or
something. I think that it's same as PCM DAI, am I correct?

I read compress-offload.rst, but I can't find how do I test it. It seems aplay
of
alsa-util doesn't know compress audio formats. Should I use PulseAudio or
Android HAL to test compress audio APIs?


Regards,
--
Katsuhiro Suzuki


> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Wednesday, December 6, 2017 9:58 PM
> To: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel at alsa-project.org; Rob Herring <robh+dt@kernel.org>;
> devicetree at vger.kernel.org; Yamada, Masahiro/?? ??
> <yamada.masahiro@socionext.com>; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
> 
> On Wed, Dec 06, 2017 at 03:03:18PM +0900, Katsuhiro Suzuki wrote:
> 
> > > I'd expect this code to be structured more like a library - have a
> > > driver that handles the specific IPs then have it call into a shared
> > > block of code that does the generic bits.  Though in this case the
> > > device specific bit looks like a couple of tiny data tables so I'm not
> > > sure it's worth making it conditional or separate at all.
> 
> > Sorry... I agree your opinion, but I can't imagine the detail.
> 
> > I think my driver has structure as follows (ex. startup):
> >   DAI: uniphier_aio_startup()@aio-core.c
> >   Lib: uniphier_aio_init()@aio-regctrl.c
> >   SoC specific: uniphier_aio_ld11_spec at aio-ld11.c
> 
> > Am I wrong? Would you mean split the functions in aio-regctl.[ch] to other
> > kernel module? I wonder if you could tell me the example from existing
> > drivers. I'll try to fix my driver like as it.
> 
> One example is how all the drivers that use the generic dmaengine code
> instantiate their DMA drivers, or how all the drivers for CODECs that
> have both I2C and SPIi control interfaces instantiate - given that the
> device specific code here seems to be mostly data tables that's probably
> the closest thing.
> 
> > > At least.  I do think we need to get to the bottom of how flexible the
> > > hardware is first though.
> 
> > Yes, indeed. This hardware is more flexible and complex, but now I (and our
> > company) don't use it. Of course, I don't want to hide some features of this
> > hardware from ALSA people. I should try to upstream all features in the
future,
> > I think.
> 
> My main concern here is to make sure that when you decide you need to
> use the more complex hardware that this can be done without too much
> pain to existing machines (and that they can benefit from as much of the
> enhanced functionality as is possible).
