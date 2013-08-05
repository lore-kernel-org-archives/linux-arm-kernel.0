From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 12:33:10 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805112733.GY9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
Message-ID: <20130805113310.GU23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 12:27:33PM +0100, Mark Brown wrote:
> On Sun, Aug 04, 2013 at 08:31:04PM +0100, Russell King wrote:
> > Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
> > I2S inputs/outputs.
> 
> > +	{ "i2sdi",		NULL,	"Capture" },
> > +	{ "Playback",		NULL,	"i2sdo" },
> 
> This doesn't look good - this is adding DAPM routes which should
> correspond to the DAI link that's already been configured.

No, you're wrong there:

CPU DAI:				Codec DAI
dma-playback	--->	i2sdo	--->	Playback
		`-->	spdifdo -> not connected
dma-capture	<---	i2sdi	<---	Capture

And the intermediate level is needed to determine which outputs from
the chip are wired up.

This structure, which is what ASoC normally does, for this SoC is wrong:

CPU DAI:		Codec DAI
dma-playback	--->	Playback
dma-capture	<---	Capture

because it contains no information on how the connectivity between the
codec and DAI is performed.

And don't even say "use dpcm" - if you say that, I want _you_ to write
it because dpcm is totally and utterly unusable as it currently stands -
as you can see from all the emails I've sent over the weekend.
