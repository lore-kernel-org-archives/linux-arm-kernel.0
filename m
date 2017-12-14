From: a.heider@gmail.com (Andre Heider)
Date: Thu, 14 Dec 2017 16:12:40 +0100
Subject: [PATCH] of: build dbts with symbols when CONFIG_OF_OVERLAY is set
Message-ID: <20171214151240.14555-1-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The overlay feature requires the base dtb to be built with symbols, so
lets build the dtbs with symbols when overlay support was explicitly
enabled.

With CONFIG_OF_ALL_DTBS on ARCH=arm the 989 dtb files grow about ~38% on
average.

Totals in bytes with the 3 biggest ones:

Before:
	90471	arch/arm/boot/dts/am57xx-beagle-x15-revc.dtb
	90521	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dtb
	92639	arch/arm/boot/dts/dra7-evm.dtb
	25731296	total

After:
	133203	arch/arm/boot/dts/am57xx-beagle-x15-revc.dtb
	133237	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dtb
	134545	arch/arm/boot/dts/dra7-evm.dtb
	35464440	total

Signed-off-by: Andre Heider <a.heider@gmail.com>
---

Hi,

while playing around with overlays I noticed that I needed to rebuilt
my distro's device trees because they didn't come with symbols.

Is that for a reason, maybe the not so minor increase in size?

Thanks,
Andre

 drivers/of/unittest-data/Makefile | 7 -------
 scripts/Makefile.lib              | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 32389acfa616..b65061013512 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -15,13 +15,6 @@ targets += overlay.dtb overlay.dtb.S
 targets += overlay_bad_phandle.dtb overlay_bad_phandle.dtb.S
 targets += overlay_bad_symbol.dtb overlay_bad_symbol.dtb.S
 targets += overlay_base.dtb overlay_base.dtb.S
-
-# enable creation of __symbols__ node
-DTC_FLAGS_overlay := -@
-DTC_FLAGS_overlay_bad_phandle := -@
-DTC_FLAGS_overlay_bad_symbol := -@
-DTC_FLAGS_overlay_base := -@
-
 endif
 
 .PRECIOUS: \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1ca4dcd2d500..c7ba4aa8a07a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -278,6 +278,11 @@ DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wproperty_name_chars_strict
 endif
 
+ifeq ($(CONFIG_OF_OVERLAY),y)
+# enable creation of __symbols__ node
+DTC_FLAGS += -@
+endif
+
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 
 # Generate an assembly file to wrap the output of the device tree compiler
-- 
2.15.1
