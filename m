From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Mar 2010 14:01:02 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <4BAA017D.70503@warmcat.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<4BA9D93E.50705@warmcat.com>
	<20100324113241.GC5831@opensource.wolfsonmicro.com>
	<4BAA017D.70503@warmcat.com>
Message-ID: <20100324140101.GC26453@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 12:11:41PM +0000, Andy Green wrote:
> On 03/24/10 11:32, Somebody in the thread at some point said:
> >On Wed, Mar 24, 2010 at 09:19:58AM +0000, Andy Green wrote:

> >>Otherwise your suspend and resume ordering turns to crap and you
> >>will immediately be in Hell, for example the PMIC may go down taking
> >>away power from the SD Card before you finished talking to it.

> >This has not been a practical issue in systems - it is very rare to

> You evidently know about GTA02...

Not really, like I said I never really looked at what was going on there
(and the problem was never reported upstream so...).

> >explicitly suspend the regulator part of the PMIC.  Obviously the PMIC
> >suspend will usually involve killing the power to the processor so it is
> >almost always triggered from hardware as part of the processor poweroff
> >after software has halted.

> That doesn't have to follow at all, there are various kinds of
> suspend and it's legal for the PMU to have a policy to turn off
> various assets at the various levels of power saving.  Nor if I
> understood it is regulator API requiring a handshake signal scheme
> from the CPU to manage suspend, it's open how it is done and
> supports regulators and CPUs that don't have that arrangement.

It's not really the regulator API that needs the hardware handshake,
it's the hardware itself.  Everything we've seen thus far either wants
to do something to the core system power rails during suspend mode which
would immediately crash if done while the system is running or doesn't
want to do anything at all, in which case it's just device level stuff
going on which they can deal with.  Either way, the suspend of the PMIC
devices themselves isn't that interesting for sequencing.

At present we don't have any regulators with suspend or resume
operations.

> >The only system I'm aware of which had any stuff like this was the
> >GTA02.  I never investigated to figure out why the code there was doing
> >what it was.

> I wouldn't be so quick to assert that, you do not know all the code
> out there in order to tell.

I really am very sure that nobody has ever reported any issues here -
the only reason I know about the GTA02 is from following development.
There may be non-regulator issues, or there may be unreported issues but
nobody's come forward with those.

Until we have real systems we can look at I'm not really sure it's worth
worrying about since there's a risk of desigining something that doesn't
fit well with what people actually need, and there's always the chance
that something like the device layer will solve the problem before
anyone notices.
