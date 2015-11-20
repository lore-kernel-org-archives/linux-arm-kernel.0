From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Nov 2015 10:56:16 +0800
Subject: [linux-sunxi] Re: [PATCH v3 3/3] ARM: dts: sun4i: gemei-g9:
 Enable sun4i audio codec support
In-Reply-To: <20151119160923.GS32142@lukather>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
 <1446832486-32319-4-git-send-email-plaes@plaes.org>
 <CAGb2v66uG-0EgVR=5SS4Lk-y5mX9v3Z39xP+0f7u7BfYq-b1yw@mail.gmail.com>
 <1447354399.31635.10.camel@plaes.org> <20151119160923.GS32142@lukather>
Message-ID: <CAGb2v66Fp3oVWACNSkH9Z=D=RAwd4A3nHE2s5oQZBVhqtS9ZGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 12:09 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Nov 12, 2015 at 08:53:19PM +0200, Priit Laes wrote:
>> On Mon, 2015-11-09 at 11:59 +0800, Chen-Yu Tsai wrote:
>> > On Sat, Nov 7, 2015 at 1:54 AM, Priit Laes <plaes@plaes.org> wrote:
>> > > Gemei G9 has internal speakers and headphone jack. Audio switching
>> > > from internal speakers to headphones is automatically handled by
>> > > extra FT2012Q audio amplifier chip that works out of the box.
>> >
>> > Nice that it works out of the box. The FEX file does mention:
>> >
>> > audio_pa_ctrl   = port:PH15<1><default><default><0>
>>
>> Nice catch.
>>
>> Setting it low mutes audio, and setting it back high unmutes.
>
> Then you just volunteered yourself to fix the FIXME in the driver ;)
>

Hans seems to have a patch for this in his sunxi-wip branch.
I haven't looked at it though.

ChenYu

>> > So either it is floating or pulled up by default? Since it works
>> > now I don't see any reason to block it. On the other hand once
>> > that binding is introduced it would be nice to add it for power
>> > management reasons.
>>
>> Should I just add comment about it or do something like this:
>>
>> &codec {
>>   status = "okay";
>>   /*
>>    * TODO: Add codec_ext_pwr_pin to turn off external audio AMP
>>    &pio {
>>      codec_ext_pwr_pin: codec_ext_pwr_pin at 0 {
>>        allwinner,pins = "PH15";
>>        allwinner,function = "gpio_out";
>>        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>        allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>      }
>>    }
>>    */
>> }
>
> More like
>
> &pio {
>         codec_ext_pwr_pin: codec_ext_pwr_pin at 0 {
>                 allwinner,pins = "PH15";
>                 allwinner,function = "gpio_out";
>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                 allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>         };
> };
>
> &codec {
>         /* This pin is used to turn off the GPIO amp pin */
>         pinctrl-names = "default";
>         pinctrl-0 <&codec_ext_pwr_pin>;
>         status = "okay";
> };
>
> Of course, that's a temporary measure, and you should actually use
> that GPIO to enable / disable the Amplifier when you are playing
> sound. It shouldn't be that hard with ASoC.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
