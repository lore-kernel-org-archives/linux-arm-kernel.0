From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 16:14:16 +0200
Subject: [PATCH] samples: build configfs sample on when enabled
Message-ID: <6271650.CdczvJuMsL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most samples have their own Kconfig option, but for some reason
the configfs sample does not have one and gets built unconditionally
when CONFIG_SAMPLES is enabled, which fails if CONFIG_CONFIGFS_FS
is not:

ERROR: "configfs_unregister_subsystem" [samples/configfs/configfs_sample.ko] undefined!
ERROR: "configfs_register_subsystem" [samples/configfs/configfs_sample.ko] undefined!

This adds a new Kconfig symbol to mirror the existing method and
only let the user enable this sample if configfs is present.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/samples/Kconfig b/samples/Kconfig
index fbd55eefa418..b283dc2e8ed6 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -5,6 +5,12 @@ menuconfig SAMPLES
 
 if SAMPLES
 
+config SAMPLE_CONFIGFS
+	tristate "Build configfs sample -- loadable modules only"
+	depends on CONFIGFS_FS && m
+	help
+	  This builds the same for configfs
+
 config SAMPLE_TRACE_EVENTS
 	tristate "Build trace_events examples -- loadable modules only"
 	depends on EVENT_TRACING && m
diff --git a/samples/configfs/Makefile b/samples/configfs/Makefile
index 4d3c8b668f06..b9153ed0b7d6 100644
--- a/samples/configfs/Makefile
+++ b/samples/configfs/Makefile
@@ -1,2 +1 @@
-
-obj-m += configfs_sample.o
+obj-$(CONFIG_SAMPLE_CONFIGFS) += configfs_sample.o
