From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue,  3 Feb 2015 18:49:26 -0800
Subject: [PATCH] Documentation: arm: Update for DT-only platforms
Message-ID: <1423018169-31221-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation specified that a machine type is mandatory and made
that assumption in a few places.  However, for DT-only platforms, the
current advice is that no machine type should be registered, so update
accordingly.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 Documentation/arm/Booting |  9 +++++++--
 Documentation/arm/README  | 15 +++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 371814a..83c1df2 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -58,13 +58,18 @@ serial format options as described in
 --------------------------
 
 Existing boot loaders:		OPTIONAL
-New boot loaders:		MANDATORY
+New boot loaders:		MANDATORY except for DT-only platforms
 
 The boot loader should detect the machine type its running on by some
 method.  Whether this is a hard coded value or some algorithm that
 looks at the connected hardware is beyond the scope of this document.
 The boot loader must ultimately be able to provide a MACH_TYPE_xxx
-value to the kernel. (see linux/arch/arm/tools/mach-types).
+value to the kernel. (see linux/arch/arm/tools/mach-types).  This
+should be passed to the kernel in register r1.
+
+For DT-only platforms, the machine type will be determined by device
+tree.  set the machine type to all ones (~0).  This is not strictly
+necessary, but assures that it will not match any existing types.
 
 4. Setup boot data
 ------------------
diff --git a/Documentation/arm/README b/Documentation/arm/README
index aea3409..9d1e5b2 100644
--- a/Documentation/arm/README
+++ b/Documentation/arm/README
@@ -185,13 +185,20 @@ Kernel entry (head.S)
   board devices are used, or the device is setup, and provides that
   machine specific "personality."
 
-  This fine-grained machine specific selection is controlled by the machine
-  type ID, which acts both as a run-time and a compile-time code selection
-  method.
+  For platforms that support device tree (DT), the machine selection is
+  controlled at runtime by passing the device tree blob to the kernel.  At
+  compile-time, support for the machine type must be selected.  This allows for
+  a single multiplatform kernel build to be used for several machine types.
 
-  You can register a new machine via the web site at:
+  For platforms that do not use device tree, this machine selection is
+  controlled by the machine type ID, which acts both as a run-time and a
+  compile-time code selection method.  You can register a new machine via the
+  web site at:
 
     <http://www.arm.linux.org.uk/developer/machines/>
 
+  Note: Please do not register a machine type for DT-only platforms.  If your
+  platform is DT-only, you do not need a registered machine type.
+
 ---
 Russell King (15/03/2004)
-- 
1.9.1
