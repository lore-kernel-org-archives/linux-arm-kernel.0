From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 23:02:53 +0200
Subject: [PATCH 4/9] ARM: SPEAr: conditionalize l2x0 support
In-Reply-To: <1367528578-518090-1-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
Message-ID: <1367528578-518090-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the cache controller implementation is disabled at build time,
we must not call any functions related to it.

arch/arm/mach-spear/built-in.o: In function `spear13xx_l2x0_init':
arch/arm/mach-spear/spear13xx.c:47: undefined reference to `l2x0_init'

Cc: Viresh Kumar <viresh.linux@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/spear13xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 8e7cb45..5403c01 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -35,6 +35,8 @@ void __init spear13xx_l2x0_init(void)
 	 * write alloc and 'Full line of zero' options
 	 *
 	 */
+	if (!IS_ENABLED(CONFIG_CACHE_L2X0))
+		return;
 
 	writel_relaxed(0x06, VA_L2CC_BASE + L2X0_PREFETCH_CTRL);
 
-- 
1.8.1.2
