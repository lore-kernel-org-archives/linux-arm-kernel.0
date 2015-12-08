From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue,  8 Dec 2015 19:13:32 -0300
Subject: [RESEND PATCH] modpost: don't add a trailing wildcard for OF module
 aliases
Message-ID: <1449612813-27004-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ac551828993ee ("modpost: i2c aliases need no trailing wildcard")
removed the wildcard at the end of the I2C module aliases because I2C
devices have no IDs so the aliases are just arbitrary device names.

This is also true for OF modaliases since a compatible string is used
to define a specific IP hardware block. So the modalias should match a
specific compatible string and not attempt to match a compatible string
whose name matches the beginning of another one.

For example, the following driver module:

$ modinfo cros_ec_keyb | grep alias
alias:          platform:cros-ec-keyb
alias:          of:N*T*Cgoogle,cros-ec-keyb*

will be tried to be loaded for an alias of:N*T*Cgoogle,cros-ec-keyb-v2
but there could be a different driver that supports the device for that
compatible string so it's better to remove the trailing wildcard for OF.

Also, remove the word "always" from the add_wildcard() function comment
since that was carried from the time where a wildcard was always added
at the end of the module alias for all the devices.

Suggested-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---
Hello,

I sent this patch before [0] but was never picked. MAINTAINERS doesn't
say who should manage patches to file2alias so maybe I didn't add the
right person to the cc list.

Documentation/development-process/5.Posting says that if there is no
obvious maintainer, then Andrew Morton is often the patch target so
I'm re-sending to him.

Best regards,
Javier

 scripts/mod/file2alias.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5b96206e9aab..65eaab8b7798 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -125,7 +125,7 @@ do {                                                            \
                 sprintf(str + strlen(str), "*");                \
 } while(0)
 
-/* Always end in a wildcard, for future extension */
+/* End in a wildcard, for future extension */
 static inline void add_wildcard(char *str)
 {
 	int len = strlen(str);
@@ -704,7 +704,6 @@ static int do_of_entry (const char *filename, void *symval, char *alias)
 		if (isspace (*tmp))
 			*tmp = '_';
 
-	add_wildcard(alias);
 	return 1;
 }
 ADD_TO_DEVTABLE("of", of_device_id, do_of_entry);
-- 
2.4.3
