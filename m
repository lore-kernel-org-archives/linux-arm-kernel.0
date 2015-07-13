From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:04 +0100
Subject: [PATCH 03/18] arm64: elf: advertise 8.1 atomic instructions as new
 hwcap
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM v8.1 architecture introduces new atomic instructions to the A64
instruction set for things like cmpxchg, so advertise their availability
to userspace using a hwcap.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/uapi/asm/hwcap.h |  1 +
 arch/arm64/kernel/setup.c           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 73cf0f54d57c..361c8a8ef55f 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -27,5 +27,6 @@
 #define HWCAP_SHA1		(1 << 5)
 #define HWCAP_SHA2		(1 << 6)
 #define HWCAP_CRC32		(1 << 7)
+#define HWCAP_ATOMICS		(1 << 8)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f3067d4d4e35..c7fd2c946374 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -280,6 +280,19 @@ static void __init setup_processor(void)
 	if (block && !(block & 0x8))
 		elf_hwcap |= HWCAP_CRC32;
 
+	block = (features >> 20) & 0xf;
+	if (!(block & 0x8)) {
+		switch (block) {
+		default:
+		case 2:
+			elf_hwcap |= HWCAP_ATOMICS;
+		case 1:
+			/* RESERVED */
+		case 0:
+			break;
+		}
+	}
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
@@ -456,6 +469,7 @@ static const char *hwcap_str[] = {
 	"sha1",
 	"sha2",
 	"crc32",
+	"atomics",
 	NULL
 };
 
-- 
2.1.4
