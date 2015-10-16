From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 16 Oct 2015 18:06:19 +0100
Subject: [PATCHv4 10/12] arm64: Add page size to the kernel image header
In-Reply-To: <1445015181-29711-1-git-send-email-suzuki.poulose@arm.com>
References: <1445015181-29711-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445015181-29711-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch adds the page size to the arm64 kernel image header
so that one can infer the PAGESIZE used by the kernel. This will
be helpful to diagnose failures to boot the kernel with page size
not supported by the CPU.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arm64/booting.txt |    7 ++++++-
 arch/arm64/kernel/image.h       |    5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 7d9d3c2..aaf6d77 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -104,7 +104,12 @@ Header notes:
 - The flags field (introduced in v3.17) is a little-endian 64-bit field
   composed as follows:
   Bit 0:	Kernel endianness.  1 if BE, 0 if LE.
-  Bits 1-63:	Reserved.
+  Bit 1-2:	Kernel Page size.
+			0 - Unspecified.
+			1 - 4K
+			2 - 16K
+			3 - 64K
+  Bits 3-63:	Reserved.
 
 - When image_size is zero, a bootloader should attempt to keep as much
   memory as possible free for use by the kernel immediately after the
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 6eb8fee..bc2abb8 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -47,7 +47,10 @@
 #define __HEAD_FLAG_BE	0
 #endif
 
-#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0)
+#define __HEAD_FLAG_PAGE_SIZE ((PAGE_SHIFT - 10) / 2)
+
+#define __HEAD_FLAGS	((__HEAD_FLAG_BE << 0) |	\
+			 (__HEAD_FLAG_PAGE_SIZE << 1))
 
 /*
  * These will output as part of the Image header, which should be little-endian
-- 
1.7.9.5
