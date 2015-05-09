From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 09 May 2015 11:26:37 +0100
Subject: [PATCH 09/13] drm/edid: add function to help find SADs
In-Reply-To: <20150509102501.GO2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Message-ID: <E1Yr1xt-0006l4-D0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to find the start of the SADs in the ELD.  This
complements the helper to retrieve the SAD count.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/drm/drm_edid.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 799050198323..53c53c459b15 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -348,6 +348,25 @@ static inline int drm_eld_mnl(const uint8_t *eld)
 }
 
 /**
+ * drm_eld_sad - Get ELD SAD structures.
+ * @eld: pointer to an eld memory structure with sad_count set
+ */
+static inline const uint8_t *drm_eld_sad(const uint8_t *eld)
+{
+	unsigned int ver, mnl;
+
+	ver = (eld[DRM_ELD_VER] & DRM_ELD_VER_MASK) >> DRM_ELD_VER_SHIFT;
+	if (ver != 2 && ver != 31)
+		return NULL;
+
+	mnl = drm_eld_mnl(eld);
+	if (mnl > 16)
+		return NULL;
+
+	return eld + DRM_ELD_CEA_SAD(mnl, 0);
+}
+
+/**
  * drm_eld_sad_count - Get ELD SAD count.
  * @eld: pointer to an eld memory structure with sad_count set
  */
-- 
1.8.3.1
