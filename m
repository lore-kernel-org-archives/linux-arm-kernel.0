From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Fri,  5 Oct 2018 09:47:47 +0100
Subject: [PATCH v5 10/17] arm64: enable pointer authentication
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Message-ID: <20181005084754.20950-11-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Now that all the necessary bits are in place for userspace, add the
necessary Kconfig logic to allow this to be enabled.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..8a6d44160fa8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1134,6 +1134,29 @@ config ARM64_RAS_EXTN
 
 endmenu
 
+menu "ARMv8.3 architectural features"
+
+config ARM64_PTR_AUTH
+	bool "Enable support for pointer authentication"
+	default y
+	help
+	  Pointer authentication (part of the ARMv8.3 Extensions) provides
+	  instructions for signing and authenticating pointers against secret
+	  keys, which can be used to mitigate Return Oriented Programming (ROP)
+	  and other attacks.
+
+	  This option enables these instructions at EL0 (i.e. for userspace).
+
+	  Choosing this option will cause the kernel to initialise secret keys
+	  for each process at exec() time, with these keys being
+	  context-switched along with the process.
+
+	  The feature is detected at runtime. If the feature is not present in
+	  hardware it will not be advertised to userspace nor will it be
+	  enabled.
+
+endmenu
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
-- 
2.11.0
