From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Oct 2014 19:03:04 +0100
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141001174714.GD14991@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001174714.GD14991@redhat.com>
Message-ID: <20141001180304.GC5788@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 06:47:14PM +0100, Vivek Goyal wrote:
> On Wed, Oct 01, 2014 at 05:16:21PM +0100, Mark Rutland wrote:
> 
> [..]
> > I'm still rather unhappy about the mechanism by which the DTB is passed
> > by userspace and detected by the kernel, as I'd prefer that the user
> > explictly stated which segment they wanted to pass to the (Linux)
> > kernel, but that would require reworking the kexec syscall to allow
> > per-segment info/flags.
> 
> Why does the running kernel need to know about dtb segment.  I see following.
> 
> ldr     x0, kexec_dtb_addr
> 
> IIUC, we are loading this address in x0. Can't we do something similar
> in user space with purgatory. I mean first jump to purgatory (code
> compiled in user space but runs prviliged) and that code takes care
> of loading x0 with right dtb addr and then jump to final kernel.

I believe the fundamental issue here is a lack of a userspace-provided
purgatory.

I agree that userspace purgatory code could set this up. That would
address my concerns w.r.t. detecting the DTB kernel-side, as there would
be no need. It would also address my concerns with booting OSs other
than Linux, as the purgatory code could do whatever was appropriate for
whatever OS image was loaded.

So in my view, a userspace-provided purgatory that set up the state the
next kernel expected would be preferable. That could be as simple as
setting up the registers and branching -- I assume we'd have the first
kernel perform the required cache maintenance.

Mark.
