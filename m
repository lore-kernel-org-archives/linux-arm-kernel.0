From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 20 Feb 2017 17:22:38 +0000
Subject: [PATCH] ARM: dts: kirkwood: Fix SATA pinmux-ing for TS419
In-Reply-To: <20170220175049.45f319bb@free-electrons.com>
References: <20170218003251.GC4152@decadent.org.uk>
 <20170220135955.63fbcaa3@free-electrons.com>
 <1487608825.2885.1.camel@decadent.org.uk>
 <20170220175049.45f319bb@free-electrons.com>
Message-ID: <1487611358.2885.3.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-02-20 at 17:50 +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 20 Feb 2017 16:40:25 +0000, Ben Hutchings wrote:
> 
> > That is precisely what I intended.??20-23 are used by the second
> > Ethernet port.??The old board code doesn't assign 4 or 5 at all.
> 
> Then I believe it would be more explicit to have separate pin muxing
> configurations for SATA on this board.

You mean, define additional pinmux nodes and override the pinctrl-0
property of &sata?  More like this:

--- a/arch/arm/boot/dts/kirkwood-ts419.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts419.dtsi
@@ -73,3 +73,19 @@
 		phy-handle = <&ethphy1>;
 	};
 };
+
+&pinctrl {
+	pmx_sata0_ts419: pmx-sata0-ts419 {
+		marvell,pins = "mpp15";
+		marvell,function = "sata0";
+	};
+
+	pmx_sata1_ts419: pmx-sata1-ts419 {
+		marvell,pins = "mpp16";
+		marvell,function = "sata1";
+	};
+};
+
+&sata {
+	pinctrl-0 = <&pmx_sata0_ts419 &pmx_sata1_ts419>;
+};
--- END ---

Ben.

-- 
Ben Hutchings
If at first you don't succeed, you're doing about average.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170220/f795a5b5/attachment-0001.sig>
