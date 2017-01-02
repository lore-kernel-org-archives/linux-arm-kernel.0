From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jan 2017 12:12:51 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <20161217120707.GA72718@MBP.local>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
 <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
 <20161215113539.GK14217@n2100.armlinux.org.uk>
 <06fca797-da5d-f7f2-eecb-9b1b33b7e83f@arm.com>
 <20161215151548.GL14217@n2100.armlinux.org.uk>
 <c21d6514-44a2-ba88-0fe5-d14d5897cc48@arm.com>
 <20161215185717.GM14217@n2100.armlinux.org.uk>
 <20161217120707.GA72718@MBP.local>
Message-ID: <20170102121250.GA14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2016 at 12:07:11PM +0000, Catalin Marinas wrote:
> On Thu, Dec 15, 2016 at 06:57:18PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 15, 2016 at 03:37:15PM +0000, Marc Zyngier wrote:
> > > And this interface exists for the sole purpose of enabling KVM. Call it
> > > a hypervisor if you wish, but its usefulness is doubtful on its own.
> 
> IMO, the interface between EL1 and EL2 _is_ ABI. However, it should not
> be confused with a *stable* ABI like the one we expose to user. Since
> all users of the EL2 ABI live inside the kernel (either on the EL1 or
> EL2 side), we are free to change it as long as everything is updated
> simultaneously. I don't see this any different from other in-kernel ABI
> like that exposed to loadable modules (for the latter, we have the
> advantage of a partly self-documenting ABI as part of the C language).
> 
> I would welcome some documentation for the EL2 ABI as well, especially
> since head.S and the KVM counterpart is maintained by different people.

Well, it seems that different people within ARM have different opinions
on this subject - that makes it extremely hard to make progress on this.

As you're all local to each other, please can you hash it out amongst
yourselves and come to some sort of concensus!

> > What's also coming clear is that there's very few people who understand
> > all the interactions here, and the whole thing seems to be an undocumented
> > mess.  Something needs to change there - people need to stop shovelling
> > half baked crap into the kernel.  KVM have the privilege of being able to
> > push ARM stuff directly, I now see that was a very big mistake.
> > 
> > So, I want KVM further changes to come through my tree once this merge
> > window is over -
> 
> I'm afraid I strongly disagree. There are a few reasons neither you nor
> me gatekeep the KVM port: (a) the ARM KVM maintainers know a lot more
> about KVM than either of us, (b) the KVM code under arch/arm is reused
> by arm64 and (c) you or I would certainly become a bottleneck. There is
> a lot more to KVM support on ARM than the hyp stub and realistically you
> won't have the time to review all the stuff that comes your way.

I don't think so - in general the statistics for arch/arm/kvm are very
quiet - there's a bigger update once in a while:

v4.1:  8 files changed, 281 insertions(+), 150 deletions(-)
v4.2:  7 files changed, 56 insertions(+), 38 deletions(-)
v4.3:  8 files changed, 59 insertions(+), 41 deletions(-)
v4.4:  6 files changed, 95 insertions(+), 50 deletions(-)
v4.5:  6 files changed, 97 insertions(+), 50 deletions(-)
v4.6:  22 files changed, 1203 insertions(+), 1307 deletions(-)
v4.7:  5 files changed, 351 insertions(+), 262 deletions(-)
v4.8:  9 files changed, 134 insertions(+), 163 deletions(-)
v4.9:  12 files changed, 209 insertions(+), 159 deletions(-)

In terms of number of commits:

v4.1: 17
v4.2: 14
v4.3: 15
v4.4: 13
v4.5: 9
v4.6: 48
v4.7: 18
v4.8: 22
v4.9: 17

So there isn't much going on there.

> > Let's start with some documentation on the KVM hypervisor interfaces on
> > 32-bit ARM.  Documentation/virtual/kvm/hypercalls.txt already contains
> > some for x86, s390 and PPC, so that would be a good place to document
> > the ARM side.  Arguably, that should have already been done.
> 
> I'm all for documenting the interface.
> 
> (even though Will and I co-maintain arch/arm64, I deliberately kept his
> name out of the above as I haven't had the chance to ask for his
> opinion on this matter, which may as well differ)

Well, I started discussing this with Will before I produced the patch,
and Will thought that the ABI was entirely localised within hyp-stub.S.

This is exactly my point: very few people seem to have a proper
understanding of this (as illustrated by the number of different
opinions people appear to hold over various parts of the code), which
makes it very difficult for problems to get fixed.

Either we need more people to have an understanding (so if one of them
gets run over by a bus, we're not left floundering around) or we need
it to be documented - even if it's just a simple comment "the ABI in
this file is shared with XYZ, if you change the ABI here, also update
XYZ too."

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
