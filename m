From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 May 2014 11:01:28 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <CAD=GYpYQhJbKOKp_jXefjMHUy-3dWavtoSH2K2tt0XViEP-bEw@mail.gmail.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com> <20140423160216.GC2208@arm.com>
 <20140423171727.GK5649@arm.com>
 <CAD=GYpYQhJbKOKp_jXefjMHUy-3dWavtoSH2K2tt0XViEP-bEw@mail.gmail.com>
Message-ID: <20140506100128.GA29270@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 10:33:25PM +0100, Joel Fernandes wrote:
> Hey Will,

Hi Joel,

> On Wed, Apr 23, 2014 at 12:17 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Apr 23, 2014 at 05:02:16PM +0100, Catalin Marinas wrote:
> >> On Wed, Apr 23, 2014 at 10:02:51AM +0100, Will Deacon wrote:
> >> > On Tue, Apr 22, 2014 at 09:30:27PM +0100, Santosh Shilimkar wrote:
> >> > > writel() or an explcit barrier in the driver will do the job. I was
> >> > > just thinking that we are trying to work around the short comings
> >> > > of streaming API by adding barriers in the driver. For example
> >> > > on a non-coherent system, i don't need that barrier because
> >> > > dma_ops does take care of that.
> >> >
> >> > I wonder whether we can remove those barriers altogether then (from the DMA
> >> > cache operations). For the coherent case, the driver must provide the
> >> > barrier (probably via writel) so the non-coherent case shouldn't be any
> >> > different.
> >>
> >> For the DMA_TO_DEVICE case the effect should be the same as wmb()
> >> implies dsb (and outer_sync() for write). But the reason we have
> >> barriers in the DMA ops is slightly different - the completion of the
> >> cache maintenance operation rather than ordering with any previous
> >> writes to the DMA buffer.
> >>
> >> In the DMA_FROM_DEVICE scenario for example, the CPU gets an interrupt
> >> for a finished DMA transfer and executes dma_unmap_single() prior to
> >> accessing the page. However the CPU access after unmapping is done using
> >> normal LDR/STR which do not imply any barrier. So we need to ensure the
> >> completion of the cache invalidation in the dma operation.
> >
> > I don't think we necessarily need completion, we just need ordering. That
> > is, the normal LDR/STR instructions must be observed after the cache
> > maintenance. I'll have to revisit the ARM ARM to be sure of this, but a dmb
> > should be sufficient for that guarantee.
> 
> Just wondering if you were convinced from the ARM ARM that a dsb is
> not required after cache maintenance for the DMA_FROM_DEVICE case?

It's not quite as clear-cut as that. For AArch32, the cache-maintenance
operations (for inner-caches) will be ordered with respect to one another
without the need for additional barriers. Furthermore, ordering is also
guaranteed with respect to normal load/store instructions if the buffer is
mapped as normal-cacheable and accessed via the same VA with which the
maintenance was performed.

For the DMA_FROM_DEVICE case, this then starts to sound pretty good but
there are a couple of spanners thrown into the works (and these have been
discussed earlier in the thread):

  (1) An IMP DEF operation can be required to publish data from the device
      after a completion interrupt is received.

  (2) Outer cache maintenance will require a dsb before (to ensure
      completion of maintenance on the inner caches) and after (to ensure
      completion before accesses to the buffer).

(1) could be solved by either adding a new driver API function or by
piggy-backing on rmb(). (2) could be solved by adding extra barriers to our
outer_cache implementations, but that needs some careful thought to avoid
penalising performance unnecessarily.

Will
