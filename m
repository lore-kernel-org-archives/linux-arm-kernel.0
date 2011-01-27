From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:59:10 +0000
Subject: [PATCH 04/10] ARM: clcd: use amba_part() to determine if we have a
	PL110 primecell
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRRO-0003mm-Q1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of matching the entire peripheral ID, match against
just the part number using the amba_xxx() macros.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/amba/clcd.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index be33b3a..2e51121 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -212,12 +212,12 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 		break;
 	case 16:
 		/*
-		 * PL110 cannot choose between 5551 and 565 modes in
-		 * its control register
+		 * PL110 cannot choose between 5551 and 565 modes in its
+		 * control register.  It is possible to use 565 with
+		 * custom external wiring.
 		 */
-		if ((fb->dev->periphid & 0x000fffff) == 0x00041110)
-			val |= CNTL_LCDBPP16;
-		else if (fb->fb.var.green.length == 5)
+		if (amba_part(fb->dev) == 0x110 ||
+		    fb->fb.var.green.length == 5)
 			val |= CNTL_LCDBPP16;
 		else
 			val |= CNTL_LCDBPP16_565;
-- 
1.6.2.5
