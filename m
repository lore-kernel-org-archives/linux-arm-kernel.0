From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Fri,  5 Oct 2018 09:47:54 +0100
Subject: [RFC 17/17] arm64: compile the kernel with ptrauth
 -msign-return-address
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Message-ID: <20181005084754.20950-18-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compile all functions with two ptrauth instructions: paciasp in the
prologue to sign the return address, and autiasp in the epilogue to
authenticate the return address. This should help protect the kernel
against attacks using return-oriented programming.

CONFIG_ARM64_PTR_AUTH enables pointer auth for both userspace and the
kernel.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 106039d25e2f..dbcd43ea99d8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -56,6 +56,10 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
+KBUILD_CFLAGS	+= -msign-return-address=all
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.11.0
