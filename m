From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Oct 2017 14:24:40 +0100
Subject: [PATCH 4/4] arm64: vdso: remove pointless gcov option
In-Reply-To: <20171016132440.38098-1-mark.rutland@arm.com>
References: <20171016132440.38098-1-mark.rutland@arm.com>
Message-ID: <20171016132440.38098-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 VDSO Makefile explicitly disables gcov; a practice we seem to
have inherited from other VDSO Makefiles.

The arm64 VDSO is written entirely in assembly, so this is not
necessary. Further, if the VDSO were written in C it would be necessary
to disable all other instrumentation, and this alone would not be
sufficient.

This patch remosves the redundant GCOV option for now.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/vdso/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 62c84f7cb01b..350190b749dd 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -15,9 +15,6 @@ ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
-# Disable gcov profiling for VDSO code
-GCOV_PROFILE := n
-
 # Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
 # down to collect2, resulting in silent corruption of the vDSO image.
 ccflags-y += -Wl,-shared
-- 
2.11.0
