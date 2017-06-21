From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 21 Jun 2017 08:34:43 +0200
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170621083907.y3gadsmsoufa5niv@piout.net>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
 <20170621075152.GA15996@amd>
 <20170621083907.y3gadsmsoufa5niv@piout.net>
Message-ID: <20170621063443.GA4862@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > I think tglx had a plan for offsetting the time at some point so 32-bit
> > > > platform can pass 2038 properly.
> > > 
> > > Yes, but there are still quite some issues to solve there:
> > > 
> > >      1) How do you tell the system that it should apply the offset in the
> > >      	first place, i.e at boot time before NTP or any other mechanism can
> > >      	correct it?
> > 
> > I'd not do offset. Instead, I'd select a threshold (perhaps year of
> > release of given kernel?) and
> > 
> > 	if (rtc_time < year_of_release_of_kernel)
> > 	   rtc_time += 0x100000000;
> > 
> > Ok, we'll have to move away from "rtc_time == 0 indicates zero", as
> > seen in some drivers.
> > 
> > >      2) Deal with creative vendors who have their own idea about the 'start
> > >      	of the epoch'
> > 
> > If someone uses different threshold, well, there will be
> > confusion. But only for users that have their rtc set to the past,
> > which is quite unusual.
> > 
> 
> Or not, having an RTC set in the past is actually quite common. I'd find
> it weird to have a new device boot and be set to a date in the future.

...but still better than board stuck in the past, no?

> Also note that the threshold or offset thing may seem like a good idea
> but fails with many RTCs because of how they handle leap years.

Well, you can still convert time from rtc to unix time, then do adjustment
there.

Anyway, I guess it would be cool for rtc drivers to annotate what limits
underlying storage has to the common code, so that we can do fixups once
per class, not once per driver.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
