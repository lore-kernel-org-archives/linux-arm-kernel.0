From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 16:40:41 +0000
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <6860089.2Ca399bIPK@avalon>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAF6AEGs6dZauq1QxY_OqBPUs0xHYjjGTi+H7Vm-mNvJtmTAHRA@mail.gmail.com>
 <20141210150853.GH23639@arm.com> <6860089.2Ca399bIPK@avalon>
Message-ID: <20141215164041.GN20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 03:49:34PM +0000, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

> On Wednesday 10 December 2014 15:08:53 Will Deacon wrote:
> > On Wed, Dec 10, 2014 at 02:52:56PM +0000, Rob Clark wrote:
> > > so, what is the way for a driver that explicitly wants to manage it's
> > > own device virtual address space to opt out of this?  I suspect that
> > > won't be the common case, but for a gpu, if dma layer all of a sudden
> > > thinks it is in control of the gpu's virtual address space, things are
> > > going to end in tears..
> > 
> > I think you'll need to detach from the DMA domain, then have the driver
> > manage everything itself. As you say, it's not the common case, so you
> > may need to add some hooks for detaching from the default domain and
> > swizzling your DMA ops.
> 
> I'm wondering if it's such an exotic case after all. I can see two reasons not 
> to use the default domain. In addition to special requirements coming from the 
> bus master side, the IOMMU itself might not support one domain per bus master 
> (I'm of course raising the issue from a very selfish Renesas IPMMU point of 
> view).

Do you mean that certain masters must be grouped into the same domain, or
that the IOMMU can fail with -ENOSPC?

For the former, we need a way to represent IOMMU groups for the platform
bus. For the latter, we should have a per-IOMMU default domain instead of
creating one per master as we currently do for ARM.

Joerg has talked about adding a ->get_default_domain callback to the IOMMU
layer, but I've not seen any code and my attempt at using it also got
pretty complicated:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304076.html

Marek also said he might be taking a look.

Will
