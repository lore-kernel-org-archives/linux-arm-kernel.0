From: s-anna@ti.com (Suman Anna)
Date: Fri, 26 May 2017 11:53:17 -0500
Subject: [PATCH 3/3] remoteproc/keystone: ensure the DSPs are in reset in probe
In-Reply-To: <20170526165317.23164-1-s-anna@ti.com>
References: <20170526165317.23164-1-s-anna@ti.com>
Message-ID: <20170526165317.23164-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Andrew F. Davis" <afd@ti.com>

The DSPs are expected to be in reset when the driver probes a device.
If the DSPs are out of reset in probe, the system may crash when the
firmware is being loaded. So, add a check to make sure the DSP resets
are asserted, and if not, throw a eye-catchy warning and assert the
resets specifically.

Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna at ti.com: replace warning with a WARN]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/keystone_remoteproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index d01d5e3fce28..8233664e85fa 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -456,6 +456,16 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 	if (of_reserved_mem_device_init(dev))
 		dev_warn(dev, "device does not have specific CMA pool\n");
 
+	/* ensure the DSP is in reset before loading firmware */
+	ret = reset_control_status(ksproc->reset);
+	if (ret < 0) {
+		dev_err(dev, "failed to get reset status, status = %d\n", ret);
+		goto release_mem;
+	} else if (ret == 0) {
+		WARN(1, "device is not in reset\n");
+		keystone_rproc_dsp_reset(ksproc);
+	}
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
-- 
2.12.0
