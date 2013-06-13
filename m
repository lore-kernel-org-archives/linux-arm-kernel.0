From: rui.zhang@intel.com (Zhang Rui)
Date: Thu, 13 Jun 2013 13:14:44 +0800
Subject: [PATCH] thermal: add imx thermal driver support
In-Reply-To: <20130613041207.GA14259@S2101-09.ap.freescale.net>
References: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
 <1371093177.2135.24.camel@rzhang1-mobl4>
 <20130613041207.GA14259@S2101-09.ap.freescale.net>
Message-ID: <1371100484.2135.55.camel@rzhang1-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-13 at 12:12 +0800, Shawn Guo wrote:
> On Thu, Jun 13, 2013 at 11:12:57AM +0800, Zhang Rui wrote:
> > On Tue, 2013-06-04 at 15:13 +0800, Shawn Guo wrote:
> > > This is based on the initial imx thermal work done by
> > > Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
> > > valid).  Since he is no longer interested in the work and I have
> > > rewritten a significant amount of the code, I just took the authorship
> > > over from him.
> > > 
> > > It adds the imx thermal support using Temperature Monitor (TEMPMON)
> > > block found on some Freescale i.MX SoCs.  The driver uses syscon regmap
> > > interface to access TEMPMON control registers and calibration data, and
> > > supports cpufreq as the cooling device.
> > > 
> > you're using the cpufrq_cooling to throttle cpus at 85C, right?
> 
> Yes.
> 
> > then you should register it as THERMAL_TRIP_PASSIVE instead of
> > THERMAL_TRIP_ACTIVE.
> 
> Yes, literally it should be a passive trip point rather than active
> one.  But I'm not sure if there is any real functional differences
> between them in my thermal case,

well, no, the code for handling passive and active trip point is the
same.
But "passive" and "active" are meaningful for thermal strategy, which
has not been supported so far.
Say, when running on battery, "passive" cooling should be preferred
because it consumes less power, while "active" cooling should be
preferred when running on AC because it provides better performance.

>  except I have to give both
> passive_delay and polling_delay in thermal_zone_device_register()
> call for passive type while it only needs polling_delay for active type
> to work properly.
> 
polling_delay is for systems w/o thermal interrupt.
but passive_delay is used for the condition that the processors are
being throttled.
they have different meanings. Say, you may want to check the temperature
every 30 seconds (polling_delay) in normal condition, but when the
system is overheating, you may need to check the temperature and put the
processors to a lower/higher cooling state every 5 seconds to avoid
1. the fast temperature increment shuts down the system when you just
started to throttle.
2. the rapid temperature decrement leaves the system idle but processors
throttled, for a long time.

> Besides, both exynos and db8500 thermal drivers register active trip
> point while they are using cpufreq as the cooling device.

oh, I did not notice that.
Then that is something needs fixing. you can cook up twp patch for
that. :)

thanks,
rui
