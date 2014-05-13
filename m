From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 13 May 2014 19:15:05 -0400 (EDT)
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems#
In-Reply-To: <5372998F.6020502@wwwdotorg.org>
References: <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <20140508192209.GH3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
 <20140508205223.GI3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405082058130.980@knanqh.ubzr>
 <20140509091824.GL3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405091245070.980@knanqh.ubzr>
 <20140509182245.GM3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405091640090.980@knanqh.ubzr>
 <CAD=FV=UJK1nSPjH-au-KtbnOZk2nC7usLD8L9neMedj6WHUp8g@mail.gmail.com>
 <CAD=FV=XM2URyJjV9gaE=mrp7LAEGtvi9wQGhGJi3_HYp_XzYWg@mail.gmail.com>
 <5372998F.6020502@wwwdotorg.org>
Message-ID: <alpine.LFD.2.11.1405131908260.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 May 2014, Stephen Warren wrote:

> On 05/13/2014 03:50 PM, Doug Anderson wrote:
> ...
> > ...but then I found the true problem shows up when we transition
> > between very low frequencies on exynos, like between 200MHz and
> > 300MHz.  While transitioning between frequencies the system
> > temporarily bumps over to the "switcher" PLL running at 800MHz while
> > waiting for the main PLL to stabilize.  No CPUFREQ notification is
> > sent for that.  That means there's a period of time when we're running
> > at 800MHz but loops_per_jiffy is calibrated at between 200MHz and
> > 300MHz.
> > 
> > 
> > I'm welcome to any suggestions for how to address this.  It sorta
> > feels like it would be a common thing to have a temporary PLL during
> > the transition, ...
> 
> We definitely do that on Tegra for some cpufreq transitions.

Ouch...  If this is a common strategy to use a third frequency during a 
transition phase, especially if that frequency is way off (800MHz vs 
200-300MHz) then it is something the cpufreq layer must capture and 
advertise.


Nicolas
