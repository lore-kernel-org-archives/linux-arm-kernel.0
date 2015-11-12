From: plaes@plaes.org (Priit Laes)
Date: Thu, 12 Nov 2015 20:53:19 +0200
Subject: [linux-sunxi] Re: [PATCH v3 3/3] ARM: dts: sun4i: gemei-g9:
 Enable sun4i audio codec support
In-Reply-To: <CAGb2v66uG-0EgVR=5SS4Lk-y5mX9v3Z39xP+0f7u7BfYq-b1yw@mail.gmail.com>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
 <1446832486-32319-4-git-send-email-plaes@plaes.org>
 <CAGb2v66uG-0EgVR=5SS4Lk-y5mX9v3Z39xP+0f7u7BfYq-b1yw@mail.gmail.com>
Message-ID: <1447354399.31635.10.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-11-09 at 11:59 +0800, Chen-Yu Tsai wrote:
> On Sat, Nov 7, 2015 at 1:54 AM, Priit Laes <plaes@plaes.org> wrote:
> > Gemei G9 has internal speakers and headphone jack. Audio switching
> > from internal speakers to headphones is automatically handled by
> > extra FT2012Q audio amplifier chip that works out of the box.
> 
> Nice that it works out of the box. The FEX file does mention:
> 
> audio_pa_ctrl???= port:PH15<1><default><default><0>

Nice catch.

Setting it low mutes audio, and setting it back high unmutes.



> So either it is floating or pulled up by default? Since it works
> now I don't see any reason to block it. On the other hand once
> that binding is introduced it would be nice to add it for power
> management reasons.

Should I just add comment about it or do something like this:

&codec {
? status = "okay";
? /*
? ?* TODO: Add codec_ext_pwr_pin to turn off external audio AMP
? ?&pio {
? ? ?codec_ext_pwr_pin:?codec_ext_pwr_pin at 0?{
? ? ? ?allwinner,pins = "PH15";
? ? ? ?allwinner,function = "gpio_out";
? ? ? ?allwinner,drive = <SUN4I_PINCTRL_10_MA>;
? ? ? ?allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
? ? ?}
? ?}
? ?*/
}


> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> > Changes since v2:
> > ?- Dropped routing property.
> > 
> > ?arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 5 ++++-
> > ?1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> > b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> > index 16c1a67..1d73a98 100644
> > --- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> > +++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> > @@ -65,12 +65,15 @@
> > ?/*
> > ? * TODO:
> > ? *???2x cameras via CSI
> > - *???audio
> > + *???audio input
> > ? *???AXP battery management
> > ? *???NAND
> > ? *???OTG
> > ? *???Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
> > ? */
> > +&codec {
> > +???????status = "okay";
> > +};
> > 
> > ?&cpu0 {
> > ????????cpu-supply = <&reg_dcdc2>;
> > --
> > 2.6.3
> > 
> 
