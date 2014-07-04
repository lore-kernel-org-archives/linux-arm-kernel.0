From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 22:48:47 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU
 advertises it has exclusives
In-Reply-To: <5774249.oWoI3gS2oa@wuerfel>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel> <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <5774249.oWoI3gS2oa@wuerfel>
Message-ID: <20140704214847.GL21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 10:58:04PM +0200, Arnd Bergmann wrote:
> On Friday 04 July 2014 21:51:44 Russell King - ARM Linux wrote:
> > Hmm, we need guidance from ARM people on that.
> > 
> > There may well be a better way to detect between ARMv6 and ARMv6K, which
> > is given by the architecture spec.  G7.3 of an early DDI0406 says that
> > the MPIDR (mp affinity register) aliases to MIDR for ARMv6, but is of
> > course implemented for ARMv6K.
> > 
> > This seems to be carried through to the latest ARM ARM.  So it seems
> > this would be a more correct way to tell ARMv6 from ARMv6K.
> > 
> > If so, we can certainly expand cpu_architecture() to detect between the
> > two and add a CPU_ARCH_ARMv6K in there.
> > 
> > Let's see what Will has to say about that when he's next around...
> > though I think it'll require another trawl through lots of
> > documentation.
> 
> I was thinking of a simpler check in __get_cpu_architecture, just
> checking if the CPUID is ARM1136r0 since that is the only ARMv6
> CPU core we support. Anything else that we currently report as
> ARMv6 is actually ARMv6K.

I'm not prepared to use that as the basis for detecting between V6 and
V6K at the moment - we don't know that for sure.  There seems to be
some Samsung platforms which are V6 (at least they don't select V6K).

Either way, this isn't something we should rush into, because it has
the capability to break all sorts of stuff.  For example, merely
deciding to add a CPU_ARCH_ARMv6K results in a change to /proc/cpuinfo
(changing the "CPU architecture:" line) which is a user visible change.

We also have two ways to detect CPU_ARCH_ARMv6 - that needs careful
thought as well.  We also have a number of places which test for
equality with ARMv6, rather than less than or greater-or-equal.

Then there's all the ifdefs on CPU_V6K...

This is not something I want to rush into, and I certainly don't want
to make assumptions such as "ARMv6 === ARM1136 r0" - and I certainly
don't want to get stuck in a corner by making some changes and then
finding out that they're wrong later down the line when we can't then
fix it without more user visible churn.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
