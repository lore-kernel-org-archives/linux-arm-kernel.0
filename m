From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 19 Dec 2011 09:56:54 +0000
Subject: [PATCH 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <4EEEA983.7010402@gmail.com>
References: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
 <4EEEA983.7010402@gmail.com>
Message-ID: <20111219095654.GB2459@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Sun, Dec 18, 2011 at 09:03:31PM -0600, Rob Herring wrote:
> Jamie,
> 
> On 12/18/2011 04:13 AM, Jamie Iles wrote:
> > The Synopsys DesignWare block is used in some ARM devices (picoxcell)
> > and can be configured to provide multiple banks of GPIO pins.  The first
> > bank (A) can also provide IRQ capabilities.
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > ---
> > 
> > I was originally working on a generic binding for the generic gpio
> > driver, but this doesn't scale well when there are interrupt
> > capabilities in the controller, so here's a driver specifically for the
> > Synopsys block.
> > 
> >  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |   63 ++++
> >  drivers/gpio/Kconfig                               |   10 +
> >  drivers/gpio/Makefile                              |    1 +
> >  drivers/gpio/gpio-dwapb.c                          |  337 ++++++++++++++++++++
> >  4 files changed, 411 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> >  create mode 100644 drivers/gpio/gpio-dwapb.c
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> > new file mode 100644
> > index 0000000..62943fd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> > @@ -0,0 +1,63 @@
> > +* Synopsys DesignWare APB GPIO controller
> > +
> > +Required properties:
> > +- compatible : Should be "snps,dw-apb-gpio"
> > +- reg : Address and length of the register set for the device
> > +
> > +The GPIO controller has a configurable number of banks, each of which are
> > +represented as child nodes with the following properties:
> > +
> > +Required properties:
> > +- compatible : "snps,dw-apb-gpio-bank"
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells : Should be two.  The first cell is the pin number and
> > +  the second cell is used to specify optional parameters (currently
> > +  unused).
> > +- snps,gpio-bank : The integer bank index of the bank, a single cell.
> 
> What about using reg for this? It looks like this is only used for
> calculating register addresses?
> 
> This smells a bit like cell-index which is a no-no.

I did think of using reg originally, but as the banks have memory-mapped 
registers it felt like it was overloading it a little.  I'm more than 
happy to change to use reg as the index if you think that's the right 
thing to do.

> > +- nr-gpio : The number of pins in the bank, a single cell.
> 
> Valid range is ?

Good point, I'll clarify that, but it's up to 32.

> > +
> > +Optional properties:
> > +- interrupt-controller : The first bank may be configured to be an interrupt
> > +controller.
> > +- #interrupt-cells : Specifies the number of cells needed to encode an
> > +interrupt.  Shall be set to 2.  The first cell defines the interrupt number,
> > +the second encodes the triger flags encoded as:
> > +
> > +	bits[3:0] trigger type and level flags.
> > +		1 = low-to-high edge triggered
> > +		2 = high-to-low edge triggered
> > +		4 = active high level-sensitive
> > +		8 = active low level-sensitive
> > +
> > +- interrupt-parent : The parent interrupt controller.
> > +- interrupts : The interrupts to the parent controller raised when GPIOs
> > +generate the interrupts.
> > +
> > +Example:
> > +
> > +gpio: gpio at 20000 {
> > +	compatible = "snps,dw-apb-gpio";
> > +	reg = <0x20000 0x1000>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	banka: gpio-controller at 0 {
> > +		compatible = "snps,dw-apb-gpio-bank";
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		nr-gpio = <8>;
> > +		snps,gpio-bank = <0>
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +		interrupt-parent = <&vic1>;
> > +		interrupts = <0 1 2 3 4 5 6 7>;
> > +	};
> > +
> > +	bankb: gpio-controller at 1 {
> > +		compatible = "snps,dw-apb-gpio-bank";
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		nr-gpio = <8>;
> > +		snps,gpio-bank = <1>
> > +	};
> > +};
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 573532f..93fd69d 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -85,6 +85,16 @@ config GPIO_GENERIC_PLATFORM
> >  	help
> >  	  Say yes here to support basic platform_device memory-mapped GPIO controllers.
> >  
> > +config GPIO_DWAPB
> > +	bool "Synopsys DesignWare APB GPIO driver"
> > +	select GPIO_GENERIC
> > +	select GENERIC_IRQ_CHIP
> > +	select IRQ_DOMAIN
> 
> In case you missed it, my irq domain support for generic irq chip makes
> this and putting domain code in your driver unnecessary.

I'm sure I did see those patches but managed to completely miss them 
when doing this.  I'll grab those and give them a test.

Jamie
