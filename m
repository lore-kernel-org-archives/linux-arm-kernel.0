From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 21 Nov 2009 09:16:47 +0100
Subject: [PATCH 3/3] staging/dream: fix memory leak in camera error path
Message-ID: <20091121081647.GC2597@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


cppcheck found that ctrl_pmsm is leaked if the open operation fails.

Signed-off-by: Eric Sesterhenn <eric.sesterhenn@lsexperts.de>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/staging/dream/camera/msm_camera.c b/drivers/staging/dream/camera/msm_camera.c
index 7d93877..87e118d 100644
--- a/drivers/staging/dream/camera/msm_camera.c
+++ b/drivers/staging/dream/camera/msm_camera.c
@@ -1885,8 +1885,10 @@ static int msm_open_control(struct inode *inode, struct file *filep)
 		return -ENOMEM;
 
 	rc = msm_open_common(inode, filep, 0);
-	if (rc < 0)
+	if (rc < 0) {
+		kfree(ctrl_pmsm);
 		return rc;
+	}
 
 	ctrl_pmsm->pmsm = filep->private_data;
 	filep->private_data = ctrl_pmsm;



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
