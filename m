From: broonie@kernel.org (Mark Brown)
Date: Sun, 1 Sep 2013 13:19:28 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130831210518.GK6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk>
 <5222562B.8010001@metafoo.de>
 <20130831210518.GK6617@n2100.arm.linux.org.uk>
Message-ID: <20130901121928.GC3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 10:05:18PM +0100, Russell King - ARM Linux wrote:

> I'm not the only one: I've heard other people complain about the _exact_
> same issue with ASoC: ASoC is difficult to work with, and many people
> just seem to give up with it - or keep their stuff in their own trees
> locally.  I can very well see why that happens.

We do appear to have a fairly good success rate with systems working
with mainline; I can only think of one driver that didn't make it in and
that was one where we had a bit of an issue getting the code to visually
resemble Linux code so I don't feel too bad about it.  I am aware of
some people who didn't work upstream, we've generally had some useful
discussions with them once we've found each other.

> As for "This is the either/or approach I've been suggesting."  No, that's
> another false statement from Mark.  What Mark has been suggesting all
> along is to use DPCM - and that's something which I tried for ages to
> get working, and it just doesn't work (as evidenced by the oopses and
> warnings that get spat out of the kernel.)

While it is correct that I have been saying the final result should use
DPCM (since this is what the hardware looks like) you will recall that I
did recently suggest either/or as a stepping stone towards a full
implementation, allowing systems with only S/PDIF to be supported while
the other issues are still being worked on.

> There are two choices in how the hardware is used: either one output
> only is used, or if both outputs are used, they must be used "as one" -
> both outputs must be simultaneously enabled and disabled.  As far as
> I know, that's not possible with two DAIs.

That is correct, this is why I call it an either/or approach - a system
would be able to use either I2S or S/PDIF but not both.  For systems
with both I2S and S/PDIF connected one or the other would have to be
chosen by the machine driver.

> And here's the patch I tried.

Ah, I'm not sure that I have seen this before (it's certainly not been
submitted).  Just looking at the diff this all seems fine for an
either/or approach though...

> index 2c459c1..62e5b62 100644
> --- a/sound/soc/kirkwood/kirkwood-spdif.c
> +++ b/sound/soc/kirkwood/kirkwood-spdif.c
> @@ -61,7 +61,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
>  		.name = "S/PDIF0",
>  		.stream_name = "S/PDIF0 PCM Playback",
>  		.platform_name = "kirkwood-pcm-audio.0",
> -		.cpu_dai_name = "kirkwood-i2s.0",
> +		.cpu_dai_name = "kirkwood-spdif.0",
>  		.codec_dai_name = "dit-hifi",
>  		.codec_name = "spdif-dit",
>  		.ops = &kirkwood_spdif_ops,
> @@ -73,7 +73,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
>  		.name = "S/PDIF1",
>  		.stream_name = "IEC958 Playback",
>  		.platform_name = "kirkwood-pcm-audio.1",
> -		.cpu_dai_name = "kirkwood-i2s.1",
> +		.cpu_dai_name = "kirkwood-spdif.1",
>  		.codec_dai_name = "dit-hifi",
>  		.codec_name = "spdif-dit",
>  		.ops = &kirkwood_spdif_ops,

...this file does not appear to be in mainline and some of the rest of
the context suggested this was based off something old.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130901/2ecf5768/attachment.sig>
