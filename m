From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 1 Oct 2014 06:02:14 -0500
Subject: [PATCH] arm: socfpga: fix fetching cpu1start_addr for system with >
 2GB of ram
Message-ID: <1412161334-12359-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

When CPU1 is brought out of reset, it's MMU is not turned yet, so it will only
be able to use physical addresses. For systems with 1GB or less, clearing
0x40000000 will work just fine. However for systems with 2GB or more, we
need to clear at least 0x80000000.

Essentially, the bic instruction is converting the cpu1start_addr from a
virtual to a physical address. We should be using bic 0xf0000000 for all
systems.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/headsmp.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 95c115d..d686f99 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -16,9 +16,8 @@ ENTRY(secondary_trampoline)
 	movw	r2, #:lower16:cpu1start_addr
 	movt  r2, #:upper16:cpu1start_addr
 
-	/* The socfpga VT cannot handle a 0xC0000000 page offset when loading
-		the cpu1start_addr, we bit clear it. Tested on HW and VT. */
-	bic	r2, r2, #0x40000000
+	/* convert cpu1start_addr to a physical address */
+	bic	r2, r2, #0xf0000000
 
 	ldr	r0, [r2]
 	ldr	r1, [r0]
-- 
2.0.3
