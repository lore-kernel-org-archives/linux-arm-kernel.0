From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 19 Jul 2015 16:01:42 +0200
Subject: [PATCH 3/9] gpio: Allow hogged gpios to be requested
In-Reply-To: <20150717202702.GK7013@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
 <20150717202702.GK7013@pengutronix.de>
Message-ID: <20150719140142.GV26287@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, Jul 17, 2015 at 10:27:02PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Jul 17, 2015 at 11:32:44AM +0200, Markus Pargmann wrote:
> > It can be useful to claim hogged gpios later, for example from
> > userspace. This allows to set defaults for GPIOs using the hogging
> > mechanism and override the setup later from userspace or a kernel driver.
> > 
> > This patch adds a check for hogged gpios to allow requesting them. If
> > the gpio is not hogged but marked as requested, it still fails with
> > -EBUSY.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/gpio/gpiolib.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index bf4bd1d120c3..9f402b159cbe 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -798,7 +798,8 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
> >  	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
> >  	 */
> >  
> > -	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
> > +	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0 ||
> > +	    test_and_clear_bit(FLAG_IS_HOGGED, &desc->flags) == 1) {
> >  		desc_set_label(desc, label ? : "?");
> >  		status = 0;
> I don't like this patch. IMHO hogging is a "use" of a GPIO that should
> prevent it being requested.

I disagree with you here. The original patch stated in its description
that it was designed to initialize GPIOs. In my understanding this does
not necessarily mean that a hogged GPIO has to be blocked forever.

It may be a use case for example to initialize multiplexers to known
safe values to work with the system right from the beginning. Later it
may be necessary to change them.

> 
> While I think it's useful to be able to export some hogged pins I don't
> think this should be possible for all hogged pins unconditionally. And
> for gpios being used by drivers I'd expect they don't need to be hogged
> at all.
> 
> I don't have a good idea how to solve that. Adding another property to a
> gpio that should be allowd to be exported can hardly count as hardware
> description and so doesn't belong in a device tree?!
> 
> Please don't consider this objection as a reason for a NACK, only as
> starting point for a discussion.
> 
> Apart from that: Does this result in hogged gpios being able to be
> requested by two additional drivers in parallel? Maybe the IS_HOGGED
> flag should be dropped when the gpio is requested?

The IS_HOGGED flag is cleared at the same time it is tested so only one
consumer can request one hogged GPIO. The GPIO is not considered to be
hogged after it is normally requested.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150719/b22ebe66/attachment.sig>
