From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 5 Jul 2014 12:14:07 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704132250.A2447C40ADD@trevor.secretlab.ca>
References: <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703174318.GE28175@arm.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
Message-ID: <20140705111406.GA23692@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 02:22:50PM +0100, Grant Likely wrote:
> On Thu, 3 Jul 2014 18:43:18 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:
> > > So, no. I completely reject any notion that breaking existing apps is
> > > okay. If we're going to say that v8 still supports 32-bit apps, then
> > > it has to be all of v7, not just the 'good' bits. Nor do I think
> > > saying "it's just a bunch of games" justifies anything. We're kernel
> > > engineers. Applications are applications and we don't break userspace.
> > > Period.
> > 
> > Here you need to define user-space. OABI?
> 
> This is where we can be pragmatic. Listen to our users. Colin was very
> clear about what some apps need in order to keep working. He's not even
> asking for old kernels or system libraries to be supported because he
> has control over those components and they can be fixed. The important
> ABI is the ABI used by Android applications.
> 
> We can drop ABIs that nobody uses. If nobody complains, is it really
> broken?

OK, so I think we now agree that being asked not to break the ABI ever
is not feasible (and not in the community's interest either; think about
carrying over NWFPE for ARMv8 just because someone wants to run an old
distro when there are alternatives already, such requests would need
proper justification).

Another aspect is that users don't always know what's good (or bad) for
them. EABI provided means via kuser helpers to use arch-independent
barrier code and cmpxchg. Glibc and various threads libraries moved to
using them but as we can see, not all user space. As Russell pointed
out, we failed to raise the SWP issue properly in the ARMv7 kernel (more
warnings, always emulation) and I see this as a valid reason to allow
for a _transition_ period in ARMv8.

But we have to agree on a way to handle deprecated/removed architecture
features (as I said, some of them are removed for good reasons). And
that's also for user's benefit, performance wise they should rather use
native than emulated features.

The timeline I propose would be:

1. Architecture feature deprecation (still present, no way to disable)
   - In Linux we need to find ways and push for alternatives to be
     adopted by user space (like we did with kuser helpers)
2. Architecture feature disabling (still present but needs to be enabled
   explicitly via SCTLR bit)
   - Linux disables the feature by default and provides emulation
     (enabled by default), clear warnings
   - In certain cases, there may be justification to enable the hardware
     feature but certainly not in defconfig nor distro Image builds.
     Otherwise they can't complain that users are still using such
     feature at point 3 below
3. Architecture feature removed
   - Default Linux behaviour changes to SIGILL
   - Emulation could be still available in the kernel but maybe under
     a CONFIG_EXPERT option
4. Eventually remove kernel emulation support entirely (or don't carry
   it over to a new port, though I don't foresee any arm128 ;))

With SWP, we are currently at 3/4 with the counter arguments that 2
wasn't entirely clear to users, so the transition needs to be
carried over for ARMv8 (but I'm against 2 for arm64, 3 is as far as I
would go). Arguably, with CP15 barriers we are at point 2, in which case
if we add them to the arm64 kernel, they should be emulated with clear
warnings (ratelimited).

-- 
Catalin
