From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 10:37:44 +0000
Subject: [PATCH 2/2] ARM: Preserve the VFP state during fork
In-Reply-To: <20110214103528.5796.99616.stgit@e102109-lin.cambridge.arm.com>
References: <20110214103528.5796.99616.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20110214103744.5796.5958.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VFP registers d16-d31 are callee saved registers and must be preserved
during function calls, including fork(). The VFP configuration should
also be preserved. The patch copies the full VFP state to the child
process.

Reported-by: Paul Wright <paul.wright@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/vfp/vfpmodule.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 5153135..cb7a88c 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -78,6 +78,14 @@ static void vfp_thread_exit(struct thread_info *thread)
 	put_cpu();
 }
 
+static void vfp_thread_copy(struct thread_info *thread)
+{
+	struct thread_info *parent = current_thread_info();
+
+	vfp_sync_hwstate(parent);
+	thread->vfpstate = parent->vfpstate;
+}
+
 /*
  * When this function is called with the following 'cmd's, the following
  * is true while this function is being run:
@@ -148,6 +156,10 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 	case THREAD_NOTIFY_EXIT:
 		vfp_thread_exit(thread);
 		break;
+
+	case THREAD_NOTIFY_COPY:
+		vfp_thread_copy(thread);
+		break;
 	}
 
 	return NOTIFY_DONE;
