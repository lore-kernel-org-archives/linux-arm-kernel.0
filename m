From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 12:52:19 -0800
Subject: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
	driver
In-Reply-To: <20101202200454.GA27696@manju-desktop>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<1290603110-14119-10-git-send-email-manjugk@ti.com>
	<20101202184419.GR17222@atomide.com>
	<20101202184617.GS17222@atomide.com>
	<20101202184925.GT17222@atomide.com>
	<20101202200454.GA27696@manju-desktop>
Message-ID: <20101202205219.GV17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [101202 11:55]:
> 
> > 
> > Note that even with these three fixes, 5912OSK still fails to
> > boot to init. Maybe something wrong with the framebuffer DMA?
> 
> Not sure. I don't have omap1 board for testing. Patch series is only 
> build tested for omap1.
> 
> Can you pls confirm if OSK5912 boots successfully without this patch
> series?

Yeah boots just fine without these as always.

Anybody care to donate a OSK5912 or similar for the TI guys
for doing quick omap1 boot testing on?
 
> If yes, I will cross verify omap1 changes again.

Found the problem. INT_DMA_LCD is handled in mach-omap1/lcd_dma.c.
In your omap_system_dma_probe we now exit everything if request_irq
fails for one channel. So let's skip INT_DMA_LCD.

Also, you should check the logic in omap_system_dma_probe as it's
not very good handling right now. Note how platform_get_irq_byname
does not free other dma_irqs like after request_irq we do.

With your patches applied up to patch "Convert DMA library into
platform driver" + my three earlie fixes + the following fix
I can now boot OSK5912 and see the penguin on the LCD too.

I suggest you break your series into two where the last patch
in the first series is "Convert DMA library into platform driver".
That way the init related changes are done, and we can merge
those in for testing while you update the rest of the series.

Also, eventually within next few merge cycles we should have:

arch/arm/mach-omap1/dma.c	omap1 specific platform init
arch/arm/mach-omap2/dma.c	omap2+ specific platform init
drivers/dma/omap-dma.c		driver using dmaengine.c

So before continuing beyond "Convert DMA library into platform
driver" in the series, maybe take a quick look at dmaengine
in drivers/dma/ so we don't have to redo tons of things again
later on.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 2 Dec 2010 12:35:02 -0800
Subject: [PATCH] Fix omap_system_dma_probe for omap1 INT_DMA_LCD

We don't want to request it as it's handled by mach-omap1/lcd_dma.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -118,6 +118,7 @@ static struct resource res[] __initdata = {
 		.start  = INT_DMA_CH5,
 		.flags  = IORESOURCE_IRQ,
 	},
+	/* Handled in lcd_dma.c */
 	[7] = {
 		.name   = "6",
 		.start  = INT_DMA_LCD,
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2025,6 +2025,11 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 				ret = dma_irq;
 				goto exit_dma_chan;
 			}
+
+			/* INT_DMA_LCD is handled in lcd_dma.c */
+			if (dma_irq == INT_DMA_LCD)
+				continue;
+
 			ret = request_irq(dma_irq,
 					omap1_dma_irq_handler, 0, "DMA",
 					(void *) (ch + 1));
