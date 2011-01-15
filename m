From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 14 Jan 2011 23:49:31 -0500 (EST)
Subject: [PATCH] ARM: make head.S less dependent on the compile time
	PHYS_OFFSET define
In-Reply-To: <20110115004449.GU15996@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1101131659220.11803@xanadu.home>
	<20110113232327.GG24149@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101140050070.25804@xanadu.home>
	<20110115004449.GU15996@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101142322580.938@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 15 Jan 2011, Russell King - ARM Linux wrote:

> I've pushed it out under the branch p2v.  I think before this
> goes upstream, "ARM: P2V: Use pv_fixup trick to get physical address"
> needs merging with "ARM: P2V: make head.S use PLAT_PHYS_OFFSET" -
> it doesn't really make sense to fix the same code twice for the same
> underlying problem in the same patch set when it's possible to only
> fix it once.

Indeed.  You probably should fold the following with it as well:

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f5fe0c4..02a7a84 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -26,10 +26,6 @@
 #include <mach/debug-macro.S>
 #endif
 
-#define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
-#define KERNEL_RAM_PADDR	(PLAT_PHYS_OFFSET + TEXT_OFFSET)
-
-
 /*
  * swapper_pg_dir is the virtual address of the initial page table.
  * We place the page tables 16K below KERNEL_RAM_VADDR.  Therefore, we must
@@ -37,6 +33,7 @@
  * the least significant 16 bits to be 0x8000, but we could probably
  * relax this restriction to KERNEL_RAM_VADDR >= PAGE_OFFSET + 0x4000.
  */
+#define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
 #if (KERNEL_RAM_VADDR & 0xffff) != 0x8000
 #error KERNEL_RAM_VADDR must start at 0xXXXX8000
 #endif
@@ -195,10 +192,8 @@ __create_page_tables:
 	/*
 	 * Map some ram to cover our .data and .bss areas.
 	 */
-	orr	r3, r7, #(KERNEL_RAM_PADDR & 0xff000000)
-	.if	(KERNEL_RAM_PADDR & 0x00f00000)
-	orr	r3, r3, #(KERNEL_RAM_PADDR & 0x00f00000)
-	.endif
+	add	r3, r8, #TEXT_OFFSET
+	orr	r3, r3, r7
 	add	r0, r4,  #(KERNEL_RAM_VADDR & 0xff000000) >> 18
 	str	r3, [r0, #(KERNEL_RAM_VADDR & 0x00f00000) >> 18]!
 	ldr	r6, =(_end - 1)
