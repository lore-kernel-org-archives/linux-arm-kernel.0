From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 25 Jul 2014 16:40:56 +0100
Subject: [PATCH 4/5] [SCSI] Do not use platform_bus as a parent
In-Reply-To: <1406299616.1789.13.camel@jarvis.lan>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-4-git-send-email-pawel.moll@arm.com>
 <1406299616.1789.13.camel@jarvis.lan>
Message-ID: <1406302856.17726.18.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 15:46 +0100, James Bottomley wrote:
> On Fri, 2014-07-25 at 15:23 +0100, Pawel Moll wrote:
> > The host devices without a parent were "forcefully adopted"
> > by platform bus. This patch removes this assignment. In
> > effect the dev_dev may be NULL now, which means ISA.
> > 
> > Cc: James E.J. Bottomley <JBottomley@parallels.com>
> > Cc: linux-scsi at vger.kernel.org
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> > 
> > This patch is a part of effort to remove references to platform_bus
> > and make it static.
> > 
> > James, could you please have a look and advice if the change is
> > correct? Would you happen to know the "real reasons" behind
> > using the root platform_bus device a parent?
> 
> Yes, for DMA purposes, the parent cannot now be NULL; we'll get a panic
> in the DMA transfers if it is.  

That's what I though at the beginning as well, but then I crawled
through get_dma_ops(struct device *dev) and it seems that on most
architectures (all but two, if I remember correctly) it will return a
default set of DMA ops if the dev == NULL, eg.

static inline struct dma_map_ops *get_dma_ops(struct device *dev)
{
#ifndef CONFIG_X86_DEV_DMA_OPS
        return dma_ops;
#else
        if (unlikely(!dev) || !dev->archdata.dma_ops)
                return dma_ops;
        else
                return dev->archdata.dma_ops;
#endif 
}

in arch/x86/include/asm/dma-mapping.h. Now, there seem to be only a
handful of places where dev_dma is dereferenced: scsi_dma_map and
scsi_dma_unmap in drivers/scsi/scsi_lib_dma.c, where all the calls seem
to be "NULL resistant" and __scsi_alloc_queue in __scsi_alloc_queue
which will oops as you said.

Anyway, if you are saying that dev_dma must not be NULL at any
circumstances, I'll either have to find some kind of replacement for
platform_bus or convince Greg that platform_bus must not be made
static ;-)

> A lot of the legacy ISA device on x86
> and I thought some ARM SOC devices don't pass in the parent device, so
> we hang them off a known parent.

That's another thing I'm not sure - once assigned, is the dma_dev
related to the parent in any way? Even more - is the shost_gendev.parent
used at all? Doesn't seem to be. If it's only about a place in the
device model hierarchy, leaving parent as NULL will make such device a
virtual one, which it probably should be...

Pawe?
