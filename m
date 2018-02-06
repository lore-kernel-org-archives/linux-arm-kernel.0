From: mpatocka@redhat.com (Mikulas Patocka)
Date: Tue, 6 Feb 2018 16:59:22 -0500 (EST)
Subject: Device tree bug in armada-8040-mcbin.dts
Message-ID: <alpine.LRH.2.02.1802061650060.4974@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

When the MacchiatoBIN kernel is compiled with CONFIG_PM=y, it is 
frequently reporing this error (the error happens every time some I/O on 
built-in eMMC happens):

"mmc0: Switching to 3.3V signalling voltage failed"

The problem is that the "&ap_sdhci0" device tree node asserts that the 
controller doesn't support 1.8v, but it attaches it to the fixed voltage 
regulator "v_vddo_h" that only supplies 1.8V.

Should it be attached to the 3.3V regulator instead? Or should the 
"vqmmc-supply" statemet be deleted? Or should the statement "no-1-8-v" be 
deleted?

Mikulas



This patch silences the error (though I don't know if it should be 
attached to a different regulator instead).

---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |    1 -
 1 file changed, 1 deletion(-)

Index: linux-4.14.13/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
===================================================================
--- linux-4.14.13.orig/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts	2017-11-29 02:52:18.000000000 +0100
+++ linux-4.14.13/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts	2018-01-14 14:54:59.000000000 +0100
@@ -115,7 +115,6 @@
 	no-sdio;
 	non-removable;
 	status = "okay";
-	vqmmc-supply = <&v_vddo_h>;
 };
 
 &cpm_i2c0 {
