From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 14:37:05 +0100
Subject: [PATCH] sound/oss: remove VIRT_TO_BUS dependency
Message-ID: <1607667.Zg3De8gXcs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OSS sound drivers used to rely on virt_to_bus(), but don't any more,
so we can remove the Kconfig dependency.

As a lot of architectures don't provide VIRT_TO_BUS any more, removing
the dependency in sounds/oss/ would make the deprecated drivers appear
there, which we probably don't want. Instead I'm replacing the
simple dependency with 'VIRT_TO_BUS || RPC || NETWINDER' so we can
still build these sound drivers for the platforms that need them,
but don't change anything on other architectures.

As a follow-up, we can remove the virt_to_bus() implementation
and Kconfig symbol in the ARM architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 48568fdf847f..4033fe58f0cf 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -240,7 +240,7 @@ config MSND_FIFOSIZE
 
 menuconfig SOUND_OSS
 	tristate "OSS sound modules"
-	depends on ISA_DMA_API && VIRT_TO_BUS
+	depends on ISA_DMA_API && (VIRT_TO_BUS || ARCH_RPC || ARCH_NETWINDER)
 	depends on !GENERIC_ISA_DMA_SUPPORT_BROKEN
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
