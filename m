From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Aug 2013 21:35:33 -0300
Subject: [PATCH] ARM: fiq: Cast the first argument of flush_icache_range()
Message-ID: <1376613333-7021-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 2ba85e7af4 (ARM: Fix FIQ code on VIVT CPUs) causes the following build
warning:

arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
arch/arm/kernel/fiq.c:92:3: warning: passing argument 1 of 'cpu_cache.coherent_kern_range' makes integer from pointer without a cast [enabled by default]
arch/arm/kernel/fiq.c:92:3: note: expected 'long unsigned int' but argument is of type 'void *'

Cast it as '(unsigned long)base' to avoid the warning.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/kernel/fiq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index fc79202..d6515b9 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -89,7 +89,8 @@ void set_fiq_handler(void *start, unsigned int length)
 
 	memcpy(base + offset, start, length);
 	if (!cache_is_vipt_nonaliasing())
-		flush_icache_range(base + offset, offset + length);
+		flush_icache_range((unsigned long)base + offset, offset +
+				   length);
 	flush_icache_range(0xffff0000 + offset, 0xffff0000 + offset + length);
 }
 
-- 
1.8.1.2
