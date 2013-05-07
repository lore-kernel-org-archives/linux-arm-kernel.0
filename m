From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue,  7 May 2013 11:20:26 +0200
Subject: [PATCH] proc: Use PDE attribute setting accessor functions
Message-ID: <1367918426-7076-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-msm/last_radio_log.c: In function 'msm_init_last_radio_log':
arch/arm/mach-msm/last_radio_log.c:69:7: error: dereferencing pointer to incomplete type

arch/cris/kernel/profile.c: In function 'init_cris_profile':
arch/cris/kernel/profile.c:79:8: error: dereferencing pointer to incomplete type

Use proc_set_size(), cfr. commit 271a15eabe094538d958dc68ccfc9c36b699247a
("proc: Supply PDE attribute setting accessor functions")

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-msm/last_radio_log.c |    2 +-
 arch/cris/kernel/profile.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/last_radio_log.c b/arch/arm/mach-msm/last_radio_log.c
index 7777767..9c392a2 100644
--- a/arch/arm/mach-msm/last_radio_log.c
+++ b/arch/arm/mach-msm/last_radio_log.c
@@ -66,6 +66,6 @@ void msm_init_last_radio_log(struct module *owner)
 	pr_err("%s: last radio log is %d bytes long\n", __func__,
 		radio_log_size);
 	last_radio_log_fops.owner = owner;
-	entry->size = radio_log_size;
+	proc_set_size(entry, radio_log_size);
 }
 EXPORT_SYMBOL(msm_init_last_radio_log);
diff --git a/arch/cris/kernel/profile.c b/arch/cris/kernel/profile.c
index b82e086..cd9f15b 100644
--- a/arch/cris/kernel/profile.c
+++ b/arch/cris/kernel/profile.c
@@ -76,7 +76,7 @@ static int __init init_cris_profile(void)
 	entry = proc_create("system_profile", S_IWUSR | S_IRUGO, NULL,
 			    &cris_proc_profile_operations);
 	if (entry) {
-		entry->size = SAMPLE_BUFFER_SIZE;
+		proc_set_size(entry, SAMPLE_BUFFER_SIZE);
 	}
 	prof_running = 1;
 
-- 
1.7.0.4
