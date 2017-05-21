From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:58 +0200
Subject: [PATCH 09/13] ARM: dts: armada-385-linksys: partition layout is board
 specific
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-10-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the partition layout to individual boards. The Linksys WRT 3200 ACM
(Rango) comes with a 256MiB nand flash chip and different layout.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Dismissed alternatives:

  a) Partition layouts as fragments for use with overlay. While the only
  alternative which might be worth considering it depends on optional
  overlay support. So should be selected by the target or at least be in
  the defconfig. Also feels like the mechanism wasn't intended to be
  used like this. Also bloats the dtbS.

  b) Adding a separate node for each variant would require to delete the
  others in the individual dts, just not enabling them isn't enough.

  c) Use partition layout dtsi which can be included separately. Two more
  dtsi for now.

  d) Delete and recreate partitions / nand node for Rango.

  e) Make partitions child nodes of a partition-layout node to ease
  defining custom layouts. Somewhat big of a change
---
 arch/arm/boot/dts/armada-385-linksys-caiman.dts | 67 +++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 67 +++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys-shelby.dts | 67 +++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys.dtsi       | 64 +----------------------
 4 files changed, 202 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index 05e854a..ee669ae 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -102,3 +102,70 @@
 		label = "caiman:white:sata";
 	};
 };
+
+&nand {
+	/* 128MiB */
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x200000>;  /* 2MiB */
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "u_env";
+		reg = <0x200000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 140000 {
+		label = "s_env";
+		reg = <0x240000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 900000 {
+		label = "devinfo";
+		reg = <0x900000 0x100000>;   /* 1MiB */
+		read-only;
+	};
+
+	/* kernel1 overlaps with rootfs1 by design */
+	partition at a00000 {
+		label = "kernel1";
+		reg = <0xa00000 0x2800000>;  /* 40MiB */
+	};
+
+	partition at 1000000 {
+		label = "rootfs1";
+		reg = <0x1000000 0x2200000>;  /* 34MiB */
+	};
+
+	/* kernel2 overlaps with rootfs2 by design */
+	partition at 3200000 {
+		label = "kernel2";
+		reg = <0x3200000 0x2800000>; /* 40MiB */
+	};
+
+	partition at 3800000 {
+		label = "rootfs2";
+		reg = <0x3800000 0x2200000>; /* 34MiB */
+	};
+
+	/*
+	 * 38MiB, last MiB is for the BBT, not writable
+	 */
+	partition at 5a00000 {
+		label = "syscfg";
+		reg = <0x5a00000 0x2600000>;
+	};
+
+	/*
+	 * Unused area between "s_env" and "devinfo".
+	 * Moved here because otherwise the renumbered
+	 * partitions would break the bootloader
+	 * supplied bootargs
+	 */
+	partition at 180000 {
+		label = "unused_area";
+		reg = <0x280000 0x680000>;   /* 6.5MiB */
+	};
+};
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index 5b1662b..5169ca8 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -102,3 +102,70 @@
 		label = "cobra:white:sata";
 	};
 };
+
+&nand {
+	/* 128MiB */
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x200000>;  /* 2MiB */
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "u_env";
+		reg = <0x200000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 140000 {
+		label = "s_env";
+		reg = <0x240000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 900000 {
+		label = "devinfo";
+		reg = <0x900000 0x100000>;   /* 1MiB */
+		read-only;
+	};
+
+	/* kernel1 overlaps with rootfs1 by design */
+	partition at a00000 {
+		label = "kernel1";
+		reg = <0xa00000 0x2800000>;  /* 40MiB */
+	};
+
+	partition at 1000000 {
+		label = "rootfs1";
+		reg = <0x1000000 0x2200000>;  /* 34MiB */
+	};
+
+	/* kernel2 overlaps with rootfs2 by design */
+	partition at 3200000 {
+		label = "kernel2";
+		reg = <0x3200000 0x2800000>; /* 40MiB */
+	};
+
+	partition at 3800000 {
+		label = "rootfs2";
+		reg = <0x3800000 0x2200000>; /* 34MiB */
+	};
+
+	/*
+	 * 38MiB, last MiB is for the BBT, not writable
+	 */
+	partition at 5a00000 {
+		label = "syscfg";
+		reg = <0x5a00000 0x2600000>;
+	};
+
+	/*
+	 * Unused area between "s_env" and "devinfo".
+	 * Moved here because otherwise the renumbered
+	 * partitions would break the bootloader
+	 * supplied bootargs
+	 */
+	partition at 180000 {
+		label = "unused_area";
+		reg = <0x280000 0x680000>;   /* 6.5MiB */
+	};
+};
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
index a909371..94aa35b 100644
--- a/arch/arm/boot/dts/armada-385-linksys-shelby.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
@@ -102,3 +102,70 @@
 		label = "shelby:white:sata";
 	};
 };
