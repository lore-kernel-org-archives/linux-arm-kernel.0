From: sre@ring0.de (Sebastian Reichel)
Date: Wed, 21 May 2014 23:57:32 +0200
Subject: [PATCH] ARM: OMAP2+: Fix DMA hang after off-idle
In-Reply-To: <20140516210535.GC12881@atomide.com>
References: <20140516210535.GC12881@atomide.com>
Message-ID: <20140521215731.GB26362@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 02:05:35PM -0700, Tony Lindgren wrote:
> Commit 6ddeb6d84459 (dmaengine: omap-dma: move IRQ handling to omap-dma)
> added support for handling interrupts in the omap dmaengine driver
> instead of the legacy driver. Because of different handling for
> interrupts this however caused omap3 to hang eventually after hitting
> off-idle.
> 
> Any of the virtual 32 DMA channels can be assigned to any of the
> four DMA interrupts. So commit 6ddeb6d84459 made the omap dmaengine
> driver to use the second DMA interrupt while keeping the legacy code
> still using the first DMA interrupt.
> 
> This means we need to save and restore both IRQENABLE_L1 in addition
> to IRQENABLE_L0. As there is a chance that the DSP might be using
> IRQENABLE_L2 or IRQENABLE_L3 lines, let's not touch those until
> this has been confirmed. Let's just add a comment to the code for
> now.
> 
> Fixes: 6ddeb6d84459 (dmaengine: omap-dma: move IRQ handling to omap-dma)
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I can confirm the omap3 hang after hitting off-idle and I can
confirm, that this patch fixes the problem.

Tested-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/556404e0/attachment.sig>
