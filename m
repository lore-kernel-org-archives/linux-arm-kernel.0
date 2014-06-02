From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Jun 2014 12:33:51 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to set_type
In-Reply-To: <53899D21.3000008@redhat.com>
References: <53899D21.3000008@redhat.com>
Message-ID: <20140602103351.GC27722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 11:13:05AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/28/2014 12:33 PM, Maxime Ripard wrote:
> >On Wed, May 28, 2014 at 11:51:52AM +0200, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 05/28/2014 11:36 AM, Maxime Ripard wrote:
> >>>On Tue, May 27, 2014 at 04:18:29PM +0200, Linus Walleij wrote:
> >>>>On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>>>With level triggered interrupt mask / unmask will get called for each
> >>>>>interrupt, doing the somewhat expensive mux setting on each unmask thus is
> >>>>>not a good idea. Instead move it to the set_type callback, which is typically
> >>>>>done only once for each irq.
> >>>>>
> >>>>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>>
> >>>>Yes move it out of mask/unmask but no, not into set_type().
> >>>>
> >>>>Can you not use the irqchip startup()/shutdown() callbacks
> >>>>instead?
> >>>
> >>>I think we can use irq_request_resources then
> >>>https://lkml.org/lkml/2014/3/12/307
> >>
> >>Sounds good, I'll modify the patch to move it here before posting a v2 of
> >>this series. Note v2 likely won't happen till this weekend, -ENOTIME.
> >>
> >>>We could even merge the gpio_to_irq code into it.
> >>
> >>Erm, no we need that as a separate function for the gpio_chip's to_irq
> >>callback.
> >
> >Linus sent a patch stating otherwise a few weeks ago, and was
> >suggesting moving it to irq_startup.
> >
> >https://lkml.org/lkml/2014/5/9/50
> 
> That is not going to work, that patch uses gpiochip_irqchip_add,
> which in turn uses gpiochip_to_irq as to_irq handler, which
> assumes that gpio offset == irq offset, which is not true for
> sunxi-pinctrl.
> 
> Specifically gpio_chio_to_irq does:
> 
> static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
> {
>         return irq_find_mapping(chip->irqdomain, offset);
> }
> 
> Where as the sunxi code does (simplified):
> 
> static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> {
> 	struct sunxi_desc_function *desc = sunxi_pinctrl_desc_find_function_by_pin(pctl, offset, "irq");
> 	return irq_find_mapping(pctl->domain, desc->irqnum);\
> }

Yes, I know it's not going to work, but my point was that gpio_to_irq
might not be called by the drivers, and it's still valid not to do
it. So we might end up with a driver requesting an interrupt that
won't be muxed to it.

But thinking more about it, it would be wrong to remove the .to_irq
callback completely either, since drivers might need a "secondary"
interrupt (like the card detect one for an MMC driver), and a lot of
these use an additional gpio property to do so. So we need to keep it.


Nevermind then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/25fca981/attachment.sig>
