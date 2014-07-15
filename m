From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Jul 2014 23:59:28 -0700
Subject: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
In-Reply-To: <53C4A8F5.2000302@ti.com>
References: <53BD0C43.1090002@ti.com> <20140709100914.GL28884@atomide.com>
 <53BD1AF8.2060609@ti.com> <20140709105055.GP28884@atomide.com>
 <53BD1FC3.6050500@ti.com> <20140709110051.GQ28884@atomide.com>
 <53BD2249.2080808@ti.com> <53C3ED02.7020206@ti.com>
 <20140714162324.GF20068@atomide.com> <53C4A8F5.2000302@ti.com>
Message-ID: <20140715065928.GK20068@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [140714 21:09]:
> On Monday 14 July 2014 09:53 PM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [140714 07:47]:
> >>
> >> In my experiments I observed that when RTC regulator is switched
> >> off and switched on, there is an abort while accessing RTC registers.
> > 
> > Right, then you know you have the right regulator :)
>
> Once we switch it off it is expected, but then if it is *switched on*
> it is expected that we should be able to access registers. Here there
> is an abort accessing these registers. 

Most likely you need to also reconfigure the registers or
re-enable the clock or reset it at the interconnect too.

> >> After discussing with hardware team, it is confirmed that this
> >> LDO9 regulator powering RTC cannot be turned off when
> >> SoC is active and expected to be always on.
> > 
> > Hmm but sounds like you already proved it can be idled? So
> > the regulator really should be managed by the driver?
>
> Actually I adapted the driver to support a power regulator.
> Then I observed that if rtc is loaded as  a module there is
> an abort(  which is happening because the regulator is disabled
> once and re-enabled). So when we checked with the hardware team,
> they confirmed that ldo9 should not be disabled. 

Hmm so how is it enabled initially then?

To me it sounds like very standard stuff to reinitialize
a driver for any omap device when waking from suspend or
returning from off-idle. If the RTC device cannot be reset,
idled and re-initialized properly, there's something wrong
with the RTC driver, clocks, regulators, or hwmod data for
that device.

Regards,

Tony
