From: will.deacon@arm.com (Will Deacon)
Date: Sun, 29 Aug 2010 19:51:59 +0100
Subject: [PATCH 1/3] oprofile: don't call arch exit code from init code on
	failure
In-Reply-To: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
References: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
Message-ID: <1283107921-21464-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oprofile_init calls oprofile_arch_init to initialise the architecture-specific
backend code. If this backend code returns failure, oprofile_arch_exit is
called immediately, making it difficult to allocate and free resources
correctly.

This patch removes the oprofile_arch_exit call from oprofile_init,
meaning that all architectures must ensure that oprofile_arch_init
cleans up any mess it's made before returning an error. As far as
I can tell, this only affects the code for ARM and x86.

Cc: Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/oprofile/oprof.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
index b336cd9..b4a6857 100644
--- a/drivers/oprofile/oprof.c
+++ b/drivers/oprofile/oprof.c
@@ -257,16 +257,9 @@ static int __init oprofile_init(void)
 		printk(KERN_INFO "oprofile: using timer interrupt.\n");
 		err = oprofile_timer_init(&oprofile_ops);
 		if (err)
-			goto out_arch;
+			return err;
 	}
-	err = oprofilefs_register();
-	if (err)
-		goto out_arch;
-	return 0;
-
-out_arch:
-	oprofile_arch_exit();
-	return err;
+	return oprofilefs_register();
 }
 
 
-- 
1.6.3.3
