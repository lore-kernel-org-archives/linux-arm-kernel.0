From: const@MakeLinux.com (Constantine Shulyupin)
Date: Wed, 10 Oct 2012 12:32:54 +0200
Subject: [PATCH v2] USB: usb-skeleton.c: fix compilation error and restore
 kref_put on fail in skel_open
Message-ID: <1349865174-21649-1-git-send-email-const@MakeLinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Constantine Shulyupin <const@MakeLinux.com>

Function skel_open increments usage count for the device with kref_get and the usage count should be decremented on the function failure.

Some last changes in function skel_open and finally commit
52a7499 Revert "USB: usb-skeleton.c: fix open/disconnect race"
introduced a bug in function skel_open, which this patch fixes.

--
Changelog:
-- Fixed accordinly feedback of Oliver Neukum oneukum at suse.de: also need to drop the lock.

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/usb/usb-skeleton.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 0616f23..2025d03 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -113,8 +113,9 @@ static int skel_open(struct inode *inode, struct file *file)
 	mutex_lock(&dev->io_mutex);
 
 	retval = usb_autopm_get_interface(interface);
-	if (retval)
-		goto out_err;
+	if (retval) {
+		kref_put(&dev->kref, skel_delete);
+	}
 
 	/* save our object in the file's private structure */
 	file->private_data = dev;
-- 
1.7.9.5
