From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Aug 2011 15:09:12 +0200
Subject: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314191356-10963-7-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device-tree node for the spinlock.
Remove the static device build code if CONFIG_OF
is set.
Update the hwspinlock driver to use the of_match method.
Add the information in Documentation/devicetree.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/boot/dts/omap4.dtsi         |    5 +++++
 arch/arm/mach-omap2/Makefile         |    6 +++++-
 drivers/hwspinlock/omap_hwspinlock.c |   11 +++++++++++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a3efe76..231d7b4 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -105,5 +105,10 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0200>;
 		};
+
+		spinlock {
+			compatible = "ti,omap-spinlock";
+			hwmods = "spinlock";
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 79e42a1..6ab9116 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -263,9 +263,13 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
 
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
-obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
 
 disp-$(CONFIG_OMAP2_DSS)		:= display.o
 obj-y					+= $(disp-m) $(disp-y)
 
 obj-y					+= common-board-devices.o twl-common.o
+
+# Do not build static device init code in case of DT build
+ifneq ($(CONFIG_OF),y)
+obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
+endif
diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index a8f0273..09dd132 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -203,11 +203,22 @@ static int omap_hwspinlock_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id spinlock_match[] = {
+	{.compatible = "ti,omap-spinlock", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, spinlock_match);
+#else
+#define spinlock_match NULL
+#endif
+
 static struct platform_driver omap_hwspinlock_driver = {
 	.probe		= omap_hwspinlock_probe,
 	.remove		= omap_hwspinlock_remove,
 	.driver		= {
 		.name	= "omap_hwspinlock",
+		.of_match_table = spinlock_match,
 	},
 };
 
-- 
1.7.0.4
