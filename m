From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 19 May 2010 17:45:34 +0100
Subject: Boot interface for device trees on ARM
In-Reply-To: <AANLkTinsOSI_TIc7Jyy4QFuFaS2d-fi0y3LMuITLyG3N@mail.gmail.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005180742500.12758@xanadu.home>
	<AANLkTinsOSI_TIc7Jyy4QFuFaS2d-fi0y3LMuITLyG3N@mail.gmail.com>
Message-ID: <20100519164534.GE1693@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> On Tue, May 18, 2010 at 5:57 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 18 May 2010, Jeremy Kerr wrote:
> >
> >> Hi Nicolas,
> >>
> >> > I think that, for the moment, it is best if the bootloader on already
> >> > existing subarchitectures where DT is introduced still preserve the
> >> > already existing ability to boot using ATAGs. ?This allows for the
> >> > testing and validation of the DT concept against the legacy ATAG method
> >> > more easily.
> >>
> >> Just to clarify - by "still preserve the existing ability to use ATAGs" you
> >> mean only for non-DT boot, right?
> >
> > Exact. ?Once a particular SOC family has no non-DT support anymore (due
> > to being entirely new, or because people get really enthusiastic and
> > fade out legacy machine specific init code completely) then and only
> > then it might be logical to remove ATAG from the concerned bootloaders.
> >
> >
> >> This proposal still does not require ATAG_DEVTREE?
> >
> > No.
> 
> Hmmm...  I misunderstood then.  I don't agree that this is the best way forward.
> 
> Doing it this way means a non-compatible break in the interface.  It
> means that the bootloader needs to know what interface the kernel is
> expecting for boot; information that is not readily available from the
> image type.  The user then needs to tell the boot loader which
> interface to use rather than a backwards compatible addition of a blob
> of data.

Also the other way around: Sometimes you want to install the same
kernel on systems with old and new bootloaders, without touching the
bootloaders (due to that not being powerfail-safe, say).  The kernel
needs to know if it's passed a DT from a newer bootloader or not.

And sometimes you'd like to install a newer, tested kernel (that uses
DTs) on systems with old bootloaders.

> You mention below "shifting the World Order on ARM" and it creating
> resistance for merging DT support.  Isn't this much the same thing as
> it creates a non backwards compatible change in the way bootloaders
> pass data to the kernel.  The cutover in powerpc from the old
> interface to the new caused no end of confusion and people who could
> no longer get their systems to boot.  On PowerPC is was necessary
> because the old method was completely broken, but ATAGs are clean,
> simple and well implemented.

You can't always update the boot loader.  Sometimes you're stuck with
what's there for the life of a device.  Either it's ROM, or it's too
risky to modify in place.

> It also means teaching every boot loader two separate methods for
> booting and exposing those differences to the user.

Embedded devices usually don't have any way for the "user" to choose
from a boot menu ;-)

ATAG_DEVTREE sounds good to me for mix'n'match systems.

New systems that always use DTs could use _just_ ATAG_DEVTREE, to
avoid questions of conflicting info.  They could also settle on a
fixed R1 value meaning "devtree platform".

Or if a fixed "devtree platform" R1 is used, R2 could point directly
at the DT, no atag list in that specific case.

-- Jamie
