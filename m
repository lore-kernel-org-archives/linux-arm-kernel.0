From: broonie@sirena.org.uk (Mark Brown)
Date: Mon, 31 Aug 2009 21:06:07 +0100
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090831123500.GN29382@infomag.iguana.be>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
	<20090824090407.GA24894@avionic-design.de>
	<20090827202314.GJ29382@infomag.iguana.be>
	<4A96ED32.7000108@billgatliff.com>
	<20090827204448.GL29382@infomag.iguana.be>
	<4A9733C9.9090900@billgatliff.com>
	<20090831123500.GN29382@infomag.iguana.be>
Message-ID: <20090831200606.GB21926@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2009 at 02:35:00PM +0200, Wim Van Sebroeck wrote:

> So if (and I can imagine that certain embedded applications might need
> this) a system is wanted to restart unstable applications, then (for me)
> this means that you want another functionality then what we have now.
> This can be an extension of the current watchdog API, but it's not said
> that this is the best solution.

Given the presentation of the hardware there's a fairly strong
expectation from the user side that the functionality would appear via
the watchdog API.  In common configurations there's a very strong
integration between the less serious watchdog actions and the shutdowns
or resets that they generate so trying to run them via different APIs
would cause issues - each API would want some idea what the other was
doing.

Indeed, one common use of the options that don't cause a hard reset or
shutdown is to extend the length of time that the watchdog can run for -
watchdogs that support this functionality normally take configurable
actions on both of the first two expiries of the watchdog (sometimes
more).  A system might configure the first expiry to generate an
interrupt and only reset the system if the watchdog still hasn't been
updated after another period.  Sometimes the first period will be used
to try to give the system a chance to recover more gracefully than a
hard reset allows but a lot of the time it'll just be ignored so the
watchdog can run for longer before it resets.
