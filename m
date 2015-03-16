From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Mar 2015 10:37:42 +0800
Subject: [PATCH 02/10] ARM: zx: add low level debug support
In-Reply-To: <20150315224817.GC8656@n2100.arm.linux.org.uk>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-3-git-send-email-jun.nie@linaro.org>
 <20150315224817.GC8656@n2100.arm.linux.org.uk>
Message-ID: <20150316023740.GH20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 15, 2015 at 10:48:18PM +0000, Russell King - ARM Linux wrote:
> On Sat, Mar 14, 2015 at 07:49:37PM +0800, Jun Nie wrote:
> > Use the UART0 peripheral for low level debug. Only the UART port 0 is
> > currently supported.
> 
> None of this code is necessary - in fact, you don't have to add one line
> of assembly code what so ever.
> 
> We have generic PL011 debug support.  Please use that, you only need to
> ensure that the phys and virtual addresses are properly configured in
> arch/arm/Kconfig.debug and that the appropriate symbol is selected.

For some reason we never understood, ZTE designers chose to use a
different offset on Data and Flag register, which make it difficult to
reuse pl01x.S.

/* Data read or written from the interface. */
#define UART01x_DR	0x00
#define ZX_UART01x_DR	0x04

/* Flag register (Read only). */
#define ZX_UART01x_FR	0x14
#define UART01x_FR	0x18

We chose to duplicate the file to avoid churning generic pl01x.S.  Would
something like below be acceptable?  Or any better idea?

diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index 92ef808a2337..da83512c4788 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -12,6 +12,13 @@
 */
 #include <linux/amba/serial.h>
 
+#ifdef CONFIG_ARCH_ZX
+#undef UART01x_DR
+#undef UART01x_FR
+#define UART01x_DR     0x04
+#define UART01x_FR     0x14
+#endif
+
 #ifdef CONFIG_DEBUG_UART_PHYS
                .macro  addruart, rp, rv, tmp
                ldr     \rp, =CONFIG_DEBUG_UART_PHYS


Shawn
