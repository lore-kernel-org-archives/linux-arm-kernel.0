From: dkos@cadence.com (Damian Kos)
Date: Tue, 24 Jul 2018 12:13:33 +0100
Subject: [PATCH v2 2/5] drm/dp: fix link probing for devices supporting DP 1.4+
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
Message-ID: <1532430824-23477-3-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from DP_DPCD_REV
to DP_ADAPTER_CAP should be retrieved starting from DP_DPCD_REV_EXTENDED.
All registers are copied except DP_DPCD_REV, DP_MAX_LINK_RATE and
DP_DOWNSTREAMPORT_PRESENT which represent the "true capabilities" of DPRX
device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT might
falsely return lower capabilities to "avoid interoperability issues with some
of the existing DP Source devices that malfunction when they discover the
higher capabilities within those three registers.".

Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved and read 0
so it's safe to check against it even if DP revision is <1.4

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 include/drm/drm_dp_helper.h     |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 0cccbcb2d03e..86a070269c87 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 05cc31b5db16..92800f2241b1 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -125,6 +125,7 @@
 
 #define DP_TRAINING_AUX_RD_INTERVAL         0x00e   /* XXX 1.2? */
 # define DP_TRAINING_AUX_RD_MASK            0x7F    /* XXX 1.2? */
+# define DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT BIT(7) /* 1.3 */
 
 #define DP_ADAPTER_CAP			    0x00f   /* 1.2 */
 # define DP_FORCE_LOAD_SENSE_CAP	    (1 << 0)
-- 
2.17.1
