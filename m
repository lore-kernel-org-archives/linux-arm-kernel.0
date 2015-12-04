From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Dec 2015 23:20:09 +0100
Subject: [PATCH] [media] exynos4-is: make VIDEO_SAMSUNG_EXYNOS4_IS tristate
Message-ID: <2086080.9y3TX8CFJu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_V4L2=m and VIDEO_SAMSUNG_EXYNOS4_IS=y, we can select the
individual drivers as built-in code when that should not be possible:

drivers/built-in.o: In function `s5pcsis_set_fmt':
policy.c:(.text+0x13afdc): undefined reference to `v4l_bound_align_image'
drivers/built-in.o: In function `s5pcsis_probe':
policy.c:(.text+0x13b440): undefined reference to `v4l2_of_parse_endpoint'
policy.c:(.text+0x13b72c): undefined reference to `v4l2_subdev_init'

Changing VIDEO_SAMSUNG_EXYNOS4_IS to tristate means that the dependency
from CONFIG_V4L2 propates to the individual Kconfig symbols and they
can only be built as loadable modules if V4L2 or any other of the
dependencies itself is a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index 40423c6c5324..57d42c6172c5 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -1,6 +1,6 @@
 
 config VIDEO_SAMSUNG_EXYNOS4_IS
-	bool "Samsung S5P/EXYNOS4 SoC series Camera Subsystem driver"
+	tristate "Samsung S5P/EXYNOS4 SoC series Camera Subsystem driver"
 	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	depends on OF && COMMON_CLK
