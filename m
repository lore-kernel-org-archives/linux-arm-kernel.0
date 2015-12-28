From: contact@paulk.fr (Paul Kocialkowski)
Date: Mon, 28 Dec 2015 23:49:23 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <568088B4.6090207@ti.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
Message-ID: <1451342963.14631.13.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milo, thanks for the review,

Le lundi 28 d?cembre 2015 ? 09:56 +0900, Milo Kim a ?crit :
> Hi Paul,
> 
> On 23/12/15 20:56, Mark Brown wrote:
> > On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> >
> >> +	gpio = lp->pdata->enable_gpio;
> >> +	if (!gpio_is_valid(gpio))
> >> +		return 0;
> >> +
> >> +	/* Always set enable GPIO high. */
> >> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> >> +	if (ret) {
> >> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> >> +		return ret;
> >> +	}
> >
> > This isn't really adding support for the enable GPIO as the changelog
> > suggests, it's requesting but not managing the GPIO.  Since there is
> > core support for manging enable GPIOs this seems especially silly,
> > please tell the core about the GPIO and then it will work at runtime
> > too.
> >
> 
> With reference to my previous mail, external GPIOs for LDO3 and BUCK2 in 
> LP8725 can be specified through regulator_config.ena_gpio. BUCK2 only 
> can be controlled by external pin when CONFIG pin is grounded.
> 
> Please see the description at page 5 of the datasheet.
> 
> 	http://www.ti.com/lit/ds/symlink/lp8725.pdf

After reading the datasheets thoroughly, it seems to me that for the
lp8720, the EN pin is used to enable the regulators output, which is a
good fit for the core regulator GPIO framework, as there is no reason to
keep it on when no regulator is in use. The serial interface is already
available when EN=0 and regulators can be configured in that state. The
lp8725 seems seems to behave the same when CONFIG=0 (the datasheet
clearly states: "CONFIG=0: EN=1 turns on outputs or standby mode if
EN=0"). On the other hand, it is indeed used as a power-on pin when
CONFIG=1.

Since my intent here is to cover the lp8720 use case, I suggest that we
implement this using the core regulator GPIO framework (I have patches
ready for that) and leave out the case where CONFIG=1, which could be
dealt with later by providing that piece of information via platform
data (and devicetree) and then either use the regulator GPIO framework
(when CONFIG=0 and default) or register the GPIO within the driver and
keep it on at all times (when CONFIG=1).

I could most certainly implement that behaviour, but I'd rather leave it
to someone else (or at least the testing) since I don't have any lp8725
to play with.

What do you think?

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151228/58a457bc/attachment.sig>
