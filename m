From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 25 Feb 2013 11:44:28 -0300
Subject: [PATCH v2 3/3] arm: sunxi: Add useful information about sunxi clocks
In-Reply-To: <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1361803468-9899-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains useful bits of information about the sunxi clocks
that may help and/or be interesting for current and future developers.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/arm/sunxi/clocks.txt | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/arm/sunxi/clocks.txt

diff --git a/Documentation/arm/sunxi/clocks.txt b/Documentation/arm/sunxi/clocks.txt
new file mode 100644
index 0000000..e09a88a
--- /dev/null
+++ b/Documentation/arm/sunxi/clocks.txt
@@ -0,0 +1,56 @@
+Frequently asked questions about the sunxi clock system
+=======================================================
+
+This document contains useful bits of information that people tend to ask
+about the sunxi clock system, as well as accompanying ASCII art when adequate.
+
+Q: Why is the main 24MHz oscillator gatable? Wouldn't that break the
+   system?
+
+A: The 24MHz oscillator allows gating to save power. Indeed, if gated
+   carelessly the system would stop functioning, but with the right
+   steps, one can gate it and keep the system running. Consider this
+   simplified suspend example:
+
+   While the system is operational, you would see something like
+
+      24MHz         32kHz
+       |
+      PLL1
+       \
+        \_ CPU Mux
+             |
+           [CPU]
+
+   When you are about to suspend, you switch the CPU Mux to the 32kHz
+   oscillator:
+
+      24Mhz         32kHz
+       |              |
+      PLL1            |
+                     /
+           CPU Mux _/
+             |
+           [CPU]
+
+    Finally you can gate the main oscillator
+
+                    32kHz
+                      |
+                      |
+                     /
+           CPU Mux _/
+             |
+           [CPU]
+
+Q: Were can I learn more about the sunxi clocks?
+
+A: The linux-sunxi wiki contains a page documenting the clock registers,
+   you can find it at
+
+        http://linux-sunxi.org/A10/CCM
+
+   The authoritative source for information at this time is the ccmu driver
+   released by Allwinner, you can find it at
+
+        https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.0/arch/arm/mach-sun4i/clock/ccmu
-- 
1.8.2.rc0
