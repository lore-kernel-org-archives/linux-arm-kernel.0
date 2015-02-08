From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 8 Feb 2015 10:24:39 +0100
Subject: [PATCHv6 4/5] USB: gadget: atmel_usba_udc: Prepare for IRQ
 single edge support
In-Reply-To: <20150207193723.GA32213@gradator.net>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421945805-31129-5-git-send-email-sylvain.rochet@finsecur.com>
 <20150122181422.1ba305f1@bbrezillon> <54D3A63B.6040209@atmel.com>
 <20150207193723.GA32213@gradator.net>
Message-ID: <20150208102439.5be43f78@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 7 Feb 2015 20:37:23 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Hello Nicolas,
> 
> 
> On Thu, Feb 05, 2015 at 06:19:55PM +0100, Nicolas Ferre wrote:
> > Le 22/01/2015 18:14, Boris Brezillon a ?crit :
> > > On Thu, 22 Jan 2015 17:56:44 +0100
> > > Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> > > 
> > > > -static const struct usba_udc_errata at91sam9g45_errata = {
> > > > +static const struct usba_udc_caps at91sam9g45_caps = {
> > > >  	.pulse_bias = at91sam9g45_pulse_bias,
> > > > +	.irq_single_edge_support = true,
> > 
> > Nope! at91sam9g45 doesn't have this property. You'll have to create
> > another compatible string and capabilities structure
> > ("atmel,at91sam9x5-udc")
> 
> Oops.
> 
> 
> > But still, I don't know if it's the proper approach. The possibility to
> > trigger an IRQ on both edges or a single edge is a capacity of the gpio
> > controller, not the USBA IP. So, it's a little bit strange to have this
> > capability here.
> 
> I agree.

Me too (even if I'm the one who proposed this approach in the first
place ;-)).

> 
> 
> > I don't know if it's actually feasible but trying to configure the IRQ
> > on a single edge, testing if it's accepted by the GPIO irq controller
> > and if not, falling back to a "both edge" pattern. Doesn't it look like
> > a way to workaround this issue nicely? Can you give it a try?
> 
> Tried, it works, but it displays the following message from 
> __irq_set_trigger() [1] during devm_request_threaded_irq(?, 
> IRQF_TRIGGER_RISING, ?) on boards which does not support single-edge 
> IRQ:
> 
> genirq: Setting trigger mode 1 for irq 176 failed (gpio_irq_type+0x0/0x34)
> 
> Is it acceptable ?

IMHO it's not.

> If not, is udc->caps->irq_single_edge_support boolean acceptable ?

Do you mean keeping the current approach ?
If you do, then maybe you can rework a bit the way you detect the GPIO
controller you depends on: instead of linking this information to the
usba compatible string you could link it to the gpio controller
compatible string.

You can find the gpio controller node thanks to your "vbus-gpio"
property: use the phandle defined in this property to find the gpio
controller node, and once you have the device_node referencing the gpio
controller you can match it with your internal device_id table
(containing 2 entries: one for the at91rm9200 IP and the other for the
at91sam9x5 IP).

Another solution would be to add an irq_try_set_irq_type function that
would not complain when it fails to set the requested trigger.

Thomas, I know you did not follow the whole thread, but would you mind
adding this irq_try_set_irq_type function (here is a reference
implementation [1]), to prevent this error trace from happening when
we're just trying a configuration ?

> If not, I am ok to drop the feature, this is only a bonus.

That could be a short term solution, to get this series accepted. We
could then find a proper way to support that optimization.


Best Regards,

Boris

[1]http://code.bulix.org/z4bu9k-87846

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
