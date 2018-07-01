From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 1 Jul 2018 23:11:06 +0800
Subject: [linux-sunxi] Re: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if
 they don't have channel 0
In-Reply-To: <8952939.l1hLr1Mv9y@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <2676604.ZYCNkuCdbT@jernej-laptop>
 <CAGb2v67kBRWkJpJogFR4GXgA66dsxVaMVWN8MDiP_wFTqxW-=g@mail.gmail.com>
 <8952939.l1hLr1Mv9y@jernej-laptop>
Message-ID: <CAGb2v66_6RoYk6MRtTJeqg0Z09A7y+pvSxs7qeeND+iKPE_+BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 1, 2018 at 4:27 PM, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> Dne ?etrtek, 28. junij 2018 ob 08:24:34 CEST je Chen-Yu Tsai napisal(a):
>> On Thu, Jun 28, 2018 at 12:45 PM, Jernej ?krabec
>>
>> <jernej.skrabec@siol.net> wrote:
>> > Dne ?etrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai napisal(a):
>> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
>> >
>> > wrote:
>> >> > TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
>> >> > Because of that, all output endpoints on such TCON node will point to a
>> >> > encoder which is part of component framework.
>> >> >
>> >> > Correct current graph traversing algorithm in such way that it doesn't
>> >> > skip output enpoints with id 0 on TV TCONs.
>> >>
>> >> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that don't
>> >> have channel 0, it must be skipped.
>> >
>> > I'm not sure where this is stated. I read TCON binding again. Can you
>> > please point me to it?
>>
>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bind
>> ings/display/sunxi/sun4i-drm.txt#L169
>>
>> Our TCON driver still expects RGB or LVDS panel / bridges on endpoint 0.
>
> Yes, but that can only happen on TCON which has channel 0. TV TCONs (those
> with channel 1 only) can't have panels or bridges connected to them, because
> they are internally always connected to either HDMI or TV encoder or both.
> Actually, R40 is the only SoC, where same TV TCON can be connected to TV
> encoder or HDMI. Others have specialized TV TCONs, which are connect to only
> one encoder.
>
> IMO TV TCONs are really just stripped down LCD TCONs to support one (or max
> two) specific encoder.

I agree. We've seen these first in the H3, and the reverse, TCONs only with
LCD, on the A23/A33.

>> So I guess this was sort of implied historically. It's no longer true.
>> This is something we should probably fix.
>
> Fixed in what way? You mean update bindings to mention that TCON output
> endpoint 0 is reserved for panels or bridges?

Either that, or have the drm driver look at other endpoints. I guess we
should ask Maxime if this is already done or not, since the DSI driver
isn't endpoint 0 in the A33 dtsi.

>>
>> In practice our drivers don't look at it (yet), but rely on the downstream
>> encoder type to determine which channel to use.
>>
>> But please add the "allwinner,tcon-channel" property as specified in
>> the binding.
>
> It's my understanding of TCON binding documentation that property
> "allwinner,tcon-channel" is needed only if TCON supports both channels. TV
> TCON clearly supports only channel 1. In that case, there is no doubt to which
> channel output endpoint belongs.
>
> If that's not true, dt bindings documentation should be reworded to contain
> word "needed" or something similar. Currently, no DT for newer SoC contains
> that property (for example, A83T, H3, H5 or even A33). On A33 this is even
> more interesting, since tcon0 has only channel 0 and has DSI output endpoint
> with number 1. According to TCON binding docs, if "allwinner,tcon-channel" is
> not preset, endpoint number represent channel. So, that would mean DSI needs
> channel 1 on tcon which supports clearly only channel 0. So either there TCON
> bindings documentation needs updates or DT for A33 has to be updated.

Maxime? You did the A33 DSI stuff.

> BTW, "allwinner,tcon-channel" property is not used at all in the code.

Yes I'm aware. We just base the channel selection on the encoder type instead.
TV-like ones use channel 1, LCD ones use channel 0.

>>
>> > So on TV TCONs on R40 (without channel 0) TVE would be endpoint 1 and HDMI
>> > endpoint 2 (or the other way around)?
>>
>> Which one goes first doesn't quite matter. IIRC there's also a mux for TVE?
>
> AFAIK, TV TCON is by default connected to TV encoder unless HDMI mux in TCON
> TOP points to it. I think it's best put TVE with lower number since it's
> default and HDMI with higher number.

Ok. As long as its specified in the binding, as a contract between the dts
and the graph parsing code.

Regards
ChenYu
