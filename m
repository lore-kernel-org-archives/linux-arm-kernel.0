From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Feb 2014 17:54:09 +0000
Subject: [PATCHv2 1/8] ARM: at91: Add at91sam9rl DT SoC support
In-Reply-To: <20140219173141.GB3038@piout.net>
References: <1392823951-26053-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1392823951-26053-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20140219170020.GA25079@e106331-lin.cambridge.arm.com>
 <20140219173141.GB3038@piout.net>
Message-ID: <20140219175409.GF25079@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 05:31:42PM +0000, Alexandre Belloni wrote:
> On 19/02/2014 at 17:00:20 +0000, Mark Rutland wrote :
> > On Wed, Feb 19, 2014 at 03:32:24PM +0000, Alexandre Belloni wrote:
> > > This adds preliminary DT support for the at91sam9rl.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > >  arch/arm/boot/dts/at91sam9rl.dtsi | 628 ++++++++++++++++++++++++++++++++++++++
> > >  arch/arm/mach-at91/at91sam9rl.c   |  16 +
> > >  2 files changed, 644 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/at91sam9rl.dtsi
> >  
> > [...]
> > 
> > > +                       tcb0: timer at fffa0000 {
> > > +                               compatible = "atmel,at91rm9200-tcb";
> > > +                               reg = <0xfffa0000 0x100>;
> > > +                               interrupts = <16 IRQ_TYPE_LEVEL_HIGH 0
> > > +                                             17 IRQ_TYPE_LEVEL_HIGH 0
> > > +                                             18 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                       };
> > 
> > Nit: please bracket list entries individually. Also for other list
> > properties like reg and (*-)gpio(s).
> > 
> 
> OK.
> 
> > [...]
> > 
> > > +                       adc0: adc at fffd0000 {
> > > +                               compatible = "atmel,at91sam9260-adc";
> > > +                               reg = <0xfffd0000 0x100>;
> > > +                               interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +                               atmel,adc-use-external-triggers;
> > > +                               atmel,adc-channels-used = <0xf>;
> > > +                               atmel,adc-vref = <3300>;
> > > +                               atmel,adc-num-channels = <4>;
> > > +                               atmel,adc-startup-time = <15>;
> > > +                               atmel,adc-channel-base = <0x30>;
> > > +                               atmel,adc-drdy-mask = <0x10000>;
> > > +                               atmel,adc-status-register = <0x1c>;
> > > +                               atmel,adc-trigger-register = <0x04>;
> > > +                               atmel,adc-res = <8 10>;
> > > +                               atmel,adc-res-names = "lowres", "highres";
> > > +                               atmel,adc-use-res = "highres";
> > > +
> > > +                               trigger at 0 {
> > > +                                       trigger-name = "timer-counter-0";
> > > +                                       trigger-value = <0x1>;
> > > +                               };
> > 
> > A unit-address should go with a reg value. Either this needs a reg and
> > the parent node needs #address-cells and #size-cells, or the
> > unit-address should go, and the names made unique through other means.
> > 
> 
> OK, I guess I'll have to fix
> Documentation/devicetree/bindings/arm/atmel-adc.txt too.

Yes please.

> 
> > [...]
> > 
> > > +                       pinctrl at fffff400 {
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <1>;
> > > +                               compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> > 
> > NAK. Either this is a atmel,at91rm9200-pinctrl node or a simple-bus. Not
> > both; that doesn't make any sense.
> > 
> 
> Simply a copy paste, I'll fix that here and also the 6 other atmel
> dtsi includes.
> 
> What is your preference for those using:
> compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus"; ?

A node should by either a bus or a pinctrl node.

If it has chidren then the simple-bus should be separated out into a
separate node. If there are no children simple-bus should go.

Cheers,
Mark.
