From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 17:20:56 +0200
Subject: [PATCH] cifs: remove dead code
Message-ID: <3319326.1eJrmz0Vgc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cifs provides two dummy functions 'sess_auth_lanman' and
'sess_auth_kerberos' for the case in which the respective
features are not defined. However, the caller is also under
an #ifdef, so we just get warnings about unused code:

fs/cifs/sess.c:1109:1: warning: 'sess_auth_kerberos' defined but not used [-Wunused-function]
 sess_auth_kerberos(struct sess_data *sess_data)

Removing the dead functions gets rid of the warnings without
any downsides that I can see.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 07fe97ac6b0c..ab0fda6e8e58 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -745,14 +745,6 @@ out:
 	sess_free_buffer(sess_data);
 }
 
-#else
-
-static void
-sess_auth_lanman(struct sess_data *sess_data)
-{
-	sess_data->result = -EOPNOTSUPP;
-	sess_data->func = NULL;
-}
 #endif
 
 static void
@@ -1103,15 +1095,6 @@ out:
 	ses->auth_key.response = NULL;
 }
 
-#else
-
-static void
-sess_auth_kerberos(struct sess_data *sess_data)
-{
-	cifs_dbg(VFS, "Kerberos negotiated but upcall support disabled!\n");
-	sess_data->result = -ENOSYS;
-	sess_data->func = NULL;
-}
 #endif /* ! CONFIG_CIFS_UPCALL */
 
 /*
