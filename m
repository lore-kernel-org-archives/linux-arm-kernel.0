From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 8 Oct 2018 11:21:43 -0700
Subject: [PATCH v6 1/4] Documentation: xilinx: Add documentation for eemi APIs
In-Reply-To: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
References: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
Message-ID: <1539022906-18073-2-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation for embedded energy management interface (EEMI)
APIs. It includes information about eemi ops and how to use them.
It also includes API information and supported IOCTL IDs which can
be used for device and control configuration.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 Documentation/xilinx/eemi.txt | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/xilinx/eemi.txt

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
new file mode 100644
index 0000000..0ab686c
--- /dev/null
+++ b/Documentation/xilinx/eemi.txt
@@ -0,0 +1,67 @@
+---------------------------------------------------------------------
+Xilinx Zynq MPSoC EEMI Documentation
+---------------------------------------------------------------------
+
+Xilinx Zynq MPSoC Firmware Interface
+-------------------------------------
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate with PMC(Platform Management Controller).
+
+Embedded Energy Management Interface (EEMI)
+----------------------------------------------
+The embedded energy management interface is used to allow software
+components running across different processing clusters on a chip or
+device to communicate with a power management controller (PMC) on a
+device to issue or respond to power management requests.
+
+EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
+The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
+structure. Any driver who want to communicate with PMC using EEMI APIs
+can call zynqmp_pm_get_eemi_ops().
+
+Example of EEMI ops:
+
+	/* zynqmp-firmware driver maintain all EEMI APIs */
+	struct zynqmp_eemi_ops {
+		int (*get_api_version)(u32 *version);
+		int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	};
+
+	static const struct zynqmp_eemi_ops eemi_ops = {
+		.get_api_version = zynqmp_pm_get_api_version,
+		.query_data = zynqmp_pm_query_data,
+	};
+
+Example of EEMI ops usage:
+
+	static const struct zynqmp_eemi_ops *eemi_ops;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+
+IOCTL
+------
+IOCTL API is for device control and configuration. It is not a system
+IOCTL but it is an EEMI API. This API can be used by master to control
+any device specific configuration. IOCTL definitions can be platform
+specific. This API also manage shared device configuration.
+
+The following IOCTL IDs are valid for device control:
+- IOCTL_SET_PLL_FRAC_MODE	8
+- IOCTL_GET_PLL_FRAC_MODE	9
+- IOCTL_SET_PLL_FRAC_DATA	10
+- IOCTL_GET_PLL_FRAC_DATA	11
+
+Refer EEMI API guide [0] for IOCTL specific parameters and other EEMI APIs.
+
+References
+----------
+[0] Embedded Energy Management Interface (EEMI) API guide:
+    https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf
-- 
2.7.4
