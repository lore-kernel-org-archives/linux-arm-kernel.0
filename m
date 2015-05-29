From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 28 May 2015 20:48:13 -0400
Subject: [PATCH 15/15] drivers/clk: don't use module_init in clk-nomadik.c
 which is non-modular
In-Reply-To: <1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com>
References: <1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1432860493-23831-16-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk-nomadik.o is built for ARCH_NOMADIK -- which is bool, and
hence this code is either present or absent.  It will never be
modular, so using module_init as an alias for __initcall can be
somewhat misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of device_initcall
directly in this change means that the runtime impact is
zero -- it will remain at level 6 in initcall ordering.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/clk/clk-nomadik.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 05e04ce0f148..c9487179f25f 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -503,8 +503,7 @@ static int __init nomadik_src_clk_init_debugfs(void)
 			    NULL, NULL, &nomadik_src_clk_debugfs_ops);
 	return 0;
 }
-
-module_init(nomadik_src_clk_init_debugfs);
+device_initcall(nomadik_src_clk_init_debugfs);
 
 #endif
 
-- 
2.2.1
