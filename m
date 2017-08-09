From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Aug 2017 13:05:33 +0100
Subject: [RFC PATCH 27/27] arm64/sve: signal: Include SVE when computing
 AT_MINSIGSTKSZ
In-Reply-To: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1502280338-23002-28-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SVE context block in the signal frame needs to be considered
too when computing the maximum possible signal frame size.

Because the size of this block depends on the vector length, this
patch computes the size based not on the thread's current vector
length but instead on the maximum possible vector length: this
determines the maximum size of SVE context block that can be
observed in any signal frame for the lifetime of the process.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 221bcf2..cb01353 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -586,11 +586,18 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 	}
 
 	if (system_supports_sve()) {
-		unsigned int vq = 0;
+		unsigned int vq;
 
-		if (test_thread_flag(TIF_SVE)) {
-			BUG_ON(!sve_vl_valid(current->thread.sve_vl));
-			vq = sve_vq_from_vl(current->thread.sve_vl);
+		if (!add_all && !test_thread_flag(TIF_SVE))
+			vq = 0;
+		else {
+			unsigned int vl = sve_max_vl;
+
+			if (!add_all)
+				vl = current->thread.sve_vl;
+
+			BUG_ON(!sve_vl_valid(vl));
+			vq = sve_vq_from_vl(vl);
 		}
 
 		err = sigframe_alloc(user, &user->sve_offset,
-- 
2.1.4
