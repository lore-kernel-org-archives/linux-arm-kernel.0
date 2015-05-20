From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 20 May 2015 11:47:52 +0100
Subject: [PATCH v2 0/5]  arm64: Juno DT updates and new DT for Juno R1
In-Reply-To: <555B1A77.9070403@arm.com>
References: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
 <555B1A77.9070403@arm.com>
Message-ID: <20150520104752.GM2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 12:11:51PM +0100, Sudeep Holla wrote:
> 
> 
> On 18/05/15 18:28, Liviu Dudau wrote:
> > This series restructures the Juno DT files and introduces the DT
> > for the new Juno R1. The board is an update of the Juno R0 with
> > support for PCIe, but the current series only brings the board to
> > parity with Juno R0. The series that enable the PCIe Generic Host
> > Bridge to be used on Juno R1 will be posted separately.
> >
> > Changes from v1:
> >   - Moved memory node inside juno-base.dtsi as this is common between
> >     boards and unlikely to change soon.
> >   - Added "arm,juno-r1" as compatible string in juno-r1.dts at Jon Medhurst's
> >     suggestion.
> 
> It would be good to add these juno* compatible somewhere in the binding
> document. In past I have seen checkpatch complaining about missing
> compatibles on vexpress(which is annoying if you are not adding it
> but fixing a bug around existing node).

How about something like this:


8<---------------------------------------------------------------------------
>From 55b575f3d0888e6134c492b66a3fa12c9cceca02 Mon Sep 17 00:00:00 2001
From: Liviu Dudau <Liviu.Dudau@arm.com>
Date: Wed, 20 May 2015 11:42:37 +0100
Subject: [PATCH] Documentation: bindings: Add DT bindings for ARM Juno boards.

List the required properties and nodes used to describe the
ARM Juno boards.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 Documentation/devicetree/bindings/arm/arm-boards | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index b78564b..1a70997 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -157,3 +157,69 @@ Example:
 
 	};
 };
+
+ARM Versatile Express Boards
+-----------------------------
+For details on the device tree bindings for ARM Versatile Express boards
+please consult the vexpress.txt file in the same directory as this file.
+
+ARM Juno Boards
+----------------
+The Juno boards are targeting development for AArch64 systems. The first
+iteration, Juno r0, is a vehicle for evaluating big.LITTLE on AArch64,
+with the second iteration, Juno r1, mainly aimed at development of PCIe
+based systems. Juno r1 also has support for AXI masters placed on the TLX
+connectors to join the coherency domain.
+
+Juno boards are described in a similar way to ARM Versatile Express boards,
+with the motherboard part of the hardware being described in a separate file
+to highlight the fact that is part of the support infrastructure for the SoC.
+Juno device tree bindings also share the Versatile Express bindings as
+described under the RS1 memory mapping.
+
+Required properties (in root node):
+	compatible = "arm,juno";	/* For Juno r0 board */
+	compatible = "arm,juno-r1";	/* For Juno r1 board */
+
+Required nodes:
+The description for the board must include:
+   - a "psci" node describing the boot method used for the secondary CPUs.
+     A detailed description of the bindings used for "psci" nodes is present
+     in the psci.txt file.
+   - a "cpus" node describing the available cores and their associated
+     "enable-method"s. For more details see cpus.txt file.
+
+Example:
+
+/dts-v1/;
+/ {
+	model = "ARM Juno development board (r0)";
+	compatible = "arm,juno", "arm,vexpress";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		A57_0: cpu at 0 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		.....
+
+		A53_0: cpu at 100 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		.....
+	};
+
+};
-- 
2.4.0

>8---------------------------------------------------------------------------

> 
> Otherwise the whole series looks good to me. So feel free to add
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks,
Liviu

> 
> Regards,
> Sudeep
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
