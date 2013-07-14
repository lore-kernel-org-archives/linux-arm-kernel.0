From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jul 2013 14:13:21 +0100
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <CAKv+Gu-fUNSZaNMgZekoCX2kOGEFDLKY1yFtKq1=yp9xQN3rOA@mail.gmail.com>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey> <loom.20130714T130546-799@post.gmane.org>
 <CAKv+Gu-fUNSZaNMgZekoCX2kOGEFDLKY1yFtKq1=yp9xQN3rOA@mail.gmail.com>
Message-ID: <20130714131320.GS24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 01:37:44PM +0200, Ard Biesheuvel wrote:
> On 14 July 2013 13:19, Harm Hanemaaijer <fgenfb@yahoo.com> wrote:
> > Dr. David Alan Gilbert <gilbertd <at> treblig.org> writes:
> >>
> >> Maybe neon is worth a try these days (although be careful of platforms
> >> like Tegra 2 that doens't have it); there was a recent patch that enabled
> >> use in the kernel (I think for some RAID use). The downside is it's
> >> supposed to be quite power hungry.
> >>
> >
> > As it turns out, NEON isn't too hard to implement. I have added NEON support
> > to copy_page, memset, memzero, and memcpy (both for the aligned and unaligned
> > case) in my userspace testing environment. It gives a nice boost (ranging
> > from 10% for copy_page to >30% for unaligned memcpy on a Cortex A8), which
> > can potentially be more on other cores. Although I have not tested a live
> > kernel yet, it looks like NEON can be used fairly transparently #ifdefed on
> > the CONFIG_NEON kernel definition as long as only the lower end of the
> > NEON/vfp register file is clobbered (although this needs verification).
> >
> 
> You will clobber the userland NEON contents of the register file if
> you don't preserve them properly. Also, kernel preemption (if enabled)
> may put your task to sleep at any time, and the context switching
> machinery is totally oblivious of NEON being used in the kernel, so
> the kernel side will get corrupted as well in this case.

The other issue is - not every ARMv7 core has Neon, so this is going
to have to be something that is selected at runtime - which means
indirecting every memcpy/memset through a function pointer.

The final point is, don't forget that gcc will generate implicit calls
to memset/memcpy, and neon won't be available early in the kernel boot,
so you can't optimize those function pointers away.
