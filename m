From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 23:54:45 +0100
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <CALCETrUvPV0xmw1jCVdwJ8KW3HMW8JKoCRnHcUyuU-1ze=6X8A@mail.gmail.com>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
 <CALCETrUvPV0xmw1jCVdwJ8KW3HMW8JKoCRnHcUyuU-1ze=6X8A@mail.gmail.com>
Message-ID: <20140627225445.GV32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 03:25:32PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 27, 2014 at 3:17 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jun 27, 2014 at 05:55:41PM -0400, Rich Felker wrote:
> >> I think you're assuming that libc is used only as a shared library and
> >> that the user installs one appropriate for their kernel. This
> >> precludes the use of static-linked binaries which are an extremely
> >> important usage case for us, especially on ARM where, for example, we
> >> want users to be able to make binaries that have a fully-working libc
> >> but that can be run on Android, where neither musl nor any other
> >> remotely-working libc is installed by default.
> >>
> >> Obviously some (many) users will opt to build libc with a particular
> >> -march where all of the necessary instructions for TLS and atomics are
> >> available without help from the kernel. However, if attempting to
> >> build a baseline libc that works on any model results in one that
> >> can't work on new hardware/kernel, that's a big problem, and exactly
> >> the one which I'm trying to solve.
> >
> > As I've already said, that's a system integrator bug to have a kernel
> > without a kuser page with userspace which requires it.
> 
> Shouldn't the goal be to reduce the number of new userspace programs
> that require a kuser page on TLS-capable hardware?  In 2012, I made an
> effort to do exactly that on x86_64 wrt the vsyscall page, and, these
> days, a system booted with vsyscall=none is likely to be fully
> functional as long as vdso=0 isn't specified.  Hopefully, in a couple
> of years, even vdso=0 vsyscall=none will work with all freshly-built
> binaries.

You mean like running Ubuntu 14.04 (which is built for ARMv7 hard
float) does not require the kuser page for anything.  Ubuntu 12.04
needing it was rather unexpected; that came down to a glibc
configuration error.

Fedora doesn't support anything before ARMv6, but they also provide
ARMv7 optimised packages as well, and it's highly likely that the
ARMv7 packages don't need the page either.

I believe Android has moved in that direction too.

I don't know whether things like arch or debian have moved in that
direction yet, but I would be very surprised if they haven't.

> > I think you're are missing one obvious solution to this which you can do:
> > you are passed the HWCAP fields in the ELF auxinfo.  This will tell you
> > if the CPU has TLS support or not.  If it has TLS support, then you don't
> > need to use the kuser helpers, and you know that it is a CPU which is ARM
> > architecture v6k or later, and it has things like the CP15 barrier
> > instructions.  If you want to know that the CPU supports the DMB
> > instruction rather than the CP15 barrier instruction, then you have to
> > check the uname details, or read /proc/cpuinfo (but I'd rather you
> > didn't.)
> 
> That sounds helpful.  Would it make sense to try to convince all libc
> providers (and Go!) to do this?

I'm not sure it's worth the effort - as mentioned above, I suspect
most distros have, or are dropping support for the older architectures
which don't provide all the bells and whistles.

> If DMB vs CP15 makes a big difference, then adding that to HWCAP might
> be a good idea.

The CP15 version of the instruction (introduced in ARMv6) has been
deprecated in ARMv7, though we still use the CP15 instruction in the
kernel if we're including support for ARMv6 - we only use the ARMv7
DMB instruction when we're building only for ARMv7 architectures.

Oh, I should also have mentioned: for a libc, if you want to stretch
across from ARMv4 all the way up to ARMv7, then you have to do lots
more than just worry about thread local storage.  You also have the
problem that you can't just fall back on the SWP instruction to
provide atomic implementations - this instruction has been deprecated
and for the latest CPUs, the kernel may be configured to emulate this
instruction.  Besides, on ARMv6 and later, you really want to use the
load/store exclusive instructions for implementing atomic accesses
and not the horrid SWP instruction.  So you need to implement atomic
stuff using SWP for some CPUs and the new load/store exclusive for
other CPUs.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
