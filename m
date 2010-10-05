From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Oct 2010 13:42:41 -0700
Subject: [PATCH v2] Input: Make ADS7846 independent on regulator
In-Reply-To: <20101005203508.7df590db@lxorguk.ukuu.org.uk>
References: <4C862EB3.4080006@compulab.co.il>
	<20100907125335.GD25830@sirena.org.uk>
	<201009091027.18176.marek.vasut@gmail.com>
	<20100909094120.GB1988@rakim.wolfsonmicro.main>
	<4CAACA63.6090202@compulab.co.il>
	<20101005161608.GD19730@core.coreip.homeip.net>
	<20101005164037.GA20555@opensource.wolfsonmicro.com>
	<20101005180703.GD21399@core.coreip.homeip.net>
	<20101005185942.GA22808@opensource.wolfsonmicro.com>
	<20101005203508.7df590db@lxorguk.ukuu.org.uk>
Message-ID: <20101005204241.GB23315@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 05, 2010 at 08:35:08PM +0100, Alan Cox wrote:

> > If the board doesn't use regulators you can just disable the regulator
> > API at which point it compiles out into stubs which report success -
> > this has been the case from day one.  There's only an issue if the board
> > has a regulator configuration which is partially visible to software.

> Which is quite likely on anything complex and means that hardcoding
> regulator assumptions is bad.

When I say "partially visible" I mean where we can't say what's there -
we can cope fine with stuff that isn't software controllable.  The issue
is that we can't automatically discover the system configuration.

> I actually see two ways of attacking that, one is that the dummy
> regulator *and* the compiled in regulator system have a standard
> regulator value that can be passed which means "report success, move
> along nothing to see" that could be passed into drivers, the other is to
> not stick the stuff in drivers.

> I suspect the former may be cleaner ?

I'm afraid I'm having a hard time parsing what you're saying here (what
would a "regulator value" be?), but I suspect that you're trying to
suggest something fairly close to what is already implemented.

The model the regulator API has is that neither the driver for the
regulator nor the driver for the consumer should know anything about the
particular board, with the consumers just requesting the supplies the
device has.  A separate piece of board-specific configuration code
provides a table mapping the physical regulators in the system to the
supplies on the individual chips.  There is an option, currently Kconfig
only, which causes the regulator API to provide a do-nothing dummy
regulator if an attempt is made to request a supply that doesn't exist.
I *think* this dummy regulator corresponds to what you're suggesting
above but like I say I'm having a hard time parsing it.

If the regulator API is compiled out then any attempt to get, enable or
disable a regulator just unconditionally reports success.
