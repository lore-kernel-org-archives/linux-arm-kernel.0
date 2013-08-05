From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Aug 2013 16:35:16 +0100
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1375687936.4000.21.camel@pizza.hi.pengutronix.de>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
 <1375687936.4000.21.camel@pizza.hi.pengutronix.de>
Message-ID: <20130805153516.GC13091@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 08:32:16AM +0100, Philipp Zabel wrote:
> Hi Mark,

Hi Philipp,

> 
> Am Freitag, den 02.08.2013, 10:28 +0100 schrieb Mark Rutland:
> > On Thu, Jul 18, 2013 at 10:26:26AM +0100, Philipp Zabel wrote:
> > > This driver implements a reset controller device that toggle a gpio
> > > connected to a reset pin of a peripheral IC. The delay between assertion
> > > and de-assertion of the reset signal can be configured via device tree.
> > > 
> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > > ---
> > > Changes since v9:
> > >  - Use gpio_set_value_cansleep unconditionally. reset_controller_assert/deassert
> > >    should not be called from atomic context.
> > > ---
> > >  .../devicetree/bindings/reset/gpio-reset.txt       |  35 ++++
> > >  drivers/reset/Kconfig                              |  11 ++
> > >  drivers/reset/Makefile                             |   1 +
> > >  drivers/reset/gpio-reset.c                         | 184 +++++++++++++++++++++
> > >  4 files changed, 231 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.txt
> > >  create mode 100644 drivers/reset/gpio-reset.c
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.txt b/Documentation/devicetree/bindings/reset/gpio-reset.txt
> > > new file mode 100644
> > > index 0000000..bca5348
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/gpio-reset.txt
> > > @@ -0,0 +1,35 @@
> > > +GPIO reset controller
> > > +=====================
> > > +
> > > +A GPIO reset controller controls a single GPIO that is connected to the reset
> > > +pin of a peripheral IC. Please also refer to reset.txt in this directory for
> > > +common reset controller binding usage.
> > > +
> > > +Required properties:
> > > +- compatible: Should be "gpio-reset"
> > > +- reset-gpios: A gpio used as reset line. The gpio specifier for this property
> > > +               depends on the gpio controller that provides the gpio.
> > > +- #reset-cells: 0, see below
> > > +
> > > +Optional properties:
> > > +- reset-delay-us: delay in microseconds. The gpio reset line will be asserted for
> > > +                  this duration to reset.
> > > +- initially-in-reset: boolean. If not set, the initial state should be a
> > > +                      deasserted reset line. If this property exists, the
> > > +                      reset line should be kept in reset.
> > > +
> > > +example:
> > > +
> > > +sii902x_reset: gpio-reset {
> > > +	compatible = "gpio-reset";
> > > +	reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> > > +	reset-delay-us = <10000>;
> > > +	initially-in-reset;
> > > +	#reset-cells = <0>;
> > > +};
> > > +
> > > +/* Device with nRESET pin connected to GPIO5_0 */
> > > +sii902x at 39 {
> > > +	/* ... */
> > > +	resets = <&sii902x_reset>; /* active-low GPIO5_0, 10 ms delay */
> > > +};
> > 
> > I don't like the approach here. The reset GPIO line is not a device in
> > itself, and surely the way in which it must be toggled to reset a device
> > is a property of that device, not the GPIO. We're leaking a Linux
> > internal abstraction rather than describing teh hardware.
> 
> you are right, this results from the reset bindings being designed for
> actual hardware reset controllers that appeared in several SoCs.
> Initially I've sent the GPIO reset driver only as an example.
> 
> > I think thie linkage of the gpio would be better described on the node
> > for the device with the reset input, in a binding-specific property for
> > the device (e.g. names for the specific input line on the device):
> > 
> > I'd imagine the delay required would be fixed for a device (or possibly
> > influenced by clock inputs), and can either be knwon by the driver
> > without dt information, or discovered elsewhere (e.g. dervied from the
> > rates of clock inputs). We shuold be able to derive that from the
> > compatible string in most cases.
> > 
> > I think this should look more like the below:
> > 
> > /* Device with nRESET pin connected to GPIO5_0 */
> > sii902x at 39 {
> > 	/* named for the actual input line */
> > 	nreset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> > 	/* 
> > 	 * If there's some configurable property relating to the reset
> > 	 * line, we can describe it
> > 	 */
> > 	vendor,some-optional-reset-gpio-property;
> > 	...
> > };
> 
> I don't like the arbitrary name, as that makes it difficult to handle
> this in an automated way. In this case I'd prefer to use 'reset-gpios'
> and optionally 'reset-gpio-names' analogous to how clocks and interrupts
> (and resets) are handled. The framework itself could then also check the
> reset-gpios property and create the gpio reset controllers on the fly:

I'm not sure about the structure you suggest. The main reason we'd want
to tell apart multiple reset GPIOs (via reset-gpio-names) would be that
the device needs to have said GPIOs poked in a device-specific manner
(i.e. with some ordering and timing constraints, possibly only a subset
of the GPIOs needing to be poked to reset components of the device).

Given that, I'm not sure what separating the GPIOs out into a
reset-gpios property buys us, as the driver still needs to handle them
(at least to provide some additional information to device reset
framework code).

> 
> sii902x at 39 {
> 	reset-gpios <&gpio5 0 GPIO_ACTIVE_LOW>;
> 	reset-gpio-names = "nreset";
> 	reset-delay-us = <10000>;
> 	initially-in-reset;
> };
> 
> But this reintroduces the (currently theoretical) problem of how to
> express delays and initially-in-reset information for multiple gpio
> resets on a single device if that information cannot be determined by
> the driver automatically.
> 
> If there is a fixed delay (or a delay calculated from a known clock), we
> can just extend the API:
> 	device_reset_usleep(dev, 1000);
> instead of currently:
> 	device_reset(dev);

I was working on the assumption that any required delay would be a
function of the devices input clocks (or fixed, if the device has some
fixed rate internal clock). If that's true, the API extension you
suggest makes sense to me.

I'm not sure about initially-in-reset. Is it not possible for the driver
to poke the GPIO controller to ensure the GPIOs are in the state
required?

Thanks,
Mark.
