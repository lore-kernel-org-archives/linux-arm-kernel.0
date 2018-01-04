From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Jan 2018 15:08:26 +0000
Subject: [PATCH 02/11] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
In-Reply-To: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
Message-ID: <1515078515-13723-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
actually more useful as a mitigation against speculation attacks that
can leak arbitrary kernel data to userspace through speculation.

Reword the Kconfig help message to reflect this, and make the option
depend on EXPERT so that it is on by default for the majority of users.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3af1657fcac3..efaaa3a66b95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -834,15 +834,14 @@ config FORCE_MAX_ZONEORDER
 	  4M allocations matching the default size used by generic code.
 
 config UNMAP_KERNEL_AT_EL0
-	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
 	default y
 	help
-	  Some attacks against KASLR make use of the timing difference between
-	  a permission fault which could arise from a page table entry that is
-	  present in the TLB, and a translation fault which always requires a
-	  page table walk. This option defends against these attacks by unmapping
-	  the kernel whilst running in userspace, therefore forcing translation
-	  faults for all of kernel space.
+	  Speculation attacks against some high-performance processors can
+	  be used to bypass MMU permission checks and leak kernel data to
+	  userspace. This can be defended against by unmapping the kernel
+	  when running in userspace, mapping it back in on exception entry
+	  via a trampoline page in the vector table.
 
 	  If unsure, say Y.
 
-- 
2.1.4
