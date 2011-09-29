From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 23:27:12 +0100
Subject: Patch 7022 bug
Message-ID: <20110929222712.GC21718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noticed this in linux-next's build logs for assabet's defconfig:

/opt/crosstool/gcc-4.4.0-nolibc/arm-linux/bin/arm-linux-ld:--defsym zreladdr=: syntax error

@@ -1,6 +1,7 @@
-   zreladdr-y  := 0xc0008000
 ifeq ($(CONFIG_ARCH_SA1100),y)
-   zreladdr-$(CONFIG_SA1111)           := 0xc0208000
+   zreladdr-$(CONFIG_SA1111)           += 0xc0208000
+else
+   zreladdr-y  += 0xc0008000

You deleted the initial zreladdr-y, which means that in the case of
ARCH_SA1100=y and SA1111=n, no zreladdr is set.
