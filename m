From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 21 Jun 2017 09:51:52 +0200
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <alpine.DEB.2.20.1706202343120.2157@nanos>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
Message-ID: <20170621075152.GA15996@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I agree with that but not the android guys. They seem to mandate an RTC
> > that can store time from 01/01/1970. I don't know much more than that
> > because they never cared to explain why that was actually necessary
> > (apart from a laconic "this will result in a bad user experience")
> > 
> > I think tglx had a plan for offsetting the time at some point so 32-bit
> > platform can pass 2038 properly.
> 
> Yes, but there are still quite some issues to solve there:
> 
>      1) How do you tell the system that it should apply the offset in the
>      	first place, i.e at boot time before NTP or any other mechanism can
>      	correct it?

I'd not do offset. Instead, I'd select a threshold (perhaps year of
release of given kernel?) and

	if (rtc_time < year_of_release_of_kernel)
	   rtc_time += 0x100000000;

Ok, we'll have to move away from "rtc_time == 0 indicates zero", as
seen in some drivers.

>      2) Deal with creative vendors who have their own idea about the 'start
>      	of the epoch'

If someone uses different threshold, well, there will be
confusion. But only for users that have their rtc set to the past,
which is quite unusual.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/7837e096/attachment-0001.sig>
