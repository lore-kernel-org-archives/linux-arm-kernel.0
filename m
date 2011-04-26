From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2011 05:37:46 -0700
Subject: [PATCH] ARM: Fix bad SP address after relocating kernel
In-Reply-To: <20110426085700.GJ16892@atomide.com>
References: <20110420165514.GE10402@atomide.com>
	<alpine.LFD.2.00.1104201318040.24613@xanadu.home>
	<20110421055945.GB13688@atomide.com>
	<20110421104954.GH13688@atomide.com>
	<alpine.LFD.2.00.1104210919070.24613@xanadu.home>
	<alpine.LFD.2.00.1104211711240.24613@xanadu.home>
	<alpine.LFD.2.00.1104212233170.24613@xanadu.home>
	<20110422062843.GA841@atomide.com>
	<alpine.LFD.2.00.1104220959440.24613@xanadu.home>
	<20110426085700.GJ16892@atomide.com>
Message-ID: <20110426123746.GC3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise cache_clean_flush can overwrite some of the relocated
area depending on where the kernel image gets loaded. This fixes
booting on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
(ARM: 6750/1: improvements to compressed/head.S).

Thanks to Aaro Koskinen <aaro.koskinen@nokia.com> for debugging
the address of the relocated area that gets corrupted, and to
Nicolas Pitre <nicolas.pitre@linaro.org> for the other uncompress
related fixes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

I think this is the right fix.. And we don't want to mess with the
ZBOOT_ROM sp address, right?

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -253,6 +253,15 @@ restart:	adr	r0, LC0
 		/* Preserve offset to relocated code. */
 		sub	r6, r9, r6
 
+#ifndef CONFIG_ZBOOT_ROM
+		/*
+		 * Fix sp to use the relocated address in case old sp is
+		 * within the relocated area. Otherwise cache_clean_flush
+		 * will trash some of the relocated area.
+		 */
+		add	sp, r6
+#endif
+
 		bl	cache_clean_flush
 
 		adr	r0, BSYM(restart)
