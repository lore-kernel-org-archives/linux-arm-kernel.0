From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 11:08:41 +0100
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <20110430013658.GC1212@game.jcrosoft.org>
References: <BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110428131538.GA10594@game.jcrosoft.org>
	<1304009792.3081.8.camel@redbox>
	<20110428181502.GE17290@n2100.arm.linux.org.uk>
	<BANLkTimT4dpOKcuMbWOWU4Mz=Uk81642Rw@mail.gmail.com>
	<20110428214632.GQ17290@n2100.arm.linux.org.uk>
	<20110428233823.GC13104@game.jcrosoft.org>
	<20110429092812.GA17290@n2100.arm.linux.org.uk>
	<20110430013658.GC1212@game.jcrosoft.org>
Message-ID: <20110508100841.GE27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2011 at 03:36:58AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> yes we still need a calback to call the early probe
> but just a callback for the init no resume, suspend
> 
> if we want multiple timer early which I do not think is necessarly
> for really early one timer is enough if you need more you can initialise them
> later
> 
> so if we keep this constrain
> 
> in the arm timer init
> early_platform_driver_register_all("earlytimer");
> early_platform_driver_probe("earlytimer", 1 , 0);
> 
> and in the init_early you just need to do
> early_platform_add_devices(devices, nb);
> 
> so it's more generic

I'm still not convinced.  What it seems to be doing is moving from this:

time_init() ->
	system_timer->init() ->
		platform code

to this:

setup_arch() ->
	init_early() ->
		platform code ->
			early_platform_add_devices()
time_init() ->
	early_platform_driver_register_all(),
	early_platform_driver_probe() ->
		early timer probe function (platform code)

which to me just looks a whole lot more complex without benefit.

Platform code still has to make the decision at some point about which
timers are added - in the former case via the system_timer->init()
callback or in the latter case by the init_early() callback.

I can't see how this results in something better, either by simplifing
the code or resulting in any kind of consolidation.  That's backed up
by this patch adding around 230 lines of code.
