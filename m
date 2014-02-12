From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 11 Feb 2014 17:33:25 -0800
Subject: [RFC/PATCH 3/3] init: Move stack canary initialization after
 setup_arch
In-Reply-To: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1392168805-14200-4-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stack canary intialization involves getting a random number.
Getting this random number may involve accessing caches or other
architectural specific features which are not available until
after the architecture is setup. Move the stack canary initialization
later to accomodate this.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 init/main.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index eb03090..63d0596 100644
--- a/init/main.c
+++ b/init/main.c
@@ -489,11 +489,6 @@ asmlinkage void __init start_kernel(void)
 	smp_setup_processor_id();
 	debug_objects_early_init();
 
-	/*
-	 * Set up the the initial canary ASAP:
-	 */
-	boot_init_stack_canary();
-
 	cgroup_init_early();
 
 	local_irq_disable();
@@ -507,6 +502,10 @@ asmlinkage void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
+	/*
+	 * Set up the the initial canary ASAP:
+	 */
+	boot_init_stack_canary();
 	mm_init_owner(&init_mm, &init_task);
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
