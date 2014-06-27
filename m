From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 17:55:41 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627213051.GS32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627200949.GQ32514@n2100.arm.linux.org.uk>
 <20140627210931.GT23102@port70.net>
 <20140627213051.GS32514@n2100.arm.linux.org.uk>
Message-ID: <20140627215541.GC16724@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 10:30:51PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 27, 2014 at 11:09:31PM +0200, Szabolcs Nagy wrote:
> > i thought the helpers in the kernel can avoid certain memory
> > barriers that the userspace has to do on armv6 for atomics
> > (and those barriers are deprecated on armv7 so i thought the
> > kuser page was better for portable binaries)
> 
> The helpers are provided so that libc can be independent of the CPU
> facilities in the machine.  The key word there is _libc_, not
> applications.
> 
> So, a libc can be built to support the lowest architecture that
> someone deems to support, and it may make use of the kuser helpers.
> If it does, then you have a libc which requires that the kuser
> helpers are always provided by the kernel, and the KUSER_HELPERS
> option must never be disabled.  If it is disabled, then the libc
> will be useless against that kernel.
> 
> However, a libc built against modern architectures should not be
> making use of the kuser helpers.  We found last year that the
> Ubuntu 12.04 glibc did still make use of one kuser helper, and
> as such Ubuntu 12.04 also needs KUSER_HELPERS to remain enabled.
> 
> The last combination is that the libc is built for modern architectures
> without needing any kuser helpers at all.  In this case - and only this
> case - the kernel's KUSER_HELPERS option can be disabled should the
> system integrator want to increase security.

I think you're assuming that libc is used only as a shared library and
that the user installs one appropriate for their kernel. This
precludes the use of static-linked binaries which are an extremely
important usage case for us, especially on ARM where, for example, we
want users to be able to make binaries that have a fully-working libc
but that can be run on Android, where neither musl nor any other
remotely-working libc is installed by default.

Obviously some (many) users will opt to build libc with a particular
-march where all of the necessary instructions for TLS and atomics are
available without help from the kernel. However, if attempting to
build a baseline libc that works on any model results in one that
can't work on new hardware/kernel, that's a big problem, and exactly
the one which I'm trying to solve.

Rich
