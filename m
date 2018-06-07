From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu,  7 Jun 2018 17:20:47 +0800
Subject: [v3, 07/10] fsl/fman_port: support getting timestamp
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
Message-ID: <20180607092050.46128-8-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add fman_port_get_tstamp() interface
to get timestamp.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None.
Changes for v3:
	- Moved endianness conversion from dpaa to fman API.
---
 drivers/net/ethernet/freescale/fman/fman_port.c |   12 ++++++++++++
 drivers/net/ethernet/freescale/fman/fman_port.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index ce6e24c..dce860d 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1731,6 +1731,18 @@ int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset)
 }
 EXPORT_SYMBOL(fman_port_get_hash_result_offset);
 
+int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp)
+{
+	if (port->buffer_offsets.time_stamp_offset == ILLEGAL_BASE)
+		return -EINVAL;
+
+	*tstamp = be64_to_cpu(*(u64 *)(data +
+			port->buffer_offsets.time_stamp_offset));
+
+	return 0;
+}
+EXPORT_SYMBOL(fman_port_get_tstamp);
+
 static int fman_port_probe(struct platform_device *of_dev)
 {
 	struct fman_port *port;
diff --git a/drivers/net/ethernet/freescale/fman/fman_port.h b/drivers/net/ethernet/freescale/fman/fman_port.h
index e86ca6a..9dbb69f 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.h
+++ b/drivers/net/ethernet/freescale/fman/fman_port.h
@@ -153,6 +153,8 @@ int fman_port_cfg_buf_prefix_content(struct fman_port *port,
 
 int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset);
 
+int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp);
+
 struct fman_port *fman_port_bind(struct device *dev);
 
 #endif /* __FMAN_PORT_H */
-- 
1.7.1
