From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 12:03:16 +0100
Subject: [PATCH v5 5/5] simplefb: Change simplefb_init from module_init to
 fs_initcall
In-Reply-To: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
References: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415962996-31712-5-git-send-email-hdegoede@redhat.com>
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
index 74c5edd..8be9754 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -413,7 +413,7 @@ static int __init simplefb_init(void)
 	return 0;
 }
 
-module_init(simplefb_init);
+fs_initcall(simplefb_init);
 
 MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
 MODULE_DESCRIPTION("Simple framebuffer driver");
-- 
2.1.0
