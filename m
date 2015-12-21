From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Dec 2015 16:43:42 +0100
Subject: [PATCH 1/4] ARM: dts: sun7i: Enable touchscreen on Wexler
 TAB7200 tablet
In-Reply-To: <CAF==cZWcY=FH9Sr8RY4j4Ob8iuiYrBGkajZDWpNQzS-t4d074Q@mail.gmail.com>
References: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
 <1450428710-5653-1-git-send-email-mamlinav@gmail.com>
 <20151218212525.GR30359@lukather>
 <CAF==cZWcY=FH9Sr8RY4j4Ob8iuiYrBGkajZDWpNQzS-t4d074Q@mail.gmail.com>
Message-ID: <20151221154342.GV30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 06:11:40PM +0300, Aleksei Mamlin wrote:
> 2015-12-19 0:25 GMT+03:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> 
> > Hi,
> >
> > On Fri, Dec 18, 2015 at 11:51:50AM +0300, Aleksei Mamlin wrote:
> > > Add a node for the Goodix GT911 touchscreen found on the Wexler TAB7200
> > tablet
> > >
> > > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > > index 239b5d2..ec3b837 100644
> > > --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > > +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> > > @@ -102,6 +102,18 @@
> > >       pinctrl-names = "default";
> > >       pinctrl-0 = <&i2c2_pins_a>;
> > >       status = "okay";
> > > +
> > > +     gt911: touchscreen at 5d {
> > > +             compatible = "goodix,gt911";
> > > +             reg = <0x5d>;
> > > +             interrupt-parent = <&pio>;
> > > +             interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21
> > (PH21) */
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&ts_reset_pin>;
> > > +             irq-gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* INT (PH21) */
> >
> > It seems odd that you need both irq-gpios and interrupts. These two
> > are completely redundant, and you should even actually use only one in
> > your driver, since the second request_irq will fail.
> >
> >
> We need both interrupts and irq-gpios because the driver uses the interrupt
> gpio pin as output to reset the device. See bindings documentation [1]
> 
> [1]
> https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/tree/Documentation/devicetree/bindings/input/touchscreen/goodix.txt?h=goodix

Hmm, indeed, and even the documentation is confusing.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/d7bf2b64/attachment-0001.sig>
