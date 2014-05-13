From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 13 May 2014 17:40:34 +0200
Subject: [PATCH 10/9] dt: deps: fix bug not registering late drivers when
 OF_DEPENDENCIES is disabled
In-Reply-To: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1399995634-5401-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject says all. Patch 5/9 has a bug which avoids registering late drivers
if OF_DEPENDENCIES is disabled.

This also explains the large differences in boot times I've experienced when
comparing boot times with and without DT dependency based initialization order.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>

---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 7591cd1..e16e2b4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -799,9 +799,9 @@ static void __init do_basic_setup(void)
 	of_init_set_recording(false);
 	/* probe available platform drivers with deterministic order */
 	of_init_register_drivers();
+#endif
 	/* register late drivers */
 	do_initcall_level(ARRAY_SIZE(initcall_levels) - 3);
-#endif
 	random_int_secret_init();
 }
 
-- 
1.8.3.1
