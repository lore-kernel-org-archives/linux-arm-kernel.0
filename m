From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:17:59 +0100
Subject: [PATCH 3/5] ARM: add atag32_to_cpu() function
In-Reply-To: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377890281-10757-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add atag32_to_cpu() function to allow code manipulating ATAGs to deal
with the case where the boot-loader was in little-endian and Linux is
running big-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/uapi/asm/setup.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/setup.h
index 979ff40..d3b3fa1 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -175,13 +175,20 @@ struct tagtable {
 
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
+#define cpu_to_atag32(x)	cpu_to_le32(x)
+#else
+#define	cpu_to_atag32(x)	x
+#define atag32_to_cpu(x)	x
+#endif
 
 #endif /* _UAPI__ASMARM_SETUP_H */
-- 
1.7.10.4
