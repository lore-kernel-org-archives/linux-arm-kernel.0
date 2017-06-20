From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 21 Jun 2017 00:00:30 +0200 (CEST)
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170620213507.urobmtg34vzubrdq@piout.net>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
Message-ID: <alpine.DEB.2.20.1706202343120.2157@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jun 2017, Alexandre Belloni wrote:
> On 20/06/2017 at 22:15:36 +0100, Russell King - ARM Linux wrote:
> > On Tue, Jun 20, 2017 at 05:07:46PM +0200, Benjamin Gaignard wrote:
> > > 2017-06-20 15:48 GMT+02:00 Alexandre Belloni
> > > <alexandre.belloni@free-electrons.com>:
> > > >> Yes, that's argument against changing rtc _drivers_ for hardware that
> > > >> can not do better than 32bit. For generic code (such as 44/51 sysfs,
> > > >> 51/51 suspend test), the change still makes sense.
> > > 
> > > What I had in mind when writing those patches was to remove the limitations
> > > coming from those functions usage, even more since they been marked has
> > > deprecated.
> > 
> > I'd say that they should not be marked as deprecated.  They're entirely
> > appropriate for use with hardware that only supports a 32-bit
> > representation of time.
> > 
> > It's entirely reasonable to fix the ones that use other representations
> > that exceed that, but for those which do not, we need to keep using the
> > 32-bit versions.  Doing so actually gives us _more_ flexibility in the
> > future.
> > 
> > Consider that at the moment, we define the 32-bit RTC representation to
> > start at a well known epoch.  We _could_ decide that when it wraps to
> > 0x80000000 seconds, we'll define the lower 0x40000000 seconds to mean
> > dates in the future - and keep rolling that forward each time we cross
> > another 0x40000000 seconds.  Unless someone invents a real time machine,
> > we shouldn't need to set a modern RTC back to 1970.
> > 
> 
> I agree with that but not the android guys. They seem to mandate an RTC
> that can store time from 01/01/1970. I don't know much more than that
> because they never cared to explain why that was actually necessary
> (apart from a laconic "this will result in a bad user experience")
> 
> I think tglx had a plan for offsetting the time at some point so 32-bit
> platform can pass 2038 properly.

Yes, but there are still quite some issues to solve there:

     1) How do you tell the system that it should apply the offset in the
     	first place, i.e at boot time before NTP or any other mechanism can
     	correct it?

     2) Deal with creative vendors who have their own idea about the 'start
     	of the epoch'
	
     3) Add the information of wraparound time to the rtc device which
     	needs to be filled in for each device. That way the rtc_***
     	accessor functions can deal with them whether they wrap in 2038 or
     	2100 or whatever.

#3 is the simplest problem of them :)	

> My opinion is that as long as userspace is not ready to handle those
> dates, it doesn't really matter because it is quite unlikely that
> anything will be able to continue running anyway.

That's a different story. Making the kernel y2038 ready in general is a
good thing. Whether userspace will be ready by then or not is completely
irrelevant.

Thanks,

	tglx
