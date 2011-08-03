From: jamie@jamieiles.com (Jamie Iles)
Date: Wed,  3 Aug 2011 16:35:28 +0100
Subject: [PATCH] mm: fix invalid loop for poison_init_mem
Message-ID: <1312385728-27311-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

poison_init_mem() used a loop of:

	while ((count = count - 4))

which has 2 problems - an off by one error so that we do one less word
than we should, and the other is that if count == 0 then we loop forever
and poison too much.  On a platform with HAVE_TCM=y but nothing in the
TCM's, this caused corruption and the platform failed to boot.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 2fee782..91bca35 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -441,7 +441,7 @@ static inline int free_area(unsigned long pfn, unsigned long end, char *s)
 static inline void poison_init_mem(void *s, size_t count)
 {
 	u32 *p = (u32 *)s;
-	while ((count = count - 4))
+	for (; count != 0; count -= 4)
 		*p++ = 0xe7fddef0;
 }
 
-- 
1.7.4.1
