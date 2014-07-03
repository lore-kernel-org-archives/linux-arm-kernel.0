From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 19:46:26 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <4840595.cpHbY6hJKL@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com> <4840595.cpHbY6hJKL@wuerfel>
Message-ID: <20140703184626.GC21086@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 07:15:32PM +0100, Arnd Bergmann wrote:
> On Thursday 03 July 2014 18:13:56 Catalin Marinas wrote:
> > > However, we /do/ need the CP15 barrier instructions as well.  We,
> > > as kernel developers, have omitted to provide a way to tell userspace
> > > whether the CP15 barrier instructions are available, *and* whether
> > > the new barrier instructions are there too.  So, like it or not, it
> > > is /our/ failing as kernel developers that userspace is running into
> > > these issues, and it is /our/ responsibility to make sure that
> > > userspace does not break, irrespective of what path is chosed by
> > > the raw CPU support.
> > 
> > Such barriers currently only require an SCTLR_EL1 bit to be set. But
> > what do we do in future version of the architecture if they are no
> > longer present? I guess we start emulating them (or NAK architectural
> > attempts at removing them, though that's not always successful and on
> > some occasions for good reasons).
> 
> I'd vote for having a kernel option to choose between either leaving the
> bit (a) enabled, or (b) leaving it disabled and putting a nasty warning
> (e.g. WARN_ON_ONCE()) out on the console or (c) printing that warning
> and also aborting the task. There are use cases for all of them.

Great, so now we can argue about what the default behaviour should be. I
vote for (c) :)

> It might be good to have a sysctl control, at least a global one that
> turns all instruction emulation off.

Yeah, and a bunch of stats in sysfs or something.

> > The main argument on this thread is about how far back in the
> > architecture roadmap should the arm64 kernel support/emulate. Do we need
> > to have a plan in place for eventually removing such emulation (like
> > maybe even making the emulation slower and slower)?
> 
> The default answer is "as long as anybody is using it". I had the
> same idea with making it gradually slower but in reality that isn't
> going to help. I think the best option is to make it easy to find
> and debug any application that is using deprecated instructions so
> people stop relying on them, and encourage distros to turn the emulation
> code off as soon as they are ready.

My initial objections when this was posted were primarily driven by not
knowing when we can safely remove a feature. The default position with the
arm64 kernel was not to emulate anything, then we would see whether we ever
had valid users of these features and could consider them on a case-by-case
basis. I still think that was the right thing to do.

However, saying "as long as anybody is using it" is really saying "as long
as anybody is complaining about it being missing". Once we've added
emulation, nobody will ever complain about it being missing, because it
won't be missing. Do you have any ideas about phasing out emulation code
when you don't know if it's used or not?

Will
