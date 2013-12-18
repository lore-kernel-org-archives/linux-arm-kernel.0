From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 18 Dec 2013 15:41:35 -0700
Subject: [PATCH V1 5/7] ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC
 interrupt.
In-Reply-To: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387406497-26430-6-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This works around a hardware bug.
Quoting from Ranjani Vaidyanathan:

All of the interrupts from the ENET block are not routed to
the GPC block. Hence ENET interrupts are not able to wake
up the SOC when the system is in WAIT mode. And the ENET
interrupt gets serviced only when another interrupt causes
the SOC to exit WAIT mode. This impacts the ENET performance.

Before this patch, ping times of a Sabre Lite board are quite
random:
ping 192.168.0.13 -i.5 -c5
PING 192.168.0.13 (192.168.0.13) 56(84) bytes of data.
64 bytes from 192.168.0.13: icmp_req=1 ttl=64 time=15.7 ms
64 bytes from 192.168.0.13: icmp_req=2 ttl=64 time=14.4 ms
64 bytes from 192.168.0.13: icmp_req=3 ttl=64 time=13.4 ms
64 bytes from 192.168.0.13: icmp_req=4 ttl=64 time=12.4 ms
64 bytes from 192.168.0.13: icmp_req=5 ttl=64 time=11.4 ms

--- 192.168.0.13 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 11.431/13.501/15.746/1.508 ms
____________________________________________________
After this patch:

ping 192.168.0.13 -i.5 -c5
PING 192.168.0.13 (192.168.0.13) 56(84) bytes of data.
64 bytes from 192.168.0.13: icmp_req=1 ttl=64 time=0.120 ms
64 bytes from 192.168.0.13: icmp_req=2 ttl=64 time=0.175 ms
64 bytes from 192.168.0.13: icmp_req=3 ttl=64 time=0.169 ms
64 bytes from 192.168.0.13: icmp_req=4 ttl=64 time=0.168 ms
64 bytes from 192.168.0.13: icmp_req=5 ttl=64 time=0.172 ms

--- 192.168.0.13 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 0.120/0.160/0.175/0.026 ms
____________________________________________________

Also, apply same change to imx6qdl-nitrogen6x.

This change may not be appropriate for all boards.
Sabre Lite uses GPIO6 as a power down output for a ov5642
camera. As this expansion board does not yet work with mainline,
this is not yet a conflict. It would be nice to have an alternative
fix for boards where this is a problem.

For example Sabre SD uses GPIO6 for I2C3_SDA. It also
has long ping times currently. But cannot use this fix
without giving up a touchscreen.

Its ping times are also random.

ping 192.168.0.19 -i.5 -c5
PING 192.168.0.19 (192.168.0.19) 56(84) bytes of data.
64 bytes from 192.168.0.19: icmp_req=1 ttl=64 time=16.0 ms
64 bytes from 192.168.0.19: icmp_req=2 ttl=64 time=15.4 ms
64 bytes from 192.168.0.19: icmp_req=3 ttl=64 time=14.4 ms
64 bytes from 192.168.0.19: icmp_req=4 ttl=64 time=13.4 ms
64 bytes from 192.168.0.19: icmp_req=5 ttl=64 time=12.4 ms

--- 192.168.0.19 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 12.451/14.369/16.057/1.316 ms

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
CC: ra5478 at freescale.com
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index ef5ce885..9909c36 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -164,6 +164,8 @@
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
 	txd3-skew-ps = <0>;
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
@@ -210,6 +212,7 @@
 				MX6QDL_ENET_PINGRP_RGMII_MD(0x1b0b0, 0x100b0)
 				/* Phy reset */
 				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x000b0
+				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index db06e40..8b620b5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -163,6 +163,8 @@
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
 	txd3-skew-ps = <0>;
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
@@ -209,6 +211,7 @@
 				MX6QDL_ENET_PINGRP_RGMII_MD(0x1b0b0, 0x100b0)
 				/* Phy reset */
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x000b0
+				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 			>;
 		};
 
-- 
1.8.1.2
