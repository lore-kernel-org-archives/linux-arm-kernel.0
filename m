From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 29 May 2013 10:01:43 +0200
Subject: [PATCH v4 15/21] ARM: shmobile: armadillo-reference: Move st1232
 reset GPIO to DT
In-Reply-To: <CACRpkdYUQjtmzFzQBES-bcjjT5iTTXifa2BQSusBzMdTCRtyiA@mail.gmail.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369138482-5871-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdYUQjtmzFzQBES-bcjjT5iTTXifa2BQSusBzMdTCRtyiA@mail.gmail.com>
Message-ID: <7726129.eAP65oL724@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thanks for the review.

On Friday 24 May 2013 10:59:50 Linus Walleij wrote:
> On Tue, May 21, 2013 at 2:14 PM, Laurent Pinchart wrote:
> > Reference the st1232 reset GPIO from the device tree and remove it from
> > board code.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> > @@ -43,6 +43,7 @@
> > 
> >                 interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
> >                 pinctrl-0 = <&st1232_pins>;
> >                 pinctrl-names = "default";
> > 
> > +               gpios = <&pfc 166 1>;
> 
> Just as a random example this becomes:
> 
> gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
> 
> Which is WAAAY more readable.

As stated in my reply to your other e-mail, I'll switch to symbolic constants.

> > +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> > 
> > @@ -158,7 +158,6 @@ clock_error:
> >   */
> >  static void __init eva_init(void)
> >  {
> > -
> >         r8a7740_clock_init(MD_CK0 | MD_CK2);
> >         eva_clock_init();
> > 
> > @@ -171,12 +170,6 @@ static void __init eva_init(void)
> > 
> >         r8a7740_add_standard_devices_dt();
> > 
> > -       /*
> > -        * Touchscreen
> > -        * TODO: Move reset GPIO over to .dts when we can reference it
> > -        */
> > -       gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
> > -
> 
> Not really my business but I guess the driver is already augmented to pick
> its GPIO from the device tree in this case?

Yes it is.

> And are you willingly breaking non-DT boots or something?

The armadillo-reference board doesn't support non-DT boot.

-- 
Regards,

Laurent Pinchart
