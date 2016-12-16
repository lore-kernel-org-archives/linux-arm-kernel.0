From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 16 Dec 2016 22:40:00 +0800
Subject: [PATCH] ARM: dts: sun8i-q8-common: enable bluetooth on SDIO Wi-Fi
In-Reply-To: <20161216124748.rkvnnlo4x5onzpvk@lukather>
References: <20161213233658.atGuNCNY@smtp1h.mail.yandex.net>
 <20161216124748.rkvnnlo4x5onzpvk@lukather>
Message-ID: <4720181481899200@web7g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



16.12.2016, 20:47, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Fri, Dec 09, 2016 at 07:49:00PM +0800, Icenowy Zheng wrote:
>> ?2016?12?9? ??4:07? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> ?>
>> ?> On Tue, Dec 06, 2016 at 04:08:38PM +0800, Icenowy Zheng wrote:
>> ?> > Some SDIO Wi-Fi chips (such as RTL8703AS) have a UART bluetooth, which
>> ?> > has a dedicated enable pin (PL8 in the reference design).
>> ?> >
>> ?> > Enable the pin in the same way as the WLAN enable pins.
>> ?> >
>> ?> > Tested on an A33 Q8 tablet with RTL8703AS.
>> ?> >
>> ?> > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?> > ---
>> ?> >
>> ?> > This patch should be coupled with the uart1 node patch I send before:
>> ?> > http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/471997.html
>> ?> >
>> ?> > For RTL8703AS, the rtl8723bs bluetooth code is used, which can be retrieve from:
>> ?> > https://github.com/lwfinger/rtl8723bs_bt
>> ?> >
>> ?> >? arch/arm/boot/dts/sun8i-q8-common.dtsi | 2 +-
>> ?> >? 1 file changed, 1 insertion(+), 1 deletion(-)
>> ?> >
>> ?> > diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
>> ?> > index c676940..4aeb5bb 100644
>> ?> > --- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
>> ?> > +++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
>> ?> > @@ -88,7 +88,7 @@
>> ?> >
>> ?> >? &r_pio {
>> ?> >? wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
>> ?> > - pins = "PL6", "PL7", "PL11";
>> ?> > + pins = "PL6", "PL7", "PL8", "PL11";
>> ?> >? function = "gpio_in";
>> ?> >? bias-pull-up;
>> ?> >? };
>> ?>
>> ?> There's several things wrong here. The first one is that you rely
>> ?> solely on the pinctrl state to maintain a reset line. This is very
>> ?> fragile (especially since the GPIO pinctrl state are likely to go away
>> ?> at some point), but it also means that if your driver wants to recover
>> ?> from that situation at some point, it won't work.
>> ?>
>> ?> The other one is that the bluetooth and wifi chips are two devices in
>> ?> linux, and you assign that pin to the wrong device (wifi).
>> ?>
>> ?> rfkill-gpio is made just for that, so please use it.
>>
>> ?The GPIO is not for the radio, but for the full Bluetooth part.
>
> I know.
>
>> ?If it's set to 0, then the bluetooth part will reset, and the
>> ?hciattach will fail.
>
> Both rfkill-gpio and rfkill-regulator will shutdown when called
> (either by poking the reset pin or shutting down the regulator), so
> that definitely seems like an expected behavior to put the device in
> reset.
>
>> ?The BSP uses this as a rfkill, and the result is that the bluetooth
>> ?on/off switch do not work properly.
>
> Then rfkill needs fixing, but working around it by hoping that the
> core will probe an entirely different device, and enforcing a default
> that the rest of the kernel might or might not change is both fragile
> and wrong.

I think a rfkill-gpio here works just like the BSP rfkill...

The real problem is that the Realtek UART bluetooth driver is a userspace
program (a modified hciattach), which is not capable of the GPIO reset...

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
