From: dianders@chromium.org (Doug Anderson)
Date: Tue,  6 Aug 2013 14:41:15 -0700
Subject: [PATCH] ARM: Add ".text.unlikely" and ".text.hot" to arm unwind tables
Message-ID: <1375825275-21962-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that gcc may put some code in ".text.unlikely" or
".text.hot" sections.  Right now those aren't accounted for in unwind
tables.  Add them.

I found some docs about this at:
  http://gcc.gnu.org/onlinedocs/gcc-4.6.2/gcc.pdf

Without this, if you have slub_debug turned on, you can get messages
that look like this:
  unwind: Index not found 7f008c50

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/include/asm/module.h | 2 ++
 arch/arm/kernel/module.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 0d3a28d..ed690c4 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -12,6 +12,8 @@ enum {
 	ARM_SEC_CORE,
 	ARM_SEC_EXIT,
 	ARM_SEC_DEVEXIT,
+	ARM_SEC_HOT,
+	ARM_SEC_UNLIKELY,
 	ARM_SEC_MAX,
 };
 
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 85c3fb6..084dc88 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -292,12 +292,20 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 			maps[ARM_SEC_CORE].unw_sec = s;
 		else if (strcmp(".ARM.exidx.exit.text", secname) == 0)
 			maps[ARM_SEC_EXIT].unw_sec = s;
+		else if (strcmp(".ARM.exidx.text.unlikely", secname) == 0)
+			maps[ARM_SEC_UNLIKELY].unw_sec = s;
+		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
+			maps[ARM_SEC_HOT].unw_sec = s;
 		else if (strcmp(".init.text", secname) == 0)
 			maps[ARM_SEC_INIT].txt_sec = s;
 		else if (strcmp(".text", secname) == 0)
 			maps[ARM_SEC_CORE].txt_sec = s;
 		else if (strcmp(".exit.text", secname) == 0)
 			maps[ARM_SEC_EXIT].txt_sec = s;
+		else if (strcmp(".text.unlikely", secname) == 0)
+			maps[ARM_SEC_UNLIKELY].txt_sec = s;
+		else if (strcmp(".text.hot", secname) == 0)
+			maps[ARM_SEC_HOT].txt_sec = s;
 	}
 
 	for (i = 0; i < ARM_SEC_MAX; i++)
-- 
1.8.3
