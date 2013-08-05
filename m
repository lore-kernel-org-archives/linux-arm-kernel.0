From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 05 Aug 2013 15:06:16 +0200
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <20130805115947.GA9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
Message-ID: <51FFA348.2010503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/13 13:59, Mark Brown wrote:
> On Sun, Aug 04, 2013 at 11:45:30PM +0200, Sebastian Hesselbarth wrote:
>> On 08/04/2013 09:21 PM, Russell King - ARM Linux wrote:
>
>>>                  .name = "S/PDIF1",
>>>                  .stream_name = "IEC958 Playback",
>>>                  .platform_name = "mvebu-audio.1",
>>>                  .cpu_dai_name = "mvebu-audio.1",
>>>                  .codec_dai_name = "dit-hifi",
>>>                  .codec_name = "spdif-dit",
>
>> Not a big deal for DT. I suggest to have a "audio-codecs" property that
>> link CPU DAI to codec(s). One thing, I have noticed is that currently
>> you need to supply both codec_name (or DT node) _and_ codec_dai_name.
>> For that it would be helpful, if ASoC supplies helpers to get the DAI
>> by index and use phandle with args here.
>
> This should follow the same pattern as the other board bindings.

Mark,

looking at e.g. nvidia,tegra-audio-*.txt bindings, I guess you are
proposing to have a new binding for every SoC/codec/board combination?
Also, you should have seen "ASoC: fsl: Add S/PDIF machine driver", which
is - again - proposing a new binding for fsl with spdif "codec".

You really want me to go the same way or is there any "other board
binding" I should follow?

>> i2s1: audio-controller at b0000 {
>> 	compatible = "marvell,dove-i2s";
>> 	reg = <0xb0000 0x2345>;
>> 	audio-codecs = <&spdif 0>;
>> };
>
> No, things are glued together using the machine driver - again, look at
> how all the other systems work.  The wiring on the board can get
> interesting enough to need a binding of its own, for very simple
> bindings that should just be pointing to a generic driver.

And that is what will be true for almost all codecs we hook up on
Marvell SoCs. The audio controller is very simple with only mute
control available. We need to connect either i2s or spdif or both to
any codec and the codecs output. The codecs is determined by phandle
and the output (codec_dai_name) could be determined by the phandle's
arg, e.g. 0 for the first codec_dai provided.

That will be one machine driver for possibly all Marvell boards, not
what e.g. tegra is doing with one machine driver for each board they
can find. I understand that the exact wiring on each board may get
complicated, but I don't see why a (well thought) binding should not
be able to describe it?

Sebastian
