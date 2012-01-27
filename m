From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2012 16:24:03 +0000
Subject: [PATCH 4/4] ARM: vfp: clear fpscr length and stride bits on return
 from sig handler
In-Reply-To: <1327681443-16627-1-git-send-email-will.deacon@arm.com>
References: <1327681443-16627-1-git-send-email-will.deacon@arm.com>
Message-ID: <1327681443-16627-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM PCS mandates that the length and stride bits of the fpscr are
cleared on entry to and return from a public interface.

This patch ensures that the VFP context restored from a signal frame
is made to adhere to this specification.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/signal.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 9e617bd..274b8fc 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -216,7 +216,7 @@ static int restore_vfp_context(struct vfp_sigframe __user *frame)
 	struct vfp_hard_struct *h = &thread->vfpstate.hard;
 	unsigned long magic;
 	unsigned long size;
-	unsigned long fpexc;
+	unsigned long fpexc, fpscr;
 	int err = 0;
 
 	__get_user_error(magic, &frame->magic, err);
@@ -238,7 +238,13 @@ static int restore_vfp_context(struct vfp_sigframe __user *frame)
 	/*
 	 * Copy the status and control register.
 	 */
-	__get_user_error(h->fpscr, &frame->ufp.fpscr, err);
+	__get_user_error(fpscr, &frame->ufp.fpscr, err);
+
+	/*
+	 * As per the PCS, clear the length and stride bits.
+	 */
+	fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
+	h->fpscr = fpscr;
 
 	/*
 	 * Sanitise and restore the exception registers.
-- 
1.7.4.1
