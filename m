From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:22:00 +0200
Subject: [PATCH 11/11] ARM: common/vic: use proper __iomem annotations
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1317496920-7764-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In vic_init, we pass addr into readl, so it needs to be a
pointer, not a u32 address.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/common/vic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7aa4262..adccf6d 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -347,7 +347,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 
 	/* Identify which VIC cell this one is, by reading the ID */
 	for (i = 0; i < 4; i++) {
-		u32 addr = ((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
+		void __iomem *addr;
+		addr = (void __iomem *)((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
 		cellid |= (readl(addr) & 0xff) << (8 * i);
 	}
 	vendor = (cellid >> 12) & 0xff;
-- 
1.7.5.4
