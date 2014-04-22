From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:13 +0200
Subject: [PATCH v2 09/38] memory: mvebu-devbus: add a devbus,
 keep-config property
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the mvebu-devbus Device Tree binding makes defining the
timing parameters mandatory.

However, in practice, when converting Orion5x platforms to the Device
Tree, we may not necessarily have easy access to the hardware
platforms to fetch those values which were not defined in old-style
board files: all these platforms rely on the bootloader setting the
timing parameters correctly.

In order to facilitate the migration to the Device Tree of this
platform, this commit relaxes the mvebu-devbus Device Tree binding by
introducing a 'devbus,keep-config' boolean property, which, if
defined, will ignore all timing parameters passed in the Device Tree,
and simply rely on the timing values already defined by the
bootloader.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/memory-controllers/mvebu-devbus.txt   | 29 ++++++++++++++--------
 drivers/memory/mvebu-devbus.c                      | 20 ++++++++-------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
index 55adde2..1ee3bc0 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
@@ -23,6 +23,13 @@ Required properties:
                         integer values for each chip-select line in use:
                         0 <physical address of mapping> <size>
 
+Optional properties:
+
+ - devbus,keep-config   This property can optionally be used to keep
+                        using the timing parameters set by the
+                        bootloader. It makes all the timing properties
+                        described below unused.
+
 Timing properties for child nodes:
 
 Read parameters:
@@ -31,26 +38,26 @@ Read parameters:
                         drive the AD bus after the completion of a device read.
                         This prevents contentions on the Device Bus after a read
                         cycle from a slow device.
-                        Mandatory.
+                        Mandatory, except if devbus,keep-config is used.
 
  - devbus,bus-width:    Defines the bus width, in bits (e.g. <16>).
-                        Mandatory.
+                        Mandatory, except if devbus,keep-config is used.
 
  - devbus,badr-skew-ps: Defines the time delay from from A[2:0] toggle,
                         to read data sample. This parameter is useful for
                         synchronous pipelined devices, where the address
                         precedes the read data by one or two cycles.
-                        Mandatory.
+                        Mandatory, except if devbus,keep-config is used.
 
  - devbus,acc-first-ps: Defines the time delay from the negation of
                         ALE[0] to the cycle that the first read data is sampled
                         by the controller.
-                        Mandatory.
+                        Mandatory, except if devbus,keep-config is used.
 
  - devbus,acc-next-ps:  Defines the time delay between the cycle that
                         samples data N and the cycle that samples data N+1
                         (in burst accesses).
-                        Mandatory.
+                        Mandatory, except if devbus,keep-config is used.
 
  - devbus,rd-setup-ps:  Defines the time delay between DEV_CSn assertion to
 			DEV_OEn assertion. If set to 0 (default),
@@ -58,8 +65,8 @@ Read parameters:
                         This parameter has no affect on <acc-first-ps> parameter
                         (no affect on first data sample). Set <rd-setup-ps>
                         to a value smaller than <acc-first-ps>.
-                        Mandatory for "marvell,mvebu-devbus"
-                        compatible string, ignored otherwise.
+                        Mandatory for "marvell,mvebu-devbus" compatible string,
+                        except if devbus,keep-config is used.
 
  - devbus,rd-hold-ps:   Defines the time between the last data sample to the
 			de-assertion of DEV_CSn. If set to 0 (default),
@@ -70,8 +77,8 @@ Read parameters:
                         last data sampled. Also this parameter has no
                         affect on <turn-off-ps> parameter.
                         Set <rd-hold-ps> to a value smaller than <turn-off-ps>.
-                        Mandatory for "marvell,mvebu-devbus"
-                        compatible string, ignored otherwise.
+                        Mandatory for "marvell,mvebu-devbus" compatible string,
+                        except if devbus,keep-config is used.
 
 Write parameters:
 
@@ -96,8 +103,8 @@ Write parameters:
  - devbus,sync-enable: Synchronous device enable.
                        1: True
                        0: False
-                       Mandatory for "marvell,mvebu-devbus" compatible
-                       string, ignored otherwise.
+                       Mandatory for "marvell,mvebu-devbus" compatible string,
+                       except if devbus,keep-config is used.
 
 An example for an Armada XP GP board, with a 16 MiB NOR device as child
 is showed below. Note that the Device Bus driver is in charge of allocating
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index c8f3dad..ff7138f 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -310,16 +310,18 @@ static int mvebu_devbus_probe(struct platform_device *pdev)
 	dev_dbg(devbus->dev, "Setting timing parameter, tick is %lu ps\n",
 		devbus->tick_ps);
 
-	/* Read the Device Tree node */
-	err = devbus_get_timing_params(devbus, node, &r, &w);
-	if (err < 0)
-		return err;
+	if (!of_property_read_bool(node, "devbus,keep-config")) {
+		/* Read the Device Tree node */
+		err = devbus_get_timing_params(devbus, node, &r, &w);
+		if (err < 0)
+			return err;
 
-	/* Set the new timing parameters */
-	if (of_device_is_compatible(node, "marvell,orion-devbus"))
-		devbus_orion_set_timing_params(devbus, node, &r, &w);
-	else
-		devbus_armada_set_timing_params(devbus, node, &r, &w);
+		/* Set the new timing parameters */
+		if (of_device_is_compatible(node, "marvell,orion-devbus"))
+			devbus_orion_set_timing_params(devbus, node, &r, &w);
+		else
+			devbus_armada_set_timing_params(devbus, node, &r, &w);
+	}
 
 	/*
 	 * We need to create a child device explicitly from here to
-- 
1.9.2