+
+&nand {
+	/* 128MiB */
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x200000>;  /* 2MiB */
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "u_env";
+		reg = <0x200000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 140000 {
+		label = "s_env";
+		reg = <0x240000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 900000 {
+		label = "devinfo";
+		reg = <0x900000 0x100000>;   /* 1MiB */
+		read-only;
+	};
+
+	/* kernel1 overlaps with rootfs1 by design */
+	partition at a00000 {
+		label = "kernel1";
+		reg = <0xa00000 0x2800000>;  /* 40MiB */
+	};
+
+	partition at 1000000 {
+		label = "rootfs1";
+		reg = <0x1000000 0x2200000>;  /* 34MiB */
+	};
+
+	/* kernel2 overlaps with rootfs2 by design */
+	partition at 3200000 {
+		label = "kernel2";
+		reg = <0x3200000 0x2800000>; /* 40MiB */
+	};
+
+	partition at 3800000 {
+		label = "rootfs2";
+		reg = <0x3800000 0x2200000>; /* 34MiB */
+	};
+
+	/*
+	 * 38MiB, last MiB is for the BBT, not writable
+	 */
+	partition at 5a00000 {
+		label = "syscfg";
+		reg = <0x5a00000 0x2600000>;
+	};
+
+	/*
+	 * Unused area between "s_env" and "devinfo".
+	 * Moved here because otherwise the renumbered
+	 * partitions would break the bootloader
+	 * supplied bootargs
+	 */
+	partition at 180000 {
+		label = "unused_area";
+		reg = <0x280000 0x680000>;   /* 6.5MiB */
+	};
+};
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 4049eaf..485abff 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -172,74 +172,12 @@
 };
 
 &nand {
+	/* 128MiB or 256MiB */
 	status = "okay";
 	num-cs = <1>;
 	marvell,nand-keep-config;
 	marvell,nand-enable-arbiter;
 	nand-on-flash-bbt;
-
-	partition at 0 {
-		label = "u-boot";
-		reg = <0x0000000 0x200000>;  /* 2MiB */
-		read-only;
-	};
-
-	partition at 100000 {
-		label = "u_env";
-		reg = <0x200000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 140000 {
-		label = "s_env";
-		reg = <0x240000 0x40000>;    /* 256KiB */
-	};
-
-	partition at 900000 {
-		label = "devinfo";
-		reg = <0x900000 0x100000>;   /* 1MiB */
-		read-only;
-	};
-
-	/* kernel1 overlaps with rootfs1 by design */
-	partition at a00000 {
-		label = "kernel1";
-		reg = <0xa00000 0x2800000>;  /* 40MiB */
-	};
-
-	partition at 1000000 {
-		label = "rootfs1";
-		reg = <0x1000000 0x2200000>;  /* 34MiB */
-	};
-
-	/* kernel2 overlaps with rootfs2 by design */
-	partition at 3200000 {
-		label = "kernel2";
-		reg = <0x3200000 0x2800000>; /* 40MiB */
-	};
-
-	partition at 3800000 {
-		label = "rootfs2";
-		reg = <0x3800000 0x2200000>; /* 34MiB */
-	};
-
-	/*
-	 * 38MiB, last MiB is for the BBT, not writable
-	 */
-	partition at 5a00000 {
-		label = "syscfg";
-		reg = <0x5a00000 0x2600000>;
-	};
-
-	/*
-	 * Unused area between "s_env" and "devinfo".
-	 * Moved here because otherwise the renumbered
-	 * partitions would break the bootloader
-	 * supplied bootargs
-	 */
-	partition at 180000 {
-		label = "unused_area";
-		reg = <0x280000 0x680000>;   /* 6.5MiB */
-	};
 };
 
 &mdio {
-- 
2.10.2
