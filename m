From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Mar 2010 11:32:41 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <4BA9D93E.50705@warmcat.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<4BA9D93E.50705@warmcat.com>
Message-ID: <20100324113241.GC5831@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 09:19:58AM +0000, Andy Green wrote:

> Delaying registering devices is only half the problem.  You must
> also correct these device's parent dev to be the PMU's.

> Otherwise your suspend and resume ordering turns to crap and you
> will immediately be in Hell, for example the PMIC may go down taking
> away power from the SD Card before you finished talking to it.

This has not been a practical issue in systems - it is very rare to
explicitly suspend the regulator part of the PMIC.  Obviously the PMIC
suspend will usually involve killing the power to the processor so it is
almost always triggered from hardware as part of the processor poweroff
after software has halted.

It'd be nice to explicitly save and restore the regulator state over
suspend and resume for devices that don't support that natively but
that's mostly orthogonal and mostly just flops out of devices doing
their own management at suspend and resume anyway.

> It would be very good is this was regularized somehow into a
> standard API because it's absolutely a requirement for many boards
> that their devices ARE dependent on PMU as a parent.

The only system I'm aware of which had any stuff like this was the
GTA02.  I never investigated to figure out why the code there was doing
what it was.
