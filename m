From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 12:03:15 +0100
Subject: [PATCH v5 4/5] fbcon: Change fbcon_init from module_init to
 fs_initcall
In-Reply-To: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
References: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415962996-31712-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various fb drivers register themselves before module_init so as to have a
console as early as possible, this is of little use if fbcon does not
initialize early too.

Fbcon cannot initialize earlier then fs_initcall, because then the creation
of /sys/class/graphics/fbcon will fail.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index eb976ee..ea43724 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3624,7 +3624,7 @@ static int __init fb_console_init(void)
 	return 0;
 }
 
-module_init(fb_console_init);
+fs_initcall(fb_console_init);
 
 #ifdef MODULE
 
-- 
2.1.0
