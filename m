From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 24 Sep 2012 11:46:14 +0100
Subject: [PATCH v3 1/1] arm: introduce a DTS for Xen unprivileged virtual
 machines
Message-ID: <1348483574-7901-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given that the xenvm machine is based on vexpress but with an extremely
limited selection of peripherals (the guest is supposed to use virtual
devices instead), add "xen,xenvm" to the list of compatible machines in
mach-vexpress.


Changes in v3:

- add comments to mark fields that are likely to be changed by the
hypervisor.


Changes in v2:

- remove include skeleton;
- use #address-cells = <2> and #size-cells = <2>;
- remove the debug bootargs;
- use memory at 80000000 instead of memory;
- remove the ranges and interrupt-map from the motherboard node;
- set the machine compatible to "xen,xenvm-4.2", "xen,xenvm";
- rename the dts file to xenvm-4.2.dts;
- add "xen,xenvm" to the list of compatible DT strings to mach-vexpress.


Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Pawel Moll <pawel.moll@arm.com> (v2m changes)
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/xenvm-4.2.dts      |   68 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-vexpress/Makefile.boot |    3 +-
 arch/arm/mach-vexpress/v2m.c         |    1 +
 3 files changed, 71 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/xenvm-4.2.dts

diff --git a/arch/arm/boot/dts/xenvm-4.2.dts b/arch/arm/boot/dts/xenvm-4.2.dts
new file mode 100644
index 0000000..ec3f952
--- /dev/null
+++ b/arch/arm/boot/dts/xenvm-4.2.dts
@@ -0,0 +1,68 @@
+/*
+ * Xen Virtual Machine for unprivileged guests
+ *
+ * Based on ARM Ltd. Versatile Express CoreTile Express (single CPU)
+ * Cortex-A15 MPCore (V2P-CA15)
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	model = "XENVM-4.2";
+	compatible = "xen,xenvm-4.2", "xen,xenvm";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen {
+		/* this field is going to be adjusted by the hypervisor */
+		bootargs = "console=hvc0 root=/dev/xvda";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		/* this field is going to be adjusted by the hypervisor */
+		reg = <0 0x80000000 0 0x08000000>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0 0x2c001000 0 0x1000>,
+		      <0 0x2c002000 0 0x100>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+	};
+
+	hypervisor {
+		compatible = "xen,xen-4.2", "xen,xen";
+		/* this field is going to be adjusted by the hypervisor */
+		reg = <0 0xb0000000 0 0x20000>;
+		/* this field is going to be adjusted by the hypervisor */
+		interrupts = <1 15 0xf08>;
+	};
+
+	motherboard {
+		arm,v2m-memory-map = "rs1";
+	};
+};
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 318d308..38dbaac 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -7,4 +7,5 @@ initrd_phys-y	:= 0x60800000
 dtb-$(CONFIG_ARCH_VEXPRESS_DT)	+= vexpress-v2p-ca5s.dtb \
 				   vexpress-v2p-ca9.dtb \
 				   vexpress-v2p-ca15-tc1.dtb \
-				   vexpress-v2p-ca15_a7.dtb
+				   vexpress-v2p-ca15_a7.dtb \
+				   xenvm-4.2.dtb
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 4e567f7..9545b70 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -659,6 +659,7 @@ static void __init v2m_dt_init(void)
 
 const static char *v2m_dt_match[] __initconst = {
 	"arm,vexpress",
+	"xen,xenvm",
 	NULL,
 };
 
-- 
1.7.2.5
