From: james.morse@arm.com (James Morse)
Date: Tue, 16 Feb 2016 15:49:27 +0000
Subject: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a different
 kernel version
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Message-ID: <1455637767-31561-16-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resuming using a different kernel version is fragile, while there are
sufficient details in the hibernate arch-header to perform the restore,
changes in the boot process can have a long-lasting impact on the system.
In particular, if the EFI stub causes more memory to be allocated, the
amount of memory left for linux is reduced. If we are lucky, this will
cause restore to fail with the message:
> PM: Image mismatch: memory size
If we are unlucky, the system will explode sometime later when an EFI
runtime services call is made.

Prevent resuming with a different kernel version, by making
HIBERNATE_VERSION the current kernel version.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index fd2faca358f6..99ebdbb06e85 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -56,14 +56,9 @@ extern int in_suspend;
 
 /*
  * This value is written to the hibernate arch header, and prevents resuming
- * from a hibernate image produced by an incompatible kernel. If you change
- * a value that isn't saved/restored by hibernate, you should change this value.
- *
- * For example, if the mair_el1 values used by the kernel are changed, you
- * should prevent resuming from a kernel with incompatible attributes, as these
- * aren't saved/restored.
+ * from a hibernate image produced by a different kernel version.
  */
-#define HIBERNATE_VERSION	KERNEL_VERSION(4, 6, 0)
+#define HIBERNATE_VERSION	LINUX_VERSION_CODE
 
 /*
  * Start/end of the hibernate exit code, this must be copied to a 'safe'
-- 
2.6.2
