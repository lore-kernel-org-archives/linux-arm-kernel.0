From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu,  3 Oct 2013 12:24:41 +0100
Subject: [PATCH v2 3/3] init: efi: arm: enable (U)EFI runtime services on arm
In-Reply-To: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
References: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1380799481-5470-4-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the efi_set_virtual_address_map call has strict init ordering
requirements, add an explicit hook in the required place.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 init/main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/main.c b/init/main.c
index af310af..ec6d76e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -875,6 +875,10 @@ static noinline void __init kernel_init_freeable(void)
 	smp_prepare_cpus(setup_max_cpus);
 
 	do_pre_smp_initcalls();
+
+	if (IS_ENABLED(CONFIG_ARM) && efi_enabled(EFI_BOOT))
+		efi_enter_virtual_mode();
+
 	lockup_detector_init();
 
 	smp_init();
-- 
1.7.10.4
