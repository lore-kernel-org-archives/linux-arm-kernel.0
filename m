From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Jun 2011 18:18:42 +0200
Subject: [PATCH 1/2] PWM: add pwm framework support
In-Reply-To: <201106281427.04373.arnd@arndb.de>
References: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
	<1309255368-9775-2-git-send-email-s.hauer@pengutronix.de>
	<201106281427.04373.arnd@arndb.de>
Message-ID: <20110628161842.GK6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 02:27:04PM +0200, Arnd Bergmann wrote:
> On Tuesday 28 June 2011, Sascha Hauer wrote:
> > This patch adds framework support for PWM (pulse width modulation) devices.
> > 
> > The is a barebone PWM API already in the kernel under include/linux/pwm.h,
> > but it does not allow for multiple drivers as each of them implements the
> > pwm_*() functions.
> 
> Hi Sascha,
> 
> This looks very nice.
> I have only trivial comments, except for the suggestion to use idr.
>  
> > +PWM core
> > +M:	Sascha Hauer <s.hauer@pengutronix.de>
> > +L:	linux-kernel at vger.kernel.org
> > +S:	Maintained
> 
> I would add
> 
> F:	drivers/pwm/
> 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > new file mode 100644
> > index 0000000..93c1052
> > --- /dev/null
> > +++ b/drivers/pwm/Kconfig
> > @@ -0,0 +1,12 @@
> > +menuconfig PWM
> > +	bool "PWM Support"
> > +	help
> > +	  This enables PWM support through the generic PWM framework.
> > +	  You only need to enable this, if you also want to enable
> > +	  one or more of the PWM drivers below.
> 
> Remove the comma.
> 
> > +
> > +/*
> > + * The next pwm id to assign. We do not bother to fill gaps which
> > + * occur during dynamic registering/deregistering of pwms, but
> > + * instead assign a uniq id to each new pwm.
>                        unique
> 
> > + */
> > +static int next_pwm_id;
> 
> How about using idr? It provides you a fast lookup and handles giving
> out unique numbers.

Sounds like a good idea, but is idr compatible with the pwmchip_reserve
function below? idr gives no guarantee that the first id is zero, but I
need exactly this to make the ids for the internal PWMs known at compile
time.

(In the longer term it probably makes sense to implement a
pwm_get(struct device *, const char *id) similar to the clk api, I just
wanted to stay compatible to the current PWM API for now)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
