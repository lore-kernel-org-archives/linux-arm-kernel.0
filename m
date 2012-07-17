From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 17 Jul 2012 12:55:53 +0100
Subject: Device tree.
Message-ID: <500552C9.4090107@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've found some references to this in the mailinglist archives but 
nothing conclusive.

Whats the recommended way of dealing with devicetree when one is stuck 
with an unco-operative bootloader?

I've made a small hack (below) to allow me to append a .dtb to the end 
of the kernel image. I note that other similar hacks have not been 
picked up, but I can't see why. Or I've missed the one that did get chosen.

TTFN!

-Ian

------------------------------- arch/arm/Kconfig 
-------------------------------
index 519b5e0..cd82cbc 100644
@@ -1105,6 +1105,10 @@ source "arch/arm/mach-vt8500/Kconfig"

  source "arch/arm/mach-w90x900/Kconfig"

+config EMBEDDED_DTB
+    string "Embedded device tree blob" if OF
+    default ""
+
  # Definitions to make life easier
  config ARCH_ACORN
      bool

---------------------------- arch/arm/boot/Makefile 
----------------------------
index c877087..8e43741 100644
@@ -44,6 +44,9 @@ $(obj)/xipImage: FORCE
      @echo 'Kernel not configured for XIP (CONFIG_XIP_KERNEL!=y)'
      @false

+#append Device Tree .dtb file after vmlinux
+cmd_do_append_dtb = if [ "$(CONFIG_EMBEDDED_DTB)" != "" ]; then cat 
$(CONFIG_EMBEDDED_DTB) >> $@ ; fi
+
  $(obj)/Image: vmlinux FORCE
      $(call if_changed,objcopy)
      @echo '  Kernel: $@ is ready'
@@ -53,6 +56,7 @@ $(obj)/compressed/vmlinux: $(obj)/Image FORCE

  $(obj)/zImage:    $(obj)/compressed/vmlinux FORCE
      $(call if_changed,objcopy)
+    $(call if_changed,do_append_dtb)
      @echo '  Kernel: $@ is ready'

  endif
