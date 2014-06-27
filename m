From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 18:33:28 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627221744.GU32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
 <20140627215541.GC16724@brightrain.aerifal.cx>
 <20140627221744.GU32514@n2100.arm.linux.org.uk>
Message-ID: <20140627223328.GB17988@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:17:44PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 05:55:41PM -0400, Rich Felker wrote:
> > I think you're assuming that libc is used only as a shared library and
> > that the user installs one appropriate for their kernel. This
> > precludes the use of static-linked binaries which are an extremely
> > important usage case for us, especially on ARM where, for example, we
> > want users to be able to make binaries that have a fully-working libc
> > but that can be run on Android, where neither musl nor any other
> > remotely-working libc is installed by default.
> > 
> > Obviously some (many) users will opt to build libc with a particular
> > -march where all of the necessary instructions for TLS and atomics are
> > available without help from the kernel. However, if attempting to
> > build a baseline libc that works on any model results in one that
> > can't work on new hardware/kernel, that's a big problem, and exactly
> > the one which I'm trying to solve.
> 
> As I've already said, that's a system integrator bug to have a kernel
> without a kuser page with userspace which requires it.
> 
> I think you're are missing one obvious solution to this which you can do:
> you are passed the HWCAP fields in the ELF auxinfo.  This will tell you
> if the CPU has TLS support or not.  If it has TLS support, then you don't
> need to use the kuser helpers, and you know that it is a CPU which is ARM
> architecture v6k or later,

Are you sure? I think the minimum models for TLS and for LDREX/STREX
are different; one is plain v6 and the other is v6k. This greatly
complicates the issue since the kernel only tells you if the TLS
register is available, not if the atomics are. It also doesn't tell
you if the kernel is emulating the hardware features via traps rather
than providing the kuser helper page, which would be a semi-viable
configuration.

> and it has things like the CP15 barrier
> instructions.

No, the CP15 barrier is deprecated and may be removed in futuer chips
(like the SWP instruction was?), so it can't be used unless you know
that you have a pre-DMB machine that needs it.

> If you want to know that the CPU supports the DMB
> instruction rather than the CP15 barrier instruction, then you have to
> check the uname details, or read /proc/cpuinfo (but I'd rather you
> didn't.)

These are not safe operations. /proc may not be mounted, or the file
descriptor table may be full and open may fail, etc.

> In addition, the HWCAP fields tell you about some of the other
> instructions and FP options which are available to you, whether there's
> integer division available, etc.

Yes but for all of those it's safe to assume the lowest baseline. For
TLS and atomics, removal (even optional) of kuser helper page means
it's not safe to assume the lowest baseline; there MUST be a fallback
to use the higher-model-only instructions if the kernel lacks kuser
helper.

Rich
