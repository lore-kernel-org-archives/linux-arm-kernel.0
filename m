From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sun, 6 Jan 2013 04:34:55 +0100
Subject: Reboot hangs on Kirkwood ns2 boards with 3.8-rc2
Message-ID: <20130106033455.GH1357@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew and Jason,

While testing 3.8-rc2 on the ns2 boards (DT based), I noticed that
reboot is not working. After issuing a reboot, the kernel hangs. No
error messages are displayed. Moreover, on my non-DT Kirkwood boards,
reboot is working as expected.

Am I the only one to experiment this issue ?

After some painful investigations, I found out that my problem may be
related with the device tree binding addition to the driver ehci-orion.
I still don't understand exactly why, but if I add the "clocks" property
to the ehci node, reboot works.

diff --git a/arch/arm/boot/dts/kirkwood.dtsi
b/arch/arm/boot/dts/kirkwood.dtsi
index 7735cee..110d6cb 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -144,6 +144,7 @@
                        compatible = "marvell,orion-ehci";
                        reg = <0x50000 0x1000>;
                        interrupts = <19>;
+                       clocks = <&gate_clk 3>;
                        status = "okay";
                };

Do you have any idea ?

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130106/d6f72a2a/attachment.sig>
