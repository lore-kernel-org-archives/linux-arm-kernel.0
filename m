From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jan 2012 11:24:55 +0000
Subject: [PATCH v2 4/4] ARM: vfp: clear fpscr length and stride bits on entry
 to sig handler
In-Reply-To: <1327922695-16121-1-git-send-email-will.deacon@arm.com>
References: <1327922695-16121-1-git-send-email-will.deacon@arm.com>
Message-ID: <1327922695-16121-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM PCS mandates that the length and stride bits of the fpscr are
cleared on entry to and return from a public interface. Although signal
handlers run asynchronously with respect to the interrupted function,
the handler itself expects to run as though it has been called like a
normal function.

This patch updates the state mirroring the VFP hardware before entry to
a signal handler so that it adheres to the PCS. Furthermore, we disable
VFP to ensure that we trap on any floating point operation performed by
the signal handler and synchronise the hardware appropriately. A check
is inserted after the signal handler to avoid redundant flushing if VFP
was not used.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/signal.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 9e617bd..3de59a0 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -207,6 +207,20 @@ static int preserve_vfp_context(struct vfp_sigframe __user *frame)
 	__put_user_error(h->fpinst, &frame->ufp_exc.fpinst, err);
 	__put_user_error(h->fpinst2, &frame->ufp_exc.fpinst2, err);
 
+	vfp_flush_hwstate(thread);
+
+	/*
+	 * As per the PCS, clear the length and stride bits before entry
+	 * to the signal handler.
+	 */
+	h->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
+
+	/*
+	 * Disable VFP so that we can detect if it was used by the
+	 * signal handler.
+	 */
+	h->fpexc &= ~FPEXC_EN;
+
 	return err ? -EFAULT : 0;
 }
 
@@ -227,7 +241,8 @@ static int restore_vfp_context(struct vfp_sigframe __user *frame)
 	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
-	vfp_flush_hwstate(thread);
+	if (h->fpexc & FPEXC_EN)
+		vfp_flush_hwstate(thread);
 
 	/*
 	 * Copy the floating point registers. There can be unused
-- 
1.7.4.1
