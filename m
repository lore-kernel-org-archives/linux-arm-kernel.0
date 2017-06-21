From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Jun 2017 16:46:02 +0100
Subject: [RFC PATCH 1/2] ARM: iwmmxt: Add missing __user annotations to
 sigframe accessors
In-Reply-To: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498059983-13438-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

preserve_iwmmxt_context() and restore_iwmmxt_context() lack __user
accessors on their arguments pointing to the user signal frame.

There does not be appear to be a bug here, but this omission is
inconsistent with the crunch and vfp sigframe access functions.

This patch adds the annotations, for consistency.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 7b8f214..8f06480 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -59,7 +59,7 @@ static int restore_crunch_context(struct crunch_sigframe __user *frame)
 
 #ifdef CONFIG_IWMMXT
 
-static int preserve_iwmmxt_context(struct iwmmxt_sigframe *frame)
+static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 {
 	char kbuf[sizeof(*frame) + 8];
 	struct iwmmxt_sigframe *kframe;
@@ -72,7 +72,7 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe *frame)
 	return __copy_to_user(frame, kframe, sizeof(*frame));
 }
 
-static int restore_iwmmxt_context(struct iwmmxt_sigframe *frame)
+static int restore_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 {
 	char kbuf[sizeof(*frame) + 8];
 	struct iwmmxt_sigframe *kframe;
-- 
2.1.4
