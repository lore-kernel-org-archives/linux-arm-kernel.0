From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Feb 2014 14:01:08 +0100
Subject: [PATCH v2 2/2] regulator: core: Replace direct ops->disable usage
In-Reply-To: <20140220125130.GQ2669@sirena.org.uk>
References: <1392894472-11956-1-git-send-email-mpa@pengutronix.de>
 <1392894472-11956-3-git-send-email-mpa@pengutronix.de>
 <20140220125130.GQ2669@sirena.org.uk>
Message-ID: <20140220130108.GD21048@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 09:51:30PM +0900, Mark Brown wrote:
> On Thu, Feb 20, 2014 at 12:07:52PM +0100, Markus Pargmann wrote:
> 
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -1908,8 +1908,6 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
> >  
> >  	trace_regulator_disable_complete(rdev_get_name(rdev));
> >  
> > -	_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> > -			     NULL);
> >  	return 0;
> >  }
> >  
> > @@ -1933,6 +1931,8 @@ static int _regulator_disable(struct regulator_dev *rdev)
> >  				rdev_err(rdev, "failed to disable\n");
> >  				return ret;
> >  			}
> > +			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> > +					NULL);
> >  		}
> >  
> >  		rdev->use_count = 0;
> 
> This change doesn't seem obviously related?

I am using this function from _regulator_force_disable(), which calls
_notifier_call_chain() with one additional flag
"REGULATOR_EVENT_FORCE_DISABLE". To prevent calling
_notifier_call_chain() twice for the force_disable case, I moved that
function call out of _regulator_do_disable().

Regards,

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/e35c4719/attachment.sig>
