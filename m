From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Wed, 28 Jul 2010 18:18:47 +0530
Subject: [PATCH v3 0/3] Ordered I/O accessors
In-Reply-To: <20100727110310.GA11468@n2100.arm.linux.org.uk>
References: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
	<20100727110310.GA11468@n2100.arm.linux.org.uk>
Message-ID: <20100728124846.GA24466@bnru02.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 27, 2010 at 13:03:10 +0200, Russell King - ARM Linux wrote:
> On Wed, Jul 14, 2010 at 04:01:12PM +0100, Catalin Marinas wrote:
> > This version replaces the do { ... } while (0) constructs in the final
> > patch with ({ ... }) to avoid errors in drivers putting brackets around
> > the write*() accessors. To avoid the write*() macro having a non-void
> > type (and possibly the compiler generating code to read a register), the
> > first patch explicitly casts the __raw_write*() accessors to (void).
> 
> Ok.  Can you please put this in the patch system?  I think we need to
> get this in prior to 2.6.35 being released.

ux500 is using writel() inside uncompress.h, so this series triggers a
build failure there:

  arch/arm/boot/compressed/misc.o: In function `putc':
  arch/arm/mach-ux500/include/mach/uncompress.h:41:
  undefined reference to `outer_cache'

Something like the following needs to be applied to fix it.  I'll submit
this as a separate patch if it can't be folded in.

diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 8552eb1..0271ca0 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -30,22 +30,22 @@
 static void putc(const char c)
 {
 	/* Do nothing if the UART is not enabled. */
-	if (!(readb(U8500_UART_CR) & 0x1))
+	if (!(__raw_readb(U8500_UART_CR) & 0x1))
 		return;
 
 	if (c == '\n')
 		putc('\r');
 
-	while (readb(U8500_UART_FR) & (1 << 5))
+	while (__raw_readb(U8500_UART_FR) & (1 << 5))
 		barrier();
-	writeb(c, U8500_UART_DR);
+	__raw_writeb(c, U8500_UART_DR);
 }
 
 static void flush(void)
 {
-	if (!(readb(U8500_UART_CR) & 0x1))
+	if (!(__raw_readb(U8500_UART_CR) & 0x1))
 		return;
-	while (readb(U8500_UART_FR) & (1 << 3))
+	while (__raw_readb(U8500_UART_FR) & (1 << 3))
 		barrier();
 }
 
