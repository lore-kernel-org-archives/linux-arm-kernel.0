From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Apr 2012 18:08:12 +0100
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <20120402214614.GK24211@n2100.arm.linux.org.uk>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
 <20120402200034.GL5812@mwesterb-mobl.ger.corp.intel.com>
 <20120402214614.GK24211@n2100.arm.linux.org.uk>
Message-ID: <20120403170812.GR17741@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 10:46:14PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 02, 2012 at 11:00:34PM +0300, Mika Westerberg wrote:
> > Anyway it looks like handle_IRQ() enables interrupts when it is finished with
> > the current interrupt which then causes hw to interrupt second time resulting
> > failure in case of ep93xx.
> 
> Soft IRQ processing in the irq exit path will enable interrupts, and
> this is probably where the problem is showing up.
> 
> You've identified an important difference between the level 1 interrupt
> controller handlers and the chained handlers, and I suggest that folk
> re-implement their level 1 interrupt handlers in the same way as the
> assembly code was: re-read the interrupt register each time round the
> loop.

I'm also seeing this on the Versatile AB, with spurious interrupts reported
from eth0.

As you suggested, re-reading the VIC status solves the problem:


diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index dcb004a..cb6b49a 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -441,11 +441,9 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
        u32 stat, irq;
        int handled = 0;
 
-       stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
-       while (stat) {
+       while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
                irq = ffs(stat) - 1;
                handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
-               stat &= ~(1 << irq);
                handled = 1;
        }


Will
