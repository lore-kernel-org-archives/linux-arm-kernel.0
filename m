From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 9 Feb 2016 09:43:51 -0800
Subject: [PATCH 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <3b53af6b6c6735d10cb88518c8b8a0ae@mail.gmail.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <2631849.GeOulu78vx@wuerfel>
 <3b53af6b6c6735d10cb88518c8b8a0ae@mail.gmail.com>
Message-ID: <20160209174351.GC40460@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 10:25:26PM +0530, Raveendra Padasalagi wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: 09 February 2016 16:34
> > To: Raveendra Padasalagi
> > Cc: Dmitry Torokhov; Russell King; devicetree at vger.kernel.org;
> linux-arm-
> > kernel at lists.infradead.org; linux-input at vger.kernel.org; Rob Herring;
> Pawel
> > Moll; Mark Rutland; Ian Campbell; Kumar Gala; Jonathan Richardson; Jon
> > Mason; Florian Fainelli; Ray Jui; Scott Branden;
> linux-kernel at vger.kernel.org;
> > bcm-kernel-feedback-list at broadcom.com
> > Subject: Re: [PATCH 1/3] input: cygnus-update touchscreen dt node
> document
> >
> > On Tuesday 09 February 2016 14:27:55 Raveendra Padasalagi wrote:
> > > +
> > > +One of the below 2 property is mandatory.
> > > +- ts_syscon: handler of syscon node defining physical base address
> > > +  of the controller and length of memory mapped region.
> > > +  If this property is selected please make sure MFD_SYSCON config
> > > +  is enabled in the defconfig file.
> > > +or
> > > +- reg: physical base address of the controller and length of memory
> > > +  mapped region.
> > > +
> > >  - clocks:  The clock provided by the SOC to driver the tsc
> > >  - clock-name:  name for the clock
> > >  - interrupts: The touchscreen controller's interrupt @@ -54,12 +62,16
> > > @@ Optional properties:
> > >  - touchscreen-inverted-y: Y axis is inverted (boolean)
> > >
> > >  Example:
> > > +       ts_adc_syscon: ts_adc_syscon at 0x180a6000 {
> > > +               compatible = "syscon";
> > > +               reg = <0x180a6000 0xc30>;
> > > +       };
> > >
> > >         touchscreen: tsc at 0x180A6000 {
> > >                 compatible = "brcm,iproc-touchscreen";
> > >                 #address-cells = <1>;
> > >                 #size-cells = <1>;
> > > -               reg = <0x180A6000 0x40>;
> > > +               syscon = <&ts_adc_syscon>;
> > >                 clocks = <&adc_clk>;
> > >                 clock-names = "tsc_clk";
> > >                 interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> >
> > This doesn't seem right: For one thing, it's an incompatible binding
> change which
> > you should try to avoid.
> 
> > Worse, the syscon has a name indicating that it really has a particular
> function,
> > but the name is completely generic (just "syscon"). Please add a
> specific
> > compatible string identifying the device that owns the registers, and
> put any
> > other associated properties (clocks, interrupts, ...) that are for that
> device in
> > general rather than just the touchscreen in there.
> 
> By mistake "syscon" name is documented in "touchscreen" label above. In
> the
> touchscreen driver code and .dtsi file it's named and used as "ts_syscon".
> Please refer https://lkml.org/lkml/2016/2/9/71 for the changes.
> Let me know if this ok. I will correct the documentation in the next
> patch.
> 
> > Your changelog text fails to describe why you do this change in the
> first place,
> > and why you can't do it in a backward-compatible way, so please rewrite
> that
> > text.
> 
> Yes, I will update the change log in the next patch.
> 
> In Cygnus SOC, Touch screen controller registers are shared with ADC and
> flex timer IP's.
> Using readl/writel could lead to race condition. So this patch is
> introduced to take care
> mutually exclusive access of register's in such a case.
> 
> In the platform's where touchscreen register's are not shared normal
> readl/writel
> could be used.

Are there currently platforms where the registers are not shared? If we
have to use regmap to correctly update registers (and thus we need
syscon) then I wonder if we should even attempt to support direct
register access by the driver.

> 
> Based on the dt  property entry "reg" or "ts_syscon" register accesses are
> handled.
> if "reg" is provided normal readl/writel API's are used to access
> register's else if
> "ts_syscon" is provided then syscon API's are used.

If we decide that we still allow register access then please change the
driver so it instantiates its own regmap instance in this case instead
of doing checks all the time.

Thanks.

-- 
Dmitry
