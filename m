From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 16 Jul 2015 17:51:31 -0400
Subject: [PATCH v1 1/2] ARM: keystone: dts: fix dt bindings for PCIe
Message-ID: <1437083492-28208-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently PCIe DT bindings are broken. PCIe driver can't function
without having a SerDes driver that provide the phy configuration.
On K2E EVM, this causes problem since the EVM has Marvell SATA
controller present and with default values in the SerDes register,
it seems to pass the PCIe link check, but causes issues since
the configuration is not correct. The manifestation is that when
EVM is booted with NFS rootfs, the boot hangs. We shouldn't enable
PCIe on this EVM since to work, SerDes driver has to be present as
well. So by default, the PCIe DT binding should be disabled in SoC
specific DTS. It can be enabled in the board specific DTS when the
SerDes device driver is also present.

So fix the status of PCIe DT bindings in the SoC specific DTS to
"disabled". To enable PCIe, the status should be set to "ok" in
the EVM DTS file when SerDes driver support becomes available in
the upstream tree.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 - updated commit description to make it clear that it is fix
   to be applied to v4.2-rc.
 arch/arm/boot/dts/k2e.dtsi      | 1 +
 arch/arm/boot/dts/keystone.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 50e555e..ecb9cd6 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -96,6 +96,7 @@
 			ranges = <0x81000000 0 0 0x23260000 0x4000 0x4000
 				0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
 
+			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
 
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c06542b..0d6be74 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -296,6 +296,7 @@
 			ranges = <0x81000000 0 0 0x23250000 0 0x4000
 				0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
 
+			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
 
-- 
1.9.1
