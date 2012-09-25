From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Sep 2012 13:32:18 +0200
Subject: [PATCH V2] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
Message-ID: <1348572738-9743-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the kernel unconditionally adds "local-mac-address" and
"mac-address" properties under both FEC ethernet DT nodes in case
the update_fec_mac_prop() function is called. These properties are
loaded with MAC address compiled from vendors OUI and a per-device
NIC saved in OCOTP storage.

Some more advanced bootloaders do augment the DT passed to the kernel
by these properties already. In such case, it is wrong for kernel to
override these values.

Adjust the FEC MAC address loading so that in case the DT properties
are already present in the DT passed from the bootloader, skip the
loading from OCOTP altogether. If the DT properties are not present,
load them from OCOTP.

Note that the later case will lead to zeroed out MAC address if OCOTP
is not programmed. This will lead to FEC not working at all.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |    4 ++++
 1 file changed, 4 insertions(+)

V2: Assign from variable before checking for the "local-mac-address" property.
    As Shawn explained, this prevents the function from repeatedly finding the
    first FEC.

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 86a9343..c1f3c79 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -175,8 +175,12 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 		np = of_find_compatible_node(from, NULL, "fsl,imx28-fec");
 		if (!np)
 			return;
+
 		from = np;
 
+		if (of_get_property(np, "local-mac-address", NULL))
+			continue;
+
 		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
 		if (!newmac)
 			return;
-- 
1.7.10.4
