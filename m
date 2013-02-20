From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Wed, 20 Feb 2013 12:52:55 +0100
Subject: [PATCH] ARM: poison_init_mem: fixed underflow in loop
Message-ID: <1361361175-26600-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When initmemory ends at an odd address, the loop variable in
poison_init_mem() will underflow which causes overriding of valid
memory. Such situations are not a theoretical issue only but
exist in practice:

| [    0.000000]       .init : 0xc0634000 - 0xc0c215ab   (6070 kB)

Patch makes a simple division instead of DIV_ROUND_UP() because latter
can override some bytes after .init.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 arch/arm/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ad722f1..c431a2d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -449,7 +449,8 @@ static inline int free_area(unsigned long pfn, unsigned long end, char *s)
 static inline void poison_init_mem(void *s, size_t count)
 {
 	u32 *p = (u32 *)s;
-	for (; count != 0; count -= 4)
+	count /= sizeof(*p);
+	for (; count != 0; count--)
 		*p++ = 0xe7fddef0;
 }
 
-- 
1.8.1.2
