From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Jul 2015 19:06:19 +0100
Subject: Oops at boot after commit 965278dcb8ab... when using split
 memory region
In-Reply-To: <20150701154007.GH2310@leverpostej>
References: <CAGGh5h061qpus=RK-iDyzbc9xG+dJXy8AosuN=aryEVZCPPhtw@mail.gmail.com>
 <20150701144612.GG2310@leverpostej>
 <20150701145354.GL7557@n2100.arm.linux.org.uk>
 <20150701154007.GH2310@leverpostej>
Message-ID: <20150701180618.GI2310@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 04:40:07PM +0100, Mark Rutland wrote:
> On Wed, Jul 01, 2015 at 03:53:54PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jul 01, 2015 at 03:46:12PM +0100, Mark Rutland wrote:
> > > On Wed, Jul 01, 2015 at 03:15:33PM +0100, jean-philippe francois wrote:
> > > > Hi,
> > > 
> > > Hi,
> > > 
> > > > commit 965278dcb8ab0b1f666cc47937933c4be4aea48d, (ARM: 8356/1: mm:
> > > > handle non-pmd-aligned end of RAM) causes my dm3730 based board to
> > > > oops at boot when using a split memory description.
> > > > The kernel command line parameter is :
> > > > mem=55M at 0x80000000 mem=128M at 0x88000000
> > > > 
> > > > If the same board is booted without the mem argument, it boots to userspace.
> > > 
> > > Thanks for the report.
> > > 
> > > Javier reported a similar issue [1], which was somehow fixed by Laura's
> > > patch to update the memblock limit [2,3].
> > > 
> > > I don't yet understand why, but if that works for you it would be an
> > > interesting data point.
> > > 
> > > > Below is the bootlog.
> > > 
> > > Interesting. That blows up a lot later than I'd expect. I'll see if I
> > > can reproduce the issue locally.
> > 
> > Yes, I think we need to understand what's going on here, and what's
> > causing these failures, rather than blindly applying a patch which
> > seems to solve the problem.
> 
> Certainly. I did not mean to imply otherwise.
> 
> Using a similar command line I can reproduce the issue on TC2, getting a
> hang when freeing unused kernel memory. I'm digging into that now.

If I pass mem=56316K at 0${MY_MEM_BASE} (i.e. 55M - 4K), I get hangs with
and without commit 965278dcb8ab. It looks like we have a latent bug when
a bank is insufficiently aligned, and my patch increased that necessary
alignment from 1M to 2M.

I don't yet have a full explanation, and I'm still investigating, but as
far as I can tell the logic in sanity_check_meminfo is sound.

Thanks,
Mark.
