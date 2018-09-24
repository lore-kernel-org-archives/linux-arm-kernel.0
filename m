From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 14:11:27 +0200
Subject: [REVIEW][PATCH 3/4] signal/arm: Use send_sig_fault where appropriate
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
Message-ID: <20180924121128.5983-3-ebiederm@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/vfp/vfpmodule.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index dc7e6b50ef67..aa96cc5c9fe9 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -216,13 +216,6 @@ static struct notifier_block vfp_notifier_block = {
  */
 static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_code = sicode;
-	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
-
 	/*
 	 * This is the same as NWFPE, because it's not clear what
 	 * this is used for
@@ -230,7 +223,9 @@ static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
 	current->thread.error_code = 0;
 	current->thread.trap_no = 6;
 
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, sicode,
+		       (void __user *)(instruction_pointer(regs) - 4),
+		       current);
 }
 
 static void vfp_panic(char *reason, u32 inst)
-- 
2.17.1
