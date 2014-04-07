From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Apr 2014 13:13:04 +0100
Subject: [PATCH 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
In-Reply-To: <20140403141533.GP7528@n2100.arm.linux.org.uk>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140403160727.17b3558b@skate>
 <20140403141533.GP7528@n2100.arm.linux.org.uk>
Message-ID: <20140407121304.GD3360@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 03:15:33PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 03, 2014 at 04:07:27PM +0200, Thomas Petazzoni wrote:
> > Any comments about the proposed patches? These are important for the
> > recent Armada 375/38x platforms and I'm sure will require a bit of
> > discussion. Moreover, one of the patch affects the L2 cache driver that
> > Russell is currently working on, so it would be nice if we could get
> > the discussion going soon.
> 
> Will is away for another week and a half.

And when he's back, I'm pretty sure he will be eager to look at the
PL310 code ;)

> There is an important point to be made about the L2 cache though - it is
> not possible to disable the "sync" at the L2 cache - any register write
> automatically invokes a sync before it is actioned, so avoiding the
> explicit sync doesn't stop them from happening, it just reduces the
> number which occur.

I agree, there is no way to disable the "sync". For this particular case
(a system erratum probably, I need to check) you need to make sure you
don't do PL310 and PCIe accesses by the CPU at the same time, otherwise
the system may deadlock.

However, on this Marvell board, the DMA is fully coherent so they don't
need L1 + L2 cache maintenance for such buffers. Due to hardware
coherency, they don't need the outer_sync() either for wmb() etc. So
far, you can treat this as an optimisation.

But the side-effect is that for most run-time operations (apart from
some power management or CPU hotplug) they won't need to touch any PL310
registers at all, and not even the outer_sync() via wmb(). This makes
it (nearly) impossible to hit the system erratum.

I don't remember why the SO memory is still needed for PCIe. I assume to
avoid posted writes but if we avoid PL310 accesses altogether, this may
not be an issue (well, unless the CPU power management code on this
platform needs to flush PL310 explicitly). I'll let you know when I find
out.

-- 
Catalin
