From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 17:15:16 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150415100153.GA11626@localhost>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150415100153.GA11626@localhost>
Message-ID: <2243754.JW5bGY74bP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 11:01:54 Catalin Marinas wrote:
> On Wed, Apr 15, 2015 at 11:18:06AM +0200, Dr. Philipp Tomsich wrote:
> > On 15 Apr 2015, at 00:28, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tuesday 14 April 2015 16:00:34 Catalin Marinas wrote:
> > >> On Tue, Apr 14, 2015 at 04:07:36PM +0200, Arnd Bergmann wrote:
> > >>> For completeness, there is yet another option, which would be to use the
> > >>> exact system call table from arm64 and do all the emulation in user space
> > >>> rather than the kernel. This would however be the least compatible with
> > >>> existing source code, so you probably don't want to do that.
> > >> 
> > >> It would be great if this worked but I think we looked at it before and
> > >> it seems nice until you hit the futex stuff and robust lists (I don't
> > >> fully remember the details). Some of the structures (siginfo) would no
> > >> longer be POSIX compliant and some of them aren't only accessed via libc
> > >> to be able to create shadow copies.
> > > 
> > > Well, that may or may not be acceptable. Aarch64-ilp32 mode is a hack to
> > > enable a very special class of applications, it's not like anyone would
> > > want to run a full system for this and need POSIX compliance.
> > 
> > I strongly disagree on this: ILP32 is a first-class citizen of the ARMv8 
> > ecosystem as a  ?data-model? for AArch64. Having a corresponding Linux 
> > syscall ABI is necessitated because not all data structures shared across
> > the syscall-boundary are describted/defined in data-model agnostic types.
> > ILP32 thus has the same importance as the LP64 ABI in ARMv8. It is thus 
> > neither a hack nor likely/expected to go away anytime soon.
> 
> That's the kind of feedback I've been trying to get from the software
> ecosystem - whether AArch64-ILP32 is a temporary hack for legacy 32-bit
> applications or a solid long term solution for those not needing 64-bit.
> The benchmarks I've seen so far didn't show any significant improvement
> of AArch64-ILP32 over LP64. The comparison with AArch32 may not be
> entirely fair at the moment due to the maturity of AArch64-ILP32
> toolchains but I don't think we'll see a big jump.
>
> The messages I get are mixed, even from companies initially stating the
> need for ILP32. So I can't make an informed decision but I think we
> should go for the safer option: a first class citizen, long term ABI. It
> costs more in (kernel) maintenance initially but if it happens to catch
> on, it will cost us later. The alternative is not to bother with
> AArch64-ILP32 at all, especially if it's going to be used only as a
> marketing exercise for CPUs not supporting AArch32.

Agreed on all this.

> (if anyone has more feedback on commercial needs for ILP32, please let
> us know, even if it is in private)
> 
> > We?ve run full systems (built from buildroot) consisting of ILP32 binaries
> > only (ok? admittedly gdb was an exception, as we haven?t fixed the fact
> > that someone has assumed sizeof(long) == 8 in some data-structure of
> > the AArch64 backend there) in our verification runs. In fact, it will be very 
> > special classes of applications that will need a 64bit address-space.
> 
> If we are to merge AArch64-ILP32, I'd like to see a full software stack,
> maybe a distro like Debian. Otherwise the kernel code will bit-rot (just
> like it regularly happens with big endian).

I actually don't think this should be a prerequisite. We have too many
dependencies here, and as long as we are debating the exact ABI,
any work that gets put into a full distro support (other than openembedded
etc) would likely be wasted.

> > > We could definitely be pragmatic and do whatever helps get the job
> > > done. That said, it diverges further from what legacy 32-bit applications
> > > expect to see, so this approach will likely make an application port harder,
> > > not easier.
> > 
> > The key question at this point seems to be whether we want to support
> > ?legacy 32-bit applications? (i.e. ones that make assumption that are
> > not covered by the underlying type definitions or specifications) or whether
> > we aim for ?well-formed 32-bit applications?.
> > 
> > To stay with the 'struct timespec?-example, the difference between the 
> > former and the latter would (among others) be that the former might 
> > assume sizeof(long) == sizeof(time_t), whereas the latter is allowed to
> > except that sizeof(long) == sizeof(ts.tv_nsec).
> > 
> > I don?t believe in keeping compatibility for the former type of applications.
> 
> That was one of the initial reasons I heard for AArch64-ILP32. So more
> mixed messages.

Of course you hear different stories from different people, and some of
them might just be asking for things they don't fully understand.

As far as I'm concerned, supporting broken legacy applications in the
*only* reason we should be doing this for. If people are asking for
it "because x86 does it", "for performance" or "because it lines up
nicely with what the toolchain can do", I'm more than happy to ignore
them.

	Arnd
