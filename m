From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jan 2012 11:24:54 +0000
Subject: [PATCH v2 3/4] ARM: vfp: flush thread hwstate before copying ptrace
 registers
In-Reply-To: <1327922695-16121-1-git-send-email-will.deacon@arm.com>
References: <1327922695-16121-1-git-send-email-will.deacon@arm.com>
Message-ID: <1327922695-16121-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are context switched whilst copying into a thread's
vfp_hard_struct then the partial copy may be corrupted by the VFP
context switching code (see "ARM: vfp: flush thread hwstate before
restoring context from sigframe").

This patch updates the ptrace VFP set code so that the thread state is
flushed before the copy, therefore disabling VFP and preventing
corruption from occurring.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index d001be4..e33870f 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -726,8 +726,8 @@ static int vfp_set(struct task_struct *target,
 	if (ret)
 		return ret;
 
-	thread->vfpstate.hard = new_vfp;
 	vfp_flush_hwstate(thread);
+	thread->vfpstate.hard = new_vfp;
 
 	return 0;
 }
-- 
1.7.4.1
