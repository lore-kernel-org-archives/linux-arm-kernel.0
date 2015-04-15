From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Apr 2015 16:38:00 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2243754.JW5bGY74bP@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150415100153.GA11626@localhost> <2243754.JW5bGY74bP@wuerfel>
Message-ID: <20150415153800.GG22741@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 05:15:16PM +0200, Arnd Bergmann wrote:
> On Wednesday 15 April 2015 11:01:54 Catalin Marinas wrote:
> > On Wed, Apr 15, 2015 at 11:18:06AM +0200, Dr. Philipp Tomsich wrote:
> > > We?ve run full systems (built from buildroot) consisting of ILP32 binaries
> > > only (ok? admittedly gdb was an exception, as we haven?t fixed the fact
> > > that someone has assumed sizeof(long) == 8 in some data-structure of
> > > the AArch64 backend there) in our verification runs. In fact, it will be very 
> > > special classes of applications that will need a 64bit address-space.
> > 
> > If we are to merge AArch64-ILP32, I'd like to see a full software stack,
> > maybe a distro like Debian. Otherwise the kernel code will bit-rot (just
> > like it regularly happens with big endian).
> 
> I actually don't think this should be a prerequisite. We have too many
> dependencies here, and as long as we are debating the exact ABI,
> any work that gets put into a full distro support (other than openembedded
> etc) would likely be wasted.

I agree with this not being a prerequisite for merging ILP32 but at
least a long term plan to do something beyond openembedded, once we
agreed on the ABI and _upstreamed_ the kernel and glibc code. Those
legacy applications will probably need more than glibc to run and it's
likely that people will want to run them in a full AArch64 (LP64)
environment. A simpler approach (to me, I'm not a distro person) would
be to just provide additional ILP32 libs in a multi-lib arm64 distro
like Debian rather than all the packages. As for the compiler, AFAIK
aarch64-linux-gnu-* simply needs an option to build for ILP32.

> > > The key question at this point seems to be whether we want to support
> > > ?legacy 32-bit applications? (i.e. ones that make assumption that are
> > > not covered by the underlying type definitions or specifications) or whether
> > > we aim for ?well-formed 32-bit applications?.
> > > 
> > > To stay with the 'struct timespec?-example, the difference between the 
> > > former and the latter would (among others) be that the former might 
> > > assume sizeof(long) == sizeof(time_t), whereas the latter is allowed to
> > > except that sizeof(long) == sizeof(ts.tv_nsec).
> > > 
> > > I don?t believe in keeping compatibility for the former type of applications.
> > 
> > That was one of the initial reasons I heard for AArch64-ILP32. So more
> > mixed messages.
> 
> Of course you hear different stories from different people, and some of
> them might just be asking for things they don't fully understand.
> 
> As far as I'm concerned, supporting broken legacy applications in the
> *only* reason we should be doing this for. If people are asking for
> it "because x86 does it", "for performance" or "because it lines up
> nicely with what the toolchain can do", I'm more than happy to ignore
> them.

I'm not even debating this for the lack of market feedback. So I tend to
agree with you.

-- 
Catalin
