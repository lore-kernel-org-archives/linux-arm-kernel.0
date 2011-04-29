From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 10:28:12 +0100
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <20110428233823.GC13104@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110428131538.GA10594@game.jcrosoft.org>
	<1304009792.3081.8.camel@redbox>
	<20110428181502.GE17290@n2100.arm.linux.org.uk>
	<BANLkTimT4dpOKcuMbWOWU4Mz=Uk81642Rw@mail.gmail.com>
	<20110428214632.GQ17290@n2100.arm.linux.org.uk>
	<20110428233823.GC13104@game.jcrosoft.org>
Message-ID: <20110429092812.GA17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 01:38:23AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:46 Thu 28 Apr     , Russell King - ARM Linux wrote:
> > On Thu, Apr 28, 2011 at 10:47:37PM +0200, Andrew Victor wrote:
> > > hi Russell,
> > > 
> > > >> I think it would be cleaner still if the "struct sys_timer" could
> > > >> include a register-base-address field. ?Russell?
> > > >
> > > > That's not really what all platforms want, and with the advent of
> > > > clocksources and clock events, I think the sys_timer thing is mostly
> > > > dead.
> > > 
> > > How would those systems initialize the system-timer?
> > > An "init_timer" method in the machine-description?
> > 
> > I was thinking of an init_timekeeping() callback in the machine record
> > rather than having platforms provide a useless sys_timer structure, and
> > maybe having an ARM generic init_legacy_timekeeping() function for those
> > platforms which still use sys_timer() to put into the init_timekeeping()
> > hook.
> > 
> > I've not really firmed up the idea yet though.
> > 
> > Alternatively, if someone wants to come up with a better way to initialize
> > the clocksource and clock event stuff across all platforms...
> 
> I propose we use early device as I did and Magnus did on SH-Mobile
> 
> we will have a common early param "earlytimer"
> 
> then we register the drivers like this
> 
> early_platform_init("earlytimer", &time_device_driver);
> 
> and in the arm init we just have to do
> early_platform_driver_register_all("earlytimer");
> and call
> early_platform_driver_probe("earlytimer", 1 , 0);
> or let the platform do so as some of them may have more than 1 timer to
> register example on shmobile
> 
> We could also have two init one for soc one for machine
> if (machine_time_init)
> 	machine_time_init()
> else
> 	soc_time_init()
> 
> as the timer is not really is ofen not machine specific but platform specific.
> I see that on shmobile, at91 (3 timers sam9, rm9200, x40), nomadok, and other
> 
> This will simplify timer sharing across architecture such shmobile arm and sh
> for renesas but other vendor get the same issue when they soc on different
> architecture

It doesn't sound like this eliminates anything - it just makes things
more complex.  It seems we _still_ need a callback into the platform
code to execute some kind of initialization, eg calling
early_platform_driver_* with appropriate arguments.  So I'm not sure
what we're saving by effectively breaking the initialization function
out into two separate functions and an early platform driver thing.

It all sounds much more complex to me with very little benefit for the
majority of platforms, and it doesn't seem to change what's required
from core code at all - we still need to provide an initialization
call into platform code at the appropriate time.
