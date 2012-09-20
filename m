From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 09:01:15 -0400
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <1348073905.11116.80.camel@hornet>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
 <1347983056.11116.11.camel@hornet>
 <20120918160909.GA15587@opensource.wolfsonmicro.com>
 <1347987819.11116.38.camel@hornet>
 <20120919022141.GA8832@opensource.wolfsonmicro.com>
 <1348073905.11116.80.camel@hornet>
Message-ID: <20120920130114.GQ17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 05:58:25PM +0100, Pawel Moll wrote:
> On Wed, 2012-09-19 at 03:21 +0100, Mark Brown wrote:

> > No, we should provide a way to describe this situation in the API - it's
> > not unreasonable and having to pick step sizes is obviously suboptimal.

> Actually before I finally got this mail (our mail system was playing
> stupid today), I came up with idea of using the power supply specified
> tolerance as a base to chose the step sizes. This comes down to such
> code (with the regulator_*_voltage_linear in the ops):

That's probably OK, though check that the numbers come out sensible
(people tend to work to nice round numbers).

> +       if (ret < 0) {
> +               /* No operating points defined, allow any value within range */
> +               struct regulation_constraints *constraints =
> +                               regulator->rdev->constraints;
> +
> +               return min_uV >= constraints->min_uV &&
> +                               max_uV <= constraints->max_uV;
> +       }

I'd rather have the driver explicitly say it supports continuous
voltages with a flag in the descriptor (to make sure we don't end up
being overly optimistic because the driver wasn't well implemented) but
other than that this looks good.
