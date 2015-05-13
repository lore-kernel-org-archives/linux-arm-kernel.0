From: vigneshr@codeaurora.org (Vignesh Radhakrishnan)
Date: Wed, 13 May 2015 20:50:57 +0530
Subject: [PATCH] ARM: module: Add ".ref.text" to arm unwind tables
Message-ID: <1431530457-19909-1-git-send-email-vigneshr@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions inside kernel modules that use __ref
will end up being placed in .ARM.exidx.ref.text
section by gcc.

Currently we don't consider adding these functions
to arm unwind tables.

Hence, if we turn slub debug on by default we end up
with the messages of this sort:

	unwind: Index not found bf0011e0

This is because slub debug saves stack trace of
allocation's and free's. Therefore, we end up seeing
a flood of these messages in dmesg since its not
able to locate these functions.

Fix this by adding .ref.text section to arm unwind tables.

Signed-off-by: Vignesh Radhakrishnan <vigneshr@codeaurora.org>
---
 arch/arm/include/asm/module.h | 1 +
 arch/arm/kernel/module.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index ed690c4..17640c9 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -14,6 +14,7 @@ enum {
 	ARM_SEC_DEVEXIT,
 	ARM_SEC_HOT,
 	ARM_SEC_UNLIKELY,
+	ARM_SEC_REF,
 	ARM_SEC_MAX,
 };
 
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 2e11961..846b888 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -308,6 +308,8 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 			maps[ARM_SEC_UNLIKELY].unw_sec = s;
 		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
 			maps[ARM_SEC_HOT].unw_sec = s;
+		else if (strcmp(".ARM.exidx.ref.text", secname) == 0)
+			maps[ARM_SEC_REF].unw_sec = s;
 		else if (strcmp(".init.text", secname) == 0)
 			maps[ARM_SEC_INIT].txt_sec = s;
 		else if (strcmp(".text", secname) == 0)
@@ -318,6 +320,8 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 			maps[ARM_SEC_UNLIKELY].txt_sec = s;
 		else if (strcmp(".text.hot", secname) == 0)
 			maps[ARM_SEC_HOT].txt_sec = s;
+		else if (strcmp(".ref.text", secname) == 0)
+			maps[ARM_SEC_REF].txt_sec = s;
 	}
 
 	for (i = 0; i < ARM_SEC_MAX; i++)
-- 
1.8.2.1

-- 
Thanks and regards,
Vignesh Radhakrishnan

QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation.
