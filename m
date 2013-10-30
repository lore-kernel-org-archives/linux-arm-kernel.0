From: jhovold@gmail.com (Johan Hovold)
Date: Wed, 30 Oct 2013 12:07:05 +0100
Subject: [PATCH 2/2] misc: atmel_pwm: set initcall level to subsys
In-Reply-To: <20131029232249.GA20476@kroah.com>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
 <1382459560-26596-3-git-send-email-jhovold@gmail.com>
 <20131029232249.GA20476@kroah.com>
Message-ID: <20131030110705.GA29813@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 04:22:49PM -0700, Greg KH wrote:
> On Tue, Oct 22, 2013 at 06:32:40PM +0200, Johan Hovold wrote:
> > Even with the atmel_pwm driver and the atmel-pwm-bl backlight driver
> > supporting deferred probing, we still want to make sure that any
> > pwm-device is available when the backlight devices are probed to avoid
> > any unnecessary delays before enabling the backlight.
> > 
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  drivers/misc/atmel_pwm.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
> > index a6dc56e..0d0f599 100644
> > --- a/drivers/misc/atmel_pwm.c
> > +++ b/drivers/misc/atmel_pwm.c
> > @@ -395,7 +395,17 @@ static struct platform_driver atmel_pwm_driver = {
> >  	 */
> >  };
> >  
> > -module_platform_driver_probe(atmel_pwm_driver, pwm_probe);
> > +static int __init pwm_init(void)
> > +{
> > +	return platform_driver_probe(&atmel_pwm_driver, pwm_probe);
> > +}
> > +subsys_initcall(pwm_init);
> 
> I really hate this type of patch, as it's papering over the real
> problem.  What happens when someone else moves their driver to this
> level?  Then you are back to the original problem.

Yes, it's crude, but it's currently the only way to express a preferred
probe order.

> This is what deferred probing was supposed to fix.  If it doesn't, then
> something else needs to be done, or fix the deferred probing mess...

Deferred probing (the first patch) fixes the dependency problem, but may
introduce delays. I can live with that.

> Sorry, I can't take this.

Fair enough.

Thanks,
Johan
