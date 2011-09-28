From: johan.palsson@stericsson.com (Johan Palsson)
Date: Wed, 28 Sep 2011 10:32:28 +0200
Subject: [PATCH] ARM: mm: Align bank start to MAX_ORDER_NR_PAGES
Message-ID: <1317198748-17705-1-git-send-email-johan.palsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VM subsystem assumes that there are valid memmap entries from
the bank start aligned to MAX_ORDER_NR_PAGES.

Cc: stable at kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Michael Bohan <mbohan@codeaurora.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Johan Palsson <johan.palsson@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/init.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index cc7e2d8..f8037ba 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -496,6 +496,13 @@ static void __init free_unused_memmap(struct meminfo *mi)
 		 */
 		bank_start = min(bank_start,
 				 ALIGN(prev_bank_end, PAGES_PER_SECTION));
+#else
+		/*
+		 * Align down here since the VM subsystem insists that the
+		 * memmap entries are valid from the bank start aligned to
+		 * MAX_ORDER_NR_PAGES.
+		 */
+		bank_start = round_down(bank_start, MAX_ORDER_NR_PAGES);
 #endif
 		/*
 		 * If we had a previous bank, and there is a space
-- 
1.7.3.2
