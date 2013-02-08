From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:39 +0000
Subject: [PATCH 09/17] ARM: add atag32_to_cpu() function
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add atag32_to_cpu() function to allow code manipulating ATAGs to deal
with the case where the boot-loader was in little-endian and Linux is
running big-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/uapi/asm/setup.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/setup.h
index 979ff40..d74a417 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -175,13 +175,18 @@ struct tagtable {
 
 #define tag_member_present(tag,member)				\
 	((unsigned long)(&((struct tag *)0L)->member + 1)	\
-		<= (tag)->hdr.size * 4)
+		<= atag32_to_cpu((tag)->hdr.size) * 4)
 
-#define tag_next(t)	((struct tag *)((__u32 *)(t) + (t)->hdr.size))
+#define tag_next(t)	((struct tag *)((__u32 *)(t) + atag32_to_cpu((t)->hdr.size)))
 #define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
 
 #define for_each_tag(t,base)		\
 	for (t = base; t->hdr.size; t = tag_next(t))
 
+#ifdef CONFIG_CPU_BE8_BOOT_LE
+#define atag32_to_cpu(x)	le32_to_cpu(x)
+#else
+#define atag32_to_cpu(x)	x
+#endif
 
 #endif /* _UAPI__ASMARM_SETUP_H */
-- 
1.7.10.4
