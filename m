From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 17:34:01 +0100
Subject: [PATCH 13/14] ASoC: kirkwood: add SPDIF output support
In-Reply-To: <20130903133403.GG6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
 <20130903111720.GF3084@sirena.org.uk>
 <20130903113832.GF6617@n2100.arm.linux.org.uk>
 <20130903115938.GA1560@sirena.org.uk>
 <20130903133403.GG6617@n2100.arm.linux.org.uk>
Message-ID: <20130904163401.GV3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 02:34:03PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 03, 2013 at 12:59:38PM +0100, Mark Brown wrote:

> > The mixer in Haswell is in the DSP block which sits between the front
> > and back end DAIs, external devices like the CODEC are connected to the
> > back ends.  I fear that your confusion between front and back end may
> > have mislead you here.

> Here's what Liam says about his driver:

> "It will show a simple example of how to connect about 5 FE pcms to
> 2 BE DAIs".  So this tells us how the driver is structured, and here
> is the confirmation of that:

A couple of high level things here.  

One is that, as you have been told on many occasions, you need to be
aware that the driver Liam has been working on which you are using as a
reference here is out of tree and that it is therefore both possible and
likely that issues will be identified during the review on the way into
mainline.  The need to manually add DAPM routes for DAI links is one
example of this.  This means that you cannot take the out of tree code
as gospel, as it has not yet been reviewed issues may be identified
which are also present in the out of tree code.

The other is that it would have been really helpful if earlier on rather
than simply stating that you believe there are no problems in the code
you had said that this was based on you being unable to see any
differences between what these patches are doing and what the out of
tree driver is doing.

> As it nas .no_pcm = 1, and the dummy dai for the CPU Dai, this is clearly
> a backend.  So, "rt5640-aif1" is the backend DAI which is the _codec_
> DAI.

Note that both SoC and CPU DAIs can be specified since the back end link
is being set up using a dai_link.  In the example you are referring to
the SoC side is stubbed out using a dummy since AIUI all the back end
setup is done by the DSP rather than by the CPU and the issue with
manual route creation for DAI links had not yet been identified.

> The DAI links are setup:
> 
> static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
>         {
>                 .name = "S/PDIF1",
>                 .stream_name = "Audio Playback",
>                 .platform_name = "mvebu-audio.1",
>                 .cpu_dai_name = "mvebu-audio.1",
>                 .codec_name = "snd-soc-dummy",
>                 .codec_dai_name = "snd-soc-dummy-dai",
>                 .dynamic = 1,
>         }, {
>                 .name = "Codec",
>                 .stream_name = "IEC958 Playback",
>                 .cpu_dai_name = "snd-soc-dummy-dai",
>                 .platform_name = "snd-soc-dummy",
>                 .no_pcm = 1,
>                 .codec_dai_name = "dit-hifi",
>                 .codec_name = "spdif-dit",
>         },
> };

> The first is the frontend - note the .dynamic = 1 in there and the
> dummy codec.  The second is the backend, which is the spdif transmitter.

The back end should not be using a dummy DAI for the CPU DAI, it should
be using a back end DAI provided by the SoC driver as previously and
repeatedly requested.  As previously discussed this will avoid the
boards having to specify the connections between the SoC and the
external devices twice.  It will also ensure that the board is shielded
from the implementation details of the SoC driver with a consistent
interface being presented to them.

> So, what I've been trying to find out from you is: you're saying that my
> driver is somehow incorrect, and needs to create more front-end DAIs.

No, I have not been saying that more more front end DAIs are needed.  To
repeat what I said in the e-mail to which you are replying:

| the SoC.  This means that the I2S and S/PDIF interfaces should both have
| back end DAIs representing them and the DMA should be represented by a
| front end.

That's one front end DAI for the DMA, one back end DAI for the I2S and
one back end DAI for the S/PDIF making a total of one front end DAI and
two back end DAIs.  As the code already has a front end DAI this means
that back end DAIs need to be added.

> I'm saying that it is conformant with Liam's example.

> Now, if you still disagree that my approach is compliant with Liam's,
> then please describe _and_ more importantly draw diagrams as I have done
> above - and as I've done in the past for you - to illustrate what you
> believe to be a _correct_ solution to this.

Again, you are using out of tree code as a reference here and so you
need to be aware that issues which are identified in review may also be
present in that out of tree code.  If the review comments and out of
tree code disagree it is very important that you focus on the review
comments and if you are saying something based on out of tree code it is
very important that you highlight that.

You need to create the back ends and connect them in line with the AIF
DAPM widgets, the diagrams are essentially the same as those you drew.
Until the framework does this automatically you will need to manually
add DAPM routes between the SoC and the CODEC, though they should be
clearly marked so that they can readily be removed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/11c34659/attachment.sig>
