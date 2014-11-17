From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Nov 2014 14:42:55 +0100
Subject: [PATCH v5 61/61] Documentation: dmaengine: Update the documentation
In-Reply-To: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1416231775-31252-62-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have splitted device_control and removed device_slave_caps in favor
of a few dma_device variables, update the documentation accordingly.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/dmaengine/provider.txt | 93 ++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/Documentation/dmaengine/provider.txt b/Documentation/dmaengine/provider.txt
index 766658ccf235..2c391cfe37eb 100644
--- a/Documentation/dmaengine/provider.txt
+++ b/Documentation/dmaengine/provider.txt
@@ -113,6 +113,31 @@ need to initialize a few fields in there:
   * channels:	should be initialized as a list using the
 		INIT_LIST_HEAD macro for example
 
+  * src_addr_widths:
+    - should contain a bitmask of the supported source transfer width
+
+  * dst_addr_widths:
+    - should contain a bitmask of the supported destination transfer
+      width
+
+  * directions:
+    - should contain a bitmask of the supported slave directions
+      (i.e. excluding mem2mem transfers)
+
+  * residue_granularity:
+    - Granularity of the transfer residue reported to dma_set_residue.
+    - This can be either:
+      + Descriptor
+        -> Your device doesn't support any kind of residue
+           reporting. The framework will only know that a particular
+           transaction descriptor is done.
+      + Segment
+        -> Your device is able to report which chunks have been
+           transferred
+      + Burst
+        -> Your device is able to report which burst have been
+           transferred
+
   * dev: 	should hold the pointer to the struct device associated
 		to your current driver instance.
 
@@ -274,48 +299,32 @@ supported.
        account the current period.
      - This function can be called in an interrupt context.
 
-   * device_control
-     - Used by client drivers to control and configure the channel it
-       has a handle on.
-     - Called with a command and an argument
-       + The command is one of the values listed by the enum
-         dma_ctrl_cmd. The valid commands are:
-         + DMA_PAUSE
-           + Pauses a transfer on the channel
-           + This command should operate synchronously on the channel,
-             pausing right away the work of the given channel
-         + DMA_RESUME
-           + Restarts a transfer on the channel
-           + This command should operate synchronously on the channel,
-             resuming right away the work of the given channel
-         + DMA_TERMINATE_ALL
-           + Aborts all the pending and ongoing transfers on the
-             channel
-           + This command should operate synchronously on the channel,
-             terminating right away all the channels
-         + DMA_SLAVE_CONFIG
-           + Reconfigures the channel with passed configuration
-           + This command should NOT perform synchronously, or on any
-             currently queued transfers, but only on subsequent ones
-           + In this case, the function will receive a
-             dma_slave_config structure pointer as an argument, that
-             will detail which configuration to use.
-           + Even though that structure contains a direction field,
-             this field is deprecated in favor of the direction
-             argument given to the prep_* functions
-         + FSLDMA_EXTERNAL_START
-           + TODO: Why does that even exist?
-       + The argument is an opaque unsigned long. This actually is a
-         pointer to a struct dma_slave_config that should be used only
-         in the DMA_SLAVE_CONFIG.
-
-  * device_slave_caps
-    - Called through the framework by client drivers in order to have
-      an idea of what are the properties of the channel allocated to
-      them.
-    - Such properties are the buswidth, available directions, etc.
-    - Required for every generic layer doing DMA transfers, such as
-      ASoC.
+   * device_config
+     - Reconfigures the channel with the configuration given as
+       argument
+     - This command should NOT perform synchronously, or on any
+       currently queued transfers, but only on subsequent ones
+     - In this case, the function will receive a dma_slave_config
+       structure pointer as an argument, that will detail which
+       configuration to use.
+     - Even though that structure contains a direction field, this
+       field is deprecated in favor of the direction argument given to
+       the prep_* functions
+
+   * device_pause
+     - Pauses a transfer on the channel
+     - This command should operate synchronously on the channel,
+       pausing right away the work of the given channel
+
+   * device_resume
+     - Resumes a transfer on the channel
+     - This command should operate synchronously on the channel,
+       pausing right away the work of the given channel
+
+   * device_terminate_all
+     - Aborts all the pending and ongoing transfers on the channel
+     - This command should operate synchronously on the channel,
+       terminating right away all the channels
 
 Misc notes (stuff that should be documented, but don't really know
 where to put them)
-- 
2.1.1
