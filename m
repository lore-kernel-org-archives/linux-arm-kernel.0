From: javi.merino@arm.com (Javi Merino)
Date: Mon, 10 Jun 2013 11:50:15 +0100
Subject: [PATCH v2] ARM: document the bigger pagetables needed for LPAE
Message-ID: <1370861415-5587-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Booting documentation assumes that the initial pagetables are
16KiB but since 1b6ba46 (ARM: LPAE: MMU setup for the 3-level page
table format) they are 20KiB for LPAE kernels.  Thus, the
recommendation to put atags or the dtb in the first 16KiB is wrong,
there's only 12KiB of space there in LPAE kernels, so update the
documentation accordingly.

Signed-off-by: Javi Merino <javi.merino@arm.com>
Acked-by: Rob Landley <rob@landley.net>
---
 Documentation/arm/Booting |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 0c1f475..e3cab63 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -75,6 +75,16 @@ The boot loader must provide either a tagged list or a dtb image for
 passing configuration data to the kernel.  The physical address of the
 boot data is passed to the kernel in register r2.
 
+The low memory layout is as follows:
+
+   0k-12k   boot data (tagged list or device tree)
+  12k-32k   page tables
+  32k-xxx   kernel image
+
+The page tables go from 16k-32k in !CONFIG_ARM_LPAE kernels but in
+general it's safer to assume that you only have 12KiB for your boot
+data.
+
 4a. Setup the kernel tagged list
 --------------------------------
 
@@ -105,7 +115,7 @@ The tagged list should be stored in system RAM.
 
 The tagged list must be placed in a region of memory where neither
 the kernel decompressor nor initrd 'bootp' program will overwrite
-it.  The recommended placement is in the first 16KiB of RAM.
+it.  The recommended placement is in the first 12KiB of RAM.
 
 4b. Setup the device tree
 -------------------------
@@ -120,7 +130,7 @@ tagged list.
 The boot loader must pass at a minimum the size and location of the
 system memory, and the root filesystem location.  The dtb must be
 placed in a region of memory where the kernel decompressor will not
-overwrite it.  The recommended placement is in the first 16KiB of RAM
+overwrite it.  The recommended placement is in the first 12KiB of RAM
 with the caveat that it may not be located at physical address 0 since
 the kernel interprets a value of 0 in r2 to mean neither a tagged list
 nor a dtb were passed.
@@ -137,8 +147,9 @@ then it is legal for the boot loader to call the zImage in flash
 directly.
 
 The zImage may also be placed in system RAM (at any location) and
-called there.  Note that the kernel uses 16K of RAM below the image
-to store page tables.  The recommended placement is 32KiB into RAM.
+called there.  Note that the kernel may use up to 20KiB of RAM below
+the image to store page tables.  The recommended placement is 32KiB
+into RAM.
 
 In either case, the following conditions must be met:
 
-- 
1.7.9.5
