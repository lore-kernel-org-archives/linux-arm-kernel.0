From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Oct 2013 10:33:06 +0200
Subject: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <20131025083951.18675574@ipc1.ka-ro>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
 <20131024151736.GE9044@ulmo.nvidia.com>
 <20131025083951.18675574@ipc1.ka-ro>
Message-ID: <20131025083305.GE19622@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 08:39:51AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Thierry Reding wrote:
> > On Thu, Oct 24, 2013 at 02:42:13PM +0200, Denis Carikli wrote:
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > Cc: Pawel Moll <pawel.moll@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > > Cc: devicetree at vger.kernel.org
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input at vger.kernel.org
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> > > Cc: Eric B?nard <eric@eukrea.com>
> > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > ---
> > > ChangeLog v6->v7:
> > > - One small whitespace cleanup.
> > > - The properties specific to that driver are now prefixed with "ti,".
> > > - The ti,fuzzy property has now better documentation.
> > > ---
> > >  .../bindings/input/touchscreen/tsc2007.txt         |   45 +++++
> > >  drivers/input/touchscreen/tsc2007.c                |  194 +++++++++++++++-----
> > >  2 files changed, 198 insertions(+), 41 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > new file mode 100644
> > > index 0000000..516b63b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > @@ -0,0 +1,45 @@
> > > +* Texas Instruments tsc2007 touchscreen controller
> > > +
> > > +Required properties:
> > > +- compatible: must be "ti,tsc2007".
> > > +- reg: I2C address of the chip.
> > > +- ti,x-plate-ohms: X-plate resistance in ohms.
> > > +
> > > +Optional properties:
> > > +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
> > > +  (see GPIO binding[2] for more details).
> > > +- interrupt-parent: the phandle for the gpio controller
> > > +  (see interrupt binding[1]).
> > > +- interrupts: (gpio) interrupt to which the chip is connected
> > > +  (see interrupt binding[1]).
> > > +- pinctrl-0: Should specify pin control groups used for the gpio
> > > +  (see pinctrl bindings[0]).
> > > +- pinctrl-names: Should contain only one value - "default"
> > > +  (see pinctrl bindings[0]).
> > 
> > Also I haven't seen a response as to why this can't be handled by the
> > GPIO driver. Adding Linus Walleij, perhaps he knows a more definitive
> > answer.
> > 
> > Linus, the issue here is that the pinctrl properties for this chip are
> > supposed to pinmux the pendown GPIO for this chip. I was under the
> > impression that this should be handled by the GPIO controller itself, so
> > that when gpio_request() was called on a pin it would be the GPIO
> > controller driver's responsibility to pinmux it appropriately.
> > 
> When a GPIO is requested the GPIO layer cannot know what it is
> requested for and how the pinmux for the pin function should be
> configured (pullups, drive strength, ...). A pin may have multiple
> functions depending on what modules are plugged into a baseboard.

But GPIO is one specific function of a given pin, isn't it?

> Thus the pinctrl binding needs to be with the driver that uses the pin.

I wonder if this really needs to be dynamically configured depending on
the driver. Properties like pullups and driver strength can potentially
harm hardware when they're wrong, so relying on the driver's probe to
configure them correctly doesn't sound very safe. It's always possible
to disable the device (either via modifying the DTS or by having the
bootloader patch it). That means the driver won't be probed at all, and
therefore none of the pinctrl or pinmux settings will be applied.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/d64703ea/attachment-0001.sig>
