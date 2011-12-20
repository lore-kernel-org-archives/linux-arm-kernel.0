From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 20 Dec 2011 15:54:45 +0000
Subject: [PATCHv2 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <4EF0AD6A.7070309@gmail.com>
References: <1324345431-12251-1-git-send-email-jamie@jamieiles.com>
 <4EF0AD6A.7070309@gmail.com>
Message-ID: <20111220155445.GA19585@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 09:44:42AM -0600, Rob Herring wrote:
> Jamie,
> 
> On 12/19/2011 07:43 PM, Jamie Iles wrote:
> > The Synopsys DesignWare block is used in some ARM devices (picoxcell)
> > and can be configured to provide multiple banks of GPIO pins.  The first
> > bank (A) can also provide IRQ capabilities.
> > 
> > v2:	- use Rob Herring's irqdomain in generic irq chip patches
> > 	- use reg property to indicate bank index
> > 	- support irqs on both edges based on LinusW's u300 driver
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > ---
[...]
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
> > +- reg : The integer bank index of the bank, a single cell.
> > +- nr-gpio : The number of pins in the bank, a single cell.
[...]
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
> > +		reg = <0>;
> 
> Actually, what I meant was to use the bank addresses here. Sorry that
> wasn't clear. Then you don't need a calculation of bank offsets.

Unfortunately the hardware doesn't have a nice register map where the 
registers for each bank are grouped together and they're all interleaved 
so it's a bit of a mess really. 

Some of the picoxcell devices have configurations like 8 pins on bank A, 
16 on bank B then 20 or so on bank D, so I do think it makes sense to 
define the banks as individual nodes and it fits in with the 
programming model.

Jamie
