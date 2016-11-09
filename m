From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Nov 2016 22:25:22 +0000
Subject: Summary of LPC guest MSI discussion in Santa Fe
In-Reply-To: <20161109151709.74927f83@t450s.home>
References: <20161103220205.37715b49@t450s.home>
 <20161108024559.GA20591@arm.com> <20161108202922.GC15676@cbox>
 <20161108163508.1bcae0c2@t450s.home> <58228F71.6020108@redhat.com>
 <20161109170326.GG17771@arm.com> <582371FB.2040808@redhat.com>
 <20161109192303.GD15676@cbox> <20161109203145.GO17771@arm.com>
 <20161109151709.74927f83@t450s.home>
Message-ID: <20161109222522.GS17771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 03:17:09PM -0700, Alex Williamson wrote:
> On Wed, 9 Nov 2016 20:31:45 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Nov 09, 2016 at 08:23:03PM +0100, Christoffer Dall wrote:
> > > 
> > > (I suppose it's technically possible to get around this issue by letting
> > > QEMU place RAM wherever it wants but tell the guest to never use a
> > > particular subset of its RAM for DMA, because that would conflict with
> > > the doorbell IOVA or be seen as p2p transactions.  But I think we all
> > > probably agree that it's a disgusting idea.)  
> > 
> > Disgusting, yes, but Ben's idea of hotplugging on the host controller with
> > firmware tables describing the reserved regions is something that we could
> > do in the distant future. In the meantime, I don't think that VFIO should
> > explicitly reject overlapping mappings if userspace asks for them.
> 
> I'm confused by the last sentence here, rejecting user mappings that
> overlap reserved ranges, such as MSI doorbell pages, is exactly how
> we'd reject hot-adding a device when we meet such a conflict.  If we
> don't reject such a mapping, we're knowingly creating a situation that
> potentially leads to data loss.  Minimally, QEMU would need to know
> about the reserved region, map around it through VFIO, and take
> responsibility (somehow) for making sure that region is never used for
> DMA.  Thanks,

Yes, but my point is that it should be up to QEMU to abort the hotplug, not
the host kernel, since there may be ways in which a guest can tolerate the
overlapping region (e.g. by avoiding that range of memory for DMA).

Will
