From: vishal.sagar@xilinx.com (Vishal Sagar)
Date: Wed, 30 May 2018 00:24:43 +0530
Subject: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI CSI-2
 Rx Subsystem
In-Reply-To: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
Message-ID: <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.

The Xilinx MIPI CSI-2 Rx Subsystem consists of a DPHY, CSI-2 Rx, an
optional I2C controller and an optional Video Format Bridge (VFB). The
active lanes can be configured at run time if enabled in the IP. The
DPHY register interface may also be enabled.

Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
---
 .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt

diff --git a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
new file mode 100644
index 0000000..31ed721
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
@@ -0,0 +1,117 @@
+
+Xilinx MIPI CSI2 Receiver Subsystem Device Tree Bindings
+--------------------------------------------------------
+
+The Xilinx MIPI CSI2 Receiver Subsystem is used to capture MIPI CSI2 traffic
+from compliant camera sensors and send the output as AXI4 Stream video data
+for image processing.
+
+The subsystem consists of a MIPI DPHY in slave mode which captures the
+data packets. This is passed along the MIPI CSI2 Rx IP which extracts the
+packet data. This data is taken in by the Video Format Bridge (VFB),
+if selected, and converted into AXI4 Stream video data at selected
+pixels per clock as per AXI4-Stream Video IP and System Design UG934.
+
+For more details, please refer to PG232 MIPI CSI-2 Receiver Subsystem.
+https://www.xilinx.com/support/documentation/ip_documentation/mipi_csi2_rx_subsystem/v3_0/pg232-mipi-csi2-rx.pdf
+
+Required properties:
+
+- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-2.0" or
+  "xlnx,mipi-csi2-rx-subsystem-3.0"
+
+- reg: Physical base address and length of the registers set for the device.
+
+- interrupt-parent: specifies the phandle to the parent interrupt controller
+
+- interrupts: Property with a value describing the interrupt number.
+
+- xlnx,max-lanes: Maximum active lanes in the design.
+
+- xlnx,vc: Virtual Channel, specifies virtual channel number to be filtered.
+  If this is 4 then all virtual channels are allowed.
+
+- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw design.
+  Packets other than this data type (except for RAW8 and User defined data
+  types) will be filtered out. Possible values are RAW6, RAW7, RAW8, RAW10,
+  RAW12, RAW14, RGB444, RGB555, RGB565, RGB666, RGB888 and YUV4228bit.
+
+- xlnx,axis-tdata-width: AXI Stream width, This denotes the AXI Stream width.
+  It depends on Data type chosen, Video Format Bridge enabled/disabled and
+  pixels per clock. If VFB is disabled then its value is either 0x20 (32 bit)
+  or 0x40(64 bit) width.
+
+- xlnx,video-format, xlnx,video-width: Video format and width, as defined in
+  video.txt.
+
+- port: Video port, using the DT bindings defined in ../video-interfaces.txt.
+  The CSI 2 Rx Subsystem has a two ports, one input port for connecting to
+  camera sensor and other is output port.
+
+- data-lanes: The number of data lanes through which CSI2 Rx Subsystem is
+  connected to the camera sensor as per video-interfaces.txt
+
+Optional properties:
+
+- xlnx,en-active-lanes: Enable Active lanes configuration in Protocol
+  Configuration Register.
+
+- xlnx,dphy-present: This is equivalent to whether DPHY register interface is
+  enabled or not.
+
+- xlnx,iic-present: This shows whether subsystem's IIC is present or not. This
+  affects the base address of the DPHY.
+
+- xlnx,vfb: Video Format Bridge, Denotes if Video Format Bridge is selected
+  so that output is as per AXI stream documented in UG934.
+
+- xlnx,ppc: Pixels per clock, Number of pixels to be transferred per pixel
+  clock. This is valid only if xlnx,vfb property is present.
+
+Example:
+
+       csiss_1: csiss at a0020000 {
+               compatible = "xlnx,mipi-csi2-rx-subsystem-3.0";
+               reg = <0x0 0xa0020000 0x0 0x20000>;
+               interrupt-parent = <&gic>;
+               interrupts = <0 95 4>;
+
+               xlnx,max-lanes = <0x4>;
+               xlnx,en-active-lanes;
+               xlnx,dphy-present;
+               xlnx,iic-present;
+               xlnx,vc = <0x4>;
+               xlnx,csi-pxl-format = "RAW8";
+               xlnx,vfb;
+               xlnx,ppc = <0x4>;
+               xlnx,axis-tdata-width = <0x20>;
+
+               ports {
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+
+                       port at 0 {
+                               reg = <0>;
+
+                               xlnx,video-format = <XVIP_VF_YUV_422>;
+                               xlnx,video-width = <8>;
+                               csiss_out: endpoint {
+                                       remote-endpoint = <&vcap_csiss_in>;
+                               };
+                       };
+                       port at 1 {
+                               reg = <1>;
+
+                               xlnx,video-format = <XVIP_VF_YUV_422>;
+                               xlnx,video-width = <8>;
+
+                               csiss_in: endpoint {
+                                       data-lanes = <1 2 3 4>;
+                                       /* MIPI CSI2 Camera handle */
+                                       remote-endpoint = <&vs2016_out>;
+                               };
+
+                       };
+
+               };
+       };
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
