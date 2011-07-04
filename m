From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Jul 2011 14:43:18 +0200
Subject: [PATCH 1/3] PWM: add pwm framework support
In-Reply-To: <4E11994B.7070103@gmail.com>
References: <201106301441.24493.arnd@arndb.de>
	<BANLkTin_htv2z3D9Bbf6N8Y7UKFRvPtvOg@mail.gmail.com>
	<20110630170229.GP6069@pengutronix.de> <4E0D0595.5070205@gmail.com>
	<20110701073755.GR6069@pengutronix.de> <4E0D8540.2020200@gmail.com>
	<20110701085414.GV6069@pengutronix.de> <4E0E6916.50406@gmail.com>
	<20110704075556.GD6069@pengutronix.de> <4E11994B.7070103@gmail.com>
Message-ID: <20110704124318.GI6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 08:43:23PM +1000, Ryan Mallon wrote:
> On 04/07/11 17:55, Sascha Hauer wrote:
> > I am tired of discussing this. It seems we can't agree and unless
> > someone else jumps in here we will probably have to wait for another
> > year until something moves in the PWM area.
> 
> If we are going to introduce a new framework for pwms then we should
> create one which meets the needs of at least all of the in kernel
> drivers. This patch series provides no solution for either the atmel or
> ep93xx drivers, so it is not a complete solution. At some point the
> api/framework _must_ be changed. If we can introduce transition layers
> then we should do that now so they we can provide a common framework
> along with some forward thinking about how the other drivers are going
> to be migrated to the new framework. This patch series doesn't even
> migrate _any_ of the existing drivers.
> 
> It doesn't have to be an all or nothing approach. Possibly Bill's series
> is perhaps too involved by changing the api, introducing sysfs support
> and reworking the pwm users. But your series is at the opposite end of
> the spectrum. It does too little. It will take a few release cycles to
> get all of the existing drivers migrated and since we can't change the
> api until that happens the atmel and ep93xx drivers will take longer
> still. At the very least your series should migrate some of the drivers.
> 
> The timeline argument is a bit poor. Yes, there has been discussion for
> a lengthy time about how the pwm api should be developed, but I think
> that is because it is non-trivial to come up with a framework which is
> good enough to support all of the pwm hardware (some of which is already
> in the mainline). Getting something merged now just because it can be
> done quickly is not a good idea if it all has to get reworked in the
> future so that it can support all the hardware.
> 
> The pwm framework needs to incorporate at least the following:
>  - sysfs access (ep93xx driver)

The sysfs interface will likely raise smoe more discussion, that's why I
intentionally have no support for it. It can be added later, but right
now I see no reason why we should add artificial barriers to merge these
patches.

>  - Multiple channels per device (atmel driver)

Again, this can be added later.

> 
> The mxs driver you introduce looks like it could be implemented as a
> single device (continuous mmio space) with multiple channels rather than
> the pwm core/driver approach you have. I also can't see anything in this
> patch set which hooks up the mxs pwms to an actual board (i.e. nothing
> calls mxs_add_mxs_pwm)?

Why should anyone register a device for which no driver is in the tree?

> 
> The other nice things to have for the pwm framework are:
>  - More fine grained control of pwms: pwm_period_ns, period_duty_ns, etc
>  - Polarity control
>  - Synchronisation support for multi-channel devices
>  - Interrupt handler support
>  - Sleeping vs non-sleeping configuration api
> 
> The fine-grained control api could be added now. pwm_config could be
> left as is for the time being (the new api could be a wrapper around it
> to start with). Polarity control and interrupt handling apis could also
> be defined without affecting the drivers which don't need to implement
> them. Multiple channels and the sleeping/non-sleeping api are the more
> difficult ones, but at least having some sort of indication about how
> these plan to be solved would be useful.

Again, why should we add these *now*? It only raises the chance that
there's more discussion.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
