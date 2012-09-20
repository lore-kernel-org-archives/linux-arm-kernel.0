From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 20 Sep 2012 18:34:32 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <20120920130114.GQ17666@opensource.wolfsonmicro.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
 <1347983056.11116.11.camel@hornet>
 <20120918160909.GA15587@opensource.wolfsonmicro.com>
 <1347987819.11116.38.camel@hornet>
 <20120919022141.GA8832@opensource.wolfsonmicro.com>
 <1348073905.11116.80.camel@hornet>
 <20120920130114.GQ17666@opensource.wolfsonmicro.com>
Message-ID: <1348162472.11116.149.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 14:01 +0100, Mark Brown wrote:
> > Actually before I finally got this mail (our mail system was playing
> > stupid today), I came up with idea of using the power supply specified
> > tolerance as a base to chose the step sizes. This comes down to such
> > code (with the regulator_*_voltage_linear in the ops):
> 
> That's probably OK, though check that the numbers come out sensible
> (people tend to work to nice round numbers).

These calculations try to maximize the range, but in most cases it's
impossible to be exactly in line with constraints. The delta should be
less then 1%, eg. in my test case I get:

A15 Vcore: override max_uV, 1050000 -> 1049990
A15 Vcore: 800 <--> 1049 mV at 906 mV 

I could try to add more math to interpolate the operating points to get
perfect match, but this sounds like a serious overkill...

> > +       if (ret < 0) {
> > +               /* No operating points defined, allow any value within range */
> > +               struct regulation_constraints *constraints =
> > +                               regulator->rdev->constraints;
> > +
> > +               return min_uV >= constraints->min_uV &&
> > +                               max_uV <= constraints->max_uV;
> > +       }
> 
> I'd rather have the driver explicitly say it supports continuous
> voltages with a flag in the descriptor (to make sure we don't end up
> being overly optimistic because the driver wasn't well implemented) 

Ok, so I see two options:

1. Something like bool "regulator_desc.linear"

2. A magic value for regulator_desc.n_voltages, something like
	#define N_VOLTAGES_LINEAR (~0)

Does any of them seem reasonable?

Pawel
