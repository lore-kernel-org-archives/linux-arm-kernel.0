From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 23 Feb 2016 08:32:35 +0530
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160222101621.4f03ef8b@free-electrons.com>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222032730.GU19598@localhost>
 <20160222101621.4f03ef8b@free-electrons.com>
Message-ID: <20160223030235.GG17690@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 10:16:21AM +0100, Thomas Petazzoni wrote:

> > So why should it depend on how kernel is configured?
> 
> Because using upper_32_bits() on a 32-bits type seems wrong? You can do
> a git grep for CONFIG_ARCH_DMA_ADDR_T_64BIT, and see that it is already
> used in drivers/dma/sh/rcar-dmac.c, drivers/gpu/drm/tegra/dc.c or
> drivers/iommu/tegra-smmu.c.
> 
> drivers/dma/sh/rcar-dmac.c uses it for exactly the same reason as me:
> they need to know if dma_addr_t is 32 bits or 64 bits, and if it's 64
> bits, then they need to take the upper 32 bits and feed them to some
> register.

So is the hardware capable of 32bit of 64bit?


> > You don't want to check the source of interrupt?
> 
> To protect against what? An improper MSI message that ends up firing
> this interrupt for now reason? But only kernel space stuff (or
> privileged code in user-space) can write to the MSI triggering
> registers, so we should be able to trust that such an improper MSI
> message will not arrive.

Your device might go bonkers or some erranious programming does cause
interrupts. Its better to be safe than sorry :)

> 
> That being said, I can add a read of the pending descriptors number,
> and if it's 0, then bail out with IRQ_NONE. Is that what you were
> thinking about?

Sounds good


> > why BUG_ON, is the system unusable after this?
> 
> Well, the XOR engine cannot do XOR with 0 source buffers, or with more
> than MV_XOR_V2_CMD_LINE_NUM_MAX_D_BUF.
> 
> But I see that I'm already setting max_xor in struct dma_device, so one
> can assume that ->prep_dma_xor() will not be called with src_cnt == or
> src_cnt > max_xor, so this BUG_ON can be removed.

Okay, you should return NULL to caller if that is the case

-- 
~Vinod
