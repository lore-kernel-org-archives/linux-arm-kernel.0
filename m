From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 09:38:33 +0100
Subject: [PATCH] ARM: dts: sun9i: Enable USB support on Cubieboard4
In-Reply-To: <CAGb2v66XNAHwAU1eosYjGKgYKkh9YiVEooE9e45RSVvPOvhYLg@mail.gmail.com>
References: <20171216205809.5485-1-kettenis@openbsd.org>
 <CAGb2v66XNAHwAU1eosYjGKgYKkh9YiVEooE9e45RSVvPOvhYLg@mail.gmail.com>
Message-ID: <20180122083833.cnjsks3dj3uakcbt@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 20, 2018 at 02:12:04PM +0800, Chen-Yu Tsai wrote:
> Maxime,
> 
> On Sun, Dec 17, 2017 at 4:58 AM, Mark Kettenis <kettenis@openbsd.org> wrote:
> > On the Cubieboard4 HCI0 is directly connected to a USB connector,
> > and HCI2 is connected to a USB hub on the board.  HCI1 is available
> > with HSIC throug 2 pins on the GPIO expansion header, but left
> > disabled just like on the Optimus board.
> >
> > This patch also adds the VBUS regulators.
> >
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> 
> Any thoughts on this patch?
> 
> It's similar to what I sent a few years back:
> 
>     https://patchwork.kernel.org/patch/6359461/

Given the previous discussion, I guess we should have much more
comments on how it is designed.

There was some effort to have power sequence for USB devices described
in the DT here:
https://patchwork.kernel.org/patch/9800887/

I guess pinging Peter to know the current state would be a good way
forward.

> >  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 36 +++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> > index 4024639aa005..e38623265695 100644
> > --- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> > +++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> > @@ -74,6 +74,24 @@
> >                 };
> >         };
> >
> > +       reg_usb1_vbus: usb1-vbus {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "usb2-drvbus";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +               enable-active-high;
> > +               gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
> > +       };
> > +
> > +       reg_usb3_vbus: usb3-vbus {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "usb1-drvbus";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +               enable-active-high;
> > +               gpio = <&pio 7 14 GPIO_ACTIVE_HIGH>; /* PH14 */
> > +       };

You should also have a proper parenthood relationship here, and not
just leave these two regulators hanging around.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180122/1fd4e432/attachment.sig>
