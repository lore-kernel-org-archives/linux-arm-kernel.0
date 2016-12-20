From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Dec 2016 14:50:11 +0100
Subject: [PATCH] ARM: dts: sun8i-q8-common: enable bluetooth on SDIO Wi-Fi
In-Reply-To: <CAGb2v67wU+Hw-6oa9FxzB33sZY8Up-59HZ_mneFBdcRhXbU1pA@mail.gmail.com>
References: <20161213233658.atGuNCNY@smtp1h.mail.yandex.net>
 <20161216124748.rkvnnlo4x5onzpvk@lukather>
 <4720181481899200@web7g.yandex.ru>
 <20161219100952.bspym36nsehda3za@lukather>
 <11985541482156512@web2g.yandex.ru>
 <CAGb2v67wU+Hw-6oa9FxzB33sZY8Up-59HZ_mneFBdcRhXbU1pA@mail.gmail.com>
Message-ID: <20161220135011.2rk7v6tjujhivcy6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 10:24:44PM +0800, Chen-Yu Tsai wrote:
> On Mon, Dec 19, 2016 at 10:08 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> >
> >
> > 19.12.2016, 18:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> >> On Fri, Dec 16, 2016 at 10:40:00PM +0800, Icenowy Zheng wrote:
> >>>  >>  > >  &r_pio {
> >>>  >>  > >  wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
> >>>  >>  > > - pins = "PL6", "PL7", "PL11";
> >>>  >>  > > + pins = "PL6", "PL7", "PL8", "PL11";
> >>>  >>  > >  function = "gpio_in";
> >>>  >>  > >  bias-pull-up;
> >>>  >>  > >  };
> >>>  >>  >
> >>>  >>  > There's several things wrong here. The first one is that you rely
> >>>  >>  > solely on the pinctrl state to maintain a reset line. This is very
> >>>  >>  > fragile (especially since the GPIO pinctrl state are likely to go away
> >>>  >>  > at some point), but it also means that if your driver wants to recover
> >>>  >>  > from that situation at some point, it won't work.
> >>>  >>  >
> >>>  >>  > The other one is that the bluetooth and wifi chips are two devices in
> >>>  >>  > linux, and you assign that pin to the wrong device (wifi).
> >>>  >>  >
> >>>  >>  > rfkill-gpio is made just for that, so please use it.
> >>>  >>
> >>>  >>  The GPIO is not for the radio, but for the full Bluetooth part.
> >>>  >
> >>>  > I know.
> >>>  >
> >>>  >>  If it's set to 0, then the bluetooth part will reset, and the
> >>>  >>  hciattach will fail.
> >>>  >
> >>>  > Both rfkill-gpio and rfkill-regulator will shutdown when called
> >>>  > (either by poking the reset pin or shutting down the regulator), so
> >>>  > that definitely seems like an expected behavior to put the device in
> >>>  > reset.
> >>>  >
> >>>  >>  The BSP uses this as a rfkill, and the result is that the bluetooth
> >>>  >>  on/off switch do not work properly.
> >>>  >
> >>>  > Then rfkill needs fixing, but working around it by hoping that the
> >>>  > core will probe an entirely different device, and enforcing a default
> >>>  > that the rest of the kernel might or might not change is both fragile
> >>>  > and wrong.
> >>>
> >>>  I think a rfkill-gpio here works just like the BSP rfkill...
> >>>
> >>>  The real problem is that the Realtek UART bluetooth driver is a userspace
> >>>  program (a modified hciattach), which is not capable of the GPIO reset...
> >>
> >> Can't you run rfkill before attaching? What is the problem exactly?
> >> It's not in reset for long enough?
> >>
> >> This seems more and more like an issue in the BT stack you're
> >> using. We might consider workarounds in the kernel, but they have to
> >> be correct.
> >
> > One more rfkill interface will be generated for hci0 after hciattach, which can
> > be safely toggled block and unblock.
> >
> > However, if the GPIO is toggled down, the hciattach program will die.
> >
> > The bluetooth stack I used is fd.o's BlueZ.
> 
> I think the bigger issue is that the tty/serial subsystem does not have
> power sequencing support. Here we're trying to use rfkill to do that,
> but that doesn't seem to be what it was intended for. It might work with
> standalone USB bluetooth controllers that don't need any special setup,
> since the device will just appear and get registered. But it might not
> work so well with UART based adapters that need userspace fiddling with
> firmware and hciattach.

Then you can also have a look at the generic power sequence patches
that are floating around.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161220/4ffe5077/attachment.sig>
