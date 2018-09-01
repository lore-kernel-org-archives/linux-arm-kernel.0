From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 01 Sep 2018 16:08:44 +0200
Subject: [PATCH v3 02/13] fbdev: allow apertures == NULL in
 remove_conflicting_framebuffers()
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
Message-ID: <b5fed539fe569035139c8594c23effd8c39f12ca.1535810304.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interpret (otherwise-invalid) NULL apertures argument to mean all-memory
range. This will allow to remove several duplicates of this code
from drivers in following patches.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---
v2: added kerneldoc to corresponding DRM helper
v3: split kerneldoc to another patch
---
 drivers/video/fbdev/core/fbmem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 30a18d4c9de4..0df148eb4699 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1779,11 +1779,25 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 				    const char *name, bool primary)
 {
 	int ret;
+	bool do_free = false;
+
+	if (!a) {
+		a = alloc_apertures(1);
+		if (!a)
+			return -ENOMEM;
+
+		a->ranges[0].base = 0;
+		a->ranges[0].size = ~0;
+		do_free = true;
+	}
 
 	mutex_lock(&registration_lock);
 	ret = do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
 
+	if (do_free)
+		kfree(a);
+
 	return ret;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
-- 
2.18.0
