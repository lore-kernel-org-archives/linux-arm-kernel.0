From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:46 +0100
Subject: [PATCH v4 2/8] ARM: kexec: ensure new kernel is entered in ARM state
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314136012-20533-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 540b5738 ("ARM: 6999/1: head, zImage: Always Enter the kernel in
ARM state") mandates that the kernel should be entered in ARM state.

If a Thumb-2 kernel kexecs a new kernel image, we need to ensure that
we change state when branching to the new code. This patch replaces a
mov pc, lr with a bx lr so that we transition to ARM state if need be.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/relocate_kernel.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index 9cf4cbf..0908633 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -57,7 +57,7 @@ relocate_new_kernel:
 	mov r0,#0
 	ldr r1,kexec_mach_type
 	ldr r2,kexec_boot_atags
-	mov pc,lr
+	bx lr
 
 	.align
 
-- 
1.7.0.4
