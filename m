From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Nov 2015 12:32:42 +0100
Subject: [PATCH 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1447845958.3144.61.camel@pengutronix.de>
References: <1447840120-8513-1-git-send-email-marex@denx.de>
 <201511181135.40171.marex@denx.de> <1447845958.3144.61.camel@pengutronix.de>
Message-ID: <201511181232.42446.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 18, 2015 at 12:25:58 PM, Lucas Stach wrote:
> Am Mittwoch, den 18.11.2015, 11:35 +0100 schrieb Marek Vasut:
> > On Wednesday, November 18, 2015 at 11:10:12 AM, Lucas Stach wrote:
> > > Hi Marek,
> > 
> > Hi!
> > 
> > > some comments below.
> > 
> > Thanks!
> > 
> > [...]
> > 
> > > > +	regulators {
> > > > +		compatible = "simple-bus";
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > 
> > > Remove this simple bus. It's not there in hardware, regulators are
> > > board level components just like the nodes below.
> > 
> > This is surprising to me, since all the boards I checked use this
> > /regulators simple bus to contain all the regulators. Is this going to
> > change now ?
> 
> Yes, there are a lot of bad examples out there, mainly because people
> wanted to logically group the regulators together.

Yeah, that's what I wanted to do as well :)

> But as it isn't
> representing any real hardware we should really try to move away from
> this practice.

Oh, thanks for this input.

> > [...]
> > 
> > > > +&ecspi3 {
> > > > +	pinctrl-names = "default";
> > > > +	pinctrl-0 = <&pinctrl_ecspi3_novena>;
> > > > +	fsl,spi-num-chipselects = <3>;
> > > > +	status = "okay";
> > > > +
> > > > +	spidev at 0 {
> > > > +		compatible = "spidev";
> > > 
> > > This will explode on a new kernel. Specifying spidev without using a
> > > more specific compatible will trigger a WARN_ON(), as it's considered
> > > bad style.
> > 
> > Oh, looks like imx_v6_v7_defconfig didn't have SPIDEV active, which is
> > why I didn't catch it during my last test, dang.
> > 
> > This SPI interface is routed into the FPGA, so what do you suggest I put
> > in the compatible string? There is no other sensible driver for the
> > peripheral, since the peripheral can be anything.
> 
> I'm not really the right person to ask for that, but I would guess that
> inventing a "novena,fpga-spi" compatible or something like that and
> adding it to the spidev driver would be the right thing to do.

So what's the rationale behind generic "spidev" being bad ? In my mind, it
is much better to use generic driver and generic compatible prop "spidev"
than to generate many one-off compatible props and have a driver with a list
of all of those.

Best regards,
Marek Vasut
