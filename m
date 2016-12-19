From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Dec 2016 11:09:52 +0100
Subject: [PATCH] ARM: dts: sun8i-q8-common: enable bluetooth on SDIO Wi-Fi
In-Reply-To: <4720181481899200@web7g.yandex.ru>
References: <20161213233658.atGuNCNY@smtp1h.mail.yandex.net>
 <20161216124748.rkvnnlo4x5onzpvk@lukather>
 <4720181481899200@web7g.yandex.ru>
Message-ID: <20161219100952.bspym36nsehda3za@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 10:40:00PM +0800, Icenowy Zheng wrote:
> >> ?> >? &r_pio {
> >> ?> >? wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
> >> ?> > - pins = "PL6", "PL7", "PL11";
> >> ?> > + pins = "PL6", "PL7", "PL8", "PL11";
> >> ?> >? function = "gpio_in";
> >> ?> >? bias-pull-up;
> >> ?> >? };
> >> ?>
> >> ?> There's several things wrong here. The first one is that you rely
> >> ?> solely on the pinctrl state to maintain a reset line. This is very
> >> ?> fragile (especially since the GPIO pinctrl state are likely to go away
> >> ?> at some point), but it also means that if your driver wants to recover
> >> ?> from that situation at some point, it won't work.
> >> ?>
> >> ?> The other one is that the bluetooth and wifi chips are two devices in
> >> ?> linux, and you assign that pin to the wrong device (wifi).
> >> ?>
> >> ?> rfkill-gpio is made just for that, so please use it.
> >>
> >> ?The GPIO is not for the radio, but for the full Bluetooth part.
> >
> > I know.
> >
> >> ?If it's set to 0, then the bluetooth part will reset, and the
> >> ?hciattach will fail.
> >
> > Both rfkill-gpio and rfkill-regulator will shutdown when called
> > (either by poking the reset pin or shutting down the regulator), so
> > that definitely seems like an expected behavior to put the device in
> > reset.
> >
> >> ?The BSP uses this as a rfkill, and the result is that the bluetooth
> >> ?on/off switch do not work properly.
> >
> > Then rfkill needs fixing, but working around it by hoping that the
> > core will probe an entirely different device, and enforcing a default
> > that the rest of the kernel might or might not change is both fragile
> > and wrong.
> 
> I think a rfkill-gpio here works just like the BSP rfkill...
> 
> The real problem is that the Realtek UART bluetooth driver is a userspace
> program (a modified hciattach), which is not capable of the GPIO reset...

Can't you run rfkill before attaching? What is the problem exactly?
It's not in reset for long enough?

This seems more and more like an issue in the BT stack you're
using. We might consider workarounds in the kernel, but they have to
be correct.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161219/7f84717e/attachment.sig>
