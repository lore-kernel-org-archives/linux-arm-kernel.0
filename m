From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 20 Jul 2015 09:51:25 +0200
Subject: [PATCH 3/9] gpio: Allow hogged gpios to be requested
In-Reply-To: <20150720063249.GM7013@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
 <20150717202702.GK7013@pengutronix.de>
 <20150719140142.GV26287@pengutronix.de>
 <20150720063249.GM7013@pengutronix.de>
Message-ID: <20150720075125.GW26287@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 08:32:49AM +0200, Uwe Kleine-K?nig wrote:
> Hello Markus,
> 
> On Sun, Jul 19, 2015 at 04:01:42PM +0200, Markus Pargmann wrote:
> > On Fri, Jul 17, 2015 at 10:27:02PM +0200, Uwe Kleine-K?nig wrote:
> > > On Fri, Jul 17, 2015 at 11:32:44AM +0200, Markus Pargmann wrote:
> > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > index bf4bd1d120c3..9f402b159cbe 100644
> > > > --- a/drivers/gpio/gpiolib.c
> > > > +++ b/drivers/gpio/gpiolib.c
> > > > @@ -798,7 +798,8 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
> > > >  	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
> > > >  	 */
> > > >  
> > > > -	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
> > > > +	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0 ||
> > > > +	    test_and_clear_bit(FLAG_IS_HOGGED, &desc->flags) == 1) {
> > > >  		desc_set_label(desc, label ? : "?");
> > > >  		status = 0;
> > > I don't like this patch. IMHO hogging is a "use" of a GPIO that should
> > > prevent it being requested.
> > 
> > I disagree with you here. The original patch stated in its description
> > that it was designed to initialize GPIOs. In my understanding this does
> > not necessarily mean that a hogged GPIO has to be blocked forever.
> Assume for a moment I can agree with "not necessarily". But now, what
> about the cases where a hogged GPIO should be blocked?
> IMHO, if you want to drive the GPIO from userspace anyhow, you don't
> need to add a hog for it.

If I don't use a hog I leave the system in an undefined state until the
userspace can initialize the GPIOs. So all the userspace controlled
GPIOs are undefined when all the drivers probe which can lead to
problems if the GPIOs have any indirect influence on hardware components
which drivers probe before the userspace.
I think it is valid to somehow define a safe state for GPIOs in the
devicetree while you can later change this state from userspace?!

Best regards,

Markus

> 
> > The IS_HOGGED flag is cleared at the same time it is tested so only one
> > consumer can request one hogged GPIO. The GPIO is not considered to be
> > hogged after it is normally requested.
> You're right here, I missed the and_clear_bit part on the test.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/382d68cd/attachment.sig>
