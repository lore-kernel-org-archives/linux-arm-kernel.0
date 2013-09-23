From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Sep 2013 11:03:00 -0700
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
In-Reply-To: <201309202122.06327@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
 <201309202122.06327@pali>
Message-ID: <20130923180259.GJ2684@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [130920 12:29]:
> On Sunday 08 September 2013 10:50:39 Pali Roh?r wrote:
> > This patch will register bq24150a charger in RX-51 board data.
> > Patch also adding platform function between isp1704 and
> > bq2415x drivers for detecting charger type.
> > 
> > So finally charging battery on Nokia N900 (RX-51) working
> > automatically without any proprietary Nokia bits in userspace.
...
 
> > @@ -277,6 +316,7 @@ static void rx51_charger_set_power(bool
> > on)
> > 
> >  static struct isp1704_charger_data rx51_charger_data = {
> >  	.set_power	= rx51_charger_set_power,
> > +	.set_current	= rx51_charger_set_current,
> >  };

We want to get rid of the platform data callbacks here,
there no longer any need to keep these under arch/arm.

> Tony, can you look and review this board patch?

Yes, looks like this can all be done in the driver nowadays.
You can use drivers/reset for the set_power. Or if it's really
controlling the regulator, then the regulator framework. The
info can be passed in a .dts file for those.

The .set_current you can do in the driver based on the
compatible flag.
 
> I think that this patch series it the most important for Nokia 
> N900, because it finally bringing charging support. And without 
> charging battery it very hard to use phone which has power supply 
> only from battery.

Right, let's get this driver updated to use the device tree
based init and that way this file is no longer needed.
I would like to $ grep -i grandmom ~/.phonebook | call too :)

I forgot how this charger is wired up, but maybe take a
look at commit d7bf353f (bq24190_charger: Add support for TI
BQ24190 Battery Charger) for the DT parts.

Regards,

Tony
