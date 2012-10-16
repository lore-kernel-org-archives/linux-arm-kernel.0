From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 16 Oct 2012 15:51:54 +0200
Subject: [PATCH 1/4] leds: leds-ns2: add device tree binding
In-Reply-To: <201210161302.39302.arnd@arndb.de>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <1350315295-14567-2-git-send-email-simon.guinot@sequanux.org>
 <201210161302.39302.arnd@arndb.de>
Message-ID: <20121016135153.GE28384@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 01:02:39PM +0000, Arnd Bergmann wrote:
> On Monday 15 October 2012, Simon Guinot wrote:
> > diff --git a/Documentation/devicetree/bindings/gpio/leds-ns2.txt b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
> > new file mode 100644
> > index 0000000..1a84969
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
> > @@ -0,0 +1,26 @@
> > +Binding for dual-GPIO LED found on Network Space v2 (and parents).
> > +
> > +Required properties:
> > +- compatible: "ns2-leds".
> > +
> > +Each LED is represented as a sub-node of the ns2-leds device.
> > +
> > +Required sub-node properties:
> > +- cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
> > +- slow-gpio: Slow LED GPIO. See OF device-tree GPIO specification.
> > +
> > +Optional sub-node properties:
> > +- label: Name for this LED. If omitted, the label is taken from the node name.
> > +- linux,default-trigger: Trigger assigned to the LED.
> 
> Hi Simon,

Hi Arnd,

> 
> I'm not overly familiar with the LED subsystem, but isn't this something
> that could be done with the generic gpio-led driver?

Basically, the leds-gpio driver allows to associate one pin to one LED.
It is simple and efficient. The LED can be turned on or off. And using a
platform callback (gpio_blink_set), some hardware timer blink can be
enabled. A very few platforms are using this last callback.

On the ns2 (and other lacie machines), there is three different modes
for the front blue LED: on, off and SATA activity blink. Three different
pins are used to configure the LED. Definitively it is not compatible
with the leds-gpio driver.

> 
> If not, is it possible to extend that driver in a way to make it possible
> and remove the leds-ns2 driver?

At the time I have written the leds-ns2 driver, I have failed to figure
out how to merge it with the leds-gpio driver. I remember I thought that
the best alternative was to add a new platform callback (maybe
sata_blink_set). It _should_ be possible to control "on" and "off" with
a single pin. The other pins could be contained inside the callback.

But there is a problem with this method. It is probably not DT
compliant. Add a new platform or machine hook doesn't fit very well with
the DT target on ARM. I mean remove the board setup files.

Please, let me know your advice.

Simon

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121016/e63b6c2c/attachment.sig>
