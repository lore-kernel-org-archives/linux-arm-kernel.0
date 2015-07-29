From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 29 Jul 2015 08:52:00 +0200
Subject: [PATCH 3/9] gpio: Allow hogged gpios to be requested
In-Reply-To: <20150728091753.GJ28535@localhost>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
 <20150717202702.GK7013@pengutronix.de>
 <20150719140142.GV26287@pengutronix.de>
 <20150728091753.GJ28535@localhost>
Message-ID: <20150729065200.GC30895@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 11:17:53AM +0200, Johan Hovold wrote:
> On Sun, Jul 19, 2015 at 04:01:42PM +0200, Markus Pargmann wrote:
> > Hi Uwe,
> > 
> > On Fri, Jul 17, 2015 at 10:27:02PM +0200, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > On Fri, Jul 17, 2015 at 11:32:44AM +0200, Markus Pargmann wrote:
> > > > It can be useful to claim hogged gpios later, for example from
> > > > userspace. This allows to set defaults for GPIOs using the hogging
> > > > mechanism and override the setup later from userspace or a kernel driver.
> > > > 
> > > > This patch adds a check for hogged gpios to allow requesting them. If
> > > > the gpio is not hogged but marked as requested, it still fails with
> > > > -EBUSY.
> > > > 
> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > ---
> > > >  drivers/gpio/gpiolib.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
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
> 
> IIRC, this use case was discussed but was rejected by Linus when hogs
> were added:
> 
> 	https://lkml.kernel.org/r/CACRpkdZcNcPBYQM438CZJx1gYst9BFBSTj-3Qv2aPGF9pdWa5g at mail.gmail.com

I see. Yes I really would like to have this 'initial settings' feature.
Any suggestions for a better way?

Best regards,

Markus

> 
> Linus?
> 
> Johan
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/9f394a80/attachment.sig>
