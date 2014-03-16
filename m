From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Mar 2014 11:52:07 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
Message-ID: <20140316115207.GW21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 11:02:17AM -0500, Rob Herring wrote:
> On Fri, Mar 14, 2014 at 10:01 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 14, 2014 at 02:48:35PM +0000, Russell King - ARM Linux wrote:
> >> While looking at the now rather horrid L2C-2x0 code, there's some really
> >> serious questions that have to be asked about some of these errata.
> >>
> >> 588369 affects PL310 up to and including R1P0, but is fixed in R2P0.
> >>       This erratum requires a clean+invalidate request to be split into
> >>       a separate clean request followed by an invalidate request.  This
> >>       must be done with the debug register set to 0x03.
> >>
> >>       If the debug register is not set to 0x03, then it's effectively
> >>       a separate clean operation followed by a separate invalidate
> >>       operation.
> >>
> >> 727915 affects PL310 up to and including R3P0, but is fixed in R3P1.
> >>       This erratum concerns writes which may be discarded as a result
> >>       of a clean+invalidate request, particularly when a write hits
> >>       the cache line being requested between the clean stage and the
> >>       invalidate stage.
> >>
> >> Now, let's say that we have a PL310 R3P3 cache.  Linux is configured with
> >> both workarounds enabled.  This has the effect that we never use the
> >> clean+invalidate request.
> >>
> >> However, Rob's patch in 74ddcdb868a8 (ARM: 7608/1: l2x0: Only set
> >> .set_debug on PL310 r3p0 and earlier) has the effect that we no longer
> >> to the debug dance on such a cache.
> >>
> >> This means we're still splitting the clean+invalidate sequence into two
> >> separate operations, so there's room for a write to hit the cache line
> >> between the two operations and, therefore, be lost.
> >>
> >> So, do we actually care about 727915, because through applying Rob's
> >> change, we've effectively re-exposed the problem which this erratum
> >> refers to on all L2 cache controllers where this is actually fixed,
> >> and it's been like this for 14 months without any reported issue.
> >
> > Another point here is... we don't even need 727915 at all: 727915 is
> > about the clean+invalidate by WAY request, not clean+invalidate by PA.
> > So really we should rip out references to this erratum because it's
> > not applicable.
> 
> Is there really no possibility of a write occurring during a
> clean+invalidate by WAY? There is the case where large clean+inv by PA
> uses a clean+inv by WAY. I'd guess this path is fairly rare. We would
> never hit it on highbank because we'd never see a 4MB range and DMA is
> normally coherent. But do the cpu suspend or kexec paths have an
> issue?

To answer this point more fully: clean+invalidate by way is used in
two circumstances:

1. when disabling the cache.  Here, we must be single threaded, with
   interrupts disabled, and any other masters for the other cache
   under control so they don't spit out spurious writes while we're
   disabling it.

   The suspend paths are careful enough: other CPUs have been hot-
   unplugged, devices suspended, and interrupts are disabled at this
   point, so that's safe.

   kexec is slightly different - interrupts will be disabled, we will
   only call outer_cache_disable() if we are the only CPU running at
   soft_restart() time.  However, devices may or may not be suspended
   (which would be an issue for the L2 cache if they're on the coherent
   bus.)  So I think this is as safe as it can be.

   The MCPM stuff is another issue: what the conditions are there I've
   no idea, but it looks like other CPUs will be running when it calls
   outer_cache_flush().  MCPM commentry claims that this will be
   "harmless" and I just had to laugh at that - even with this workaround
   enabled, it doesn't fix the problem on L2C-310 R2P0 as the workaround
   implementation only works on R3P0!

2. on large (>= cache size) coherent DMA allocations via outer_flush_range()

Consider using CMA for framebuffers, and allocating a 1080p framebuffer.
That's going to be around 8MB in size, and that's going to need the L2
purged of any cache lines associated with it.  As the L2 cache is
normally around 512kB or maybe 1MB, walking every 32-byte cache line is
extremely wasteful (that's 259200 clean+invalidate by PA operations, of
which a maximum of 32768 could possibly hit a cache line), so we do want
to preserve the ability to use this operation.

However, one of the issues with background operations is that while the
background operation is in progress, you can't allow another operation
(atomic or background) to be issued - and that includes the sync operation.
L2C-310 issues a slave error in response to this, which will be reported
as an imprecise data abort.

This means that if we do want to avoid this waste, we need some kind of
locking: using a spinlock here is too heavy, I'm thinking about using
a read-write spinlock.  However, that brings with it all the lockdep
baggage with it which we already know we need to avoid, and there's no
raw_ variants of it.

The best idea I can come up with is to directly use the arch_ rw spinlock
variants - the read lock taken for the atomic operations so that many
of them can interleve, and the write lock taken for background operations
as only one can be active at any one time.

Thoughts?

(Note that L2C-210 is slightly more fun: if you try another operation with
a background operation already in progress, it's documented to be ignored -
it's unspecified whether it issues a slave error response.  So you don't
know if you're hitting this condition.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
