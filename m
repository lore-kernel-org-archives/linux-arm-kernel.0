From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 22:52:44 +0100
Subject: [PATCH] ext4: fix ext4_ioctl_setproject return code
Message-ID: <4720038.3sLXXjk50c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced ext4_ioctl_setproject() functions comes in two
versions, one is fine and the other has an undefined return value,
as indicated by a compiler warning:

fs/ext4/ioctl.c:426:1: warning: control reaches end of non-void function [-Wreturn-type]
fs/ext4/ioctl.c: In function 'ext4_ioctl_setproject':

This changes the function to return zero on success, as the other
version does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e14c6dbc6429 ("ext4: add FS_IOC_FSSETXATTR/FS_IOC_FSGETXATTR interface support")
---
Found on ARM randconfig testing on the last two linux-next releases.

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index c1d45aaa7d55..946560cb3fe6 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -423,6 +423,7 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
 {
 	if (projid != EXT4_DEF_PROJID)
 		return -EOPNOTSUPP;
+	return 0;
 }
 #endif
 
