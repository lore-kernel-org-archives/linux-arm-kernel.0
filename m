From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Nov 2014 20:23:14 +0100
Subject: [PATCH v4 4/4] simplefb: Change simplefb_init from module_init to
 fs_initcall
In-Reply-To: <1415906594-2461-1-git-send-email-hdegoede@redhat.com>
References: <1415906594-2461-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415906594-2461-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the reasons for having the simplefb nodes in /chosen, and doing
explicit enumeration of the nodes there, is too allow enumerating them sooner,
so that we get a console earlier on.

Doing this earlier then fs_initcall is not useful, since the fb only turns
into a console when fbcon intializes, which is a fs_initcall too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--
Changes in v4 (of the patch-set):
-Drop the comment about using fs_initcall vs module_exit, as we no longer have
 a module_exit
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index e381a53..1fc973c 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -411,7 +411,7 @@ static int __init simplefb_init(void)
 	return 0;
 }
 
-module_init(simplefb_init);
+fs_initcall(simplefb_init);
 
 MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
 MODULE_DESCRIPTION("Simple framebuffer driver");
-- 
2.1.0
