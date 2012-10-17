From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Oct 2012 14:03:27 +0000
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201210171403.27535.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 October 2012, Stephen Warren wrote:
> Rob, Arnd, Olof, I'd particularly like feedback on whether the following:
> 
> #include "../../mach-tegra/iomap.h"
> 
> in arch/arm/include/debug/tegra.S is acceptable. I'd really like to
> continue to #include a header to share the defines to Tegra physical
> memory layout and virtual based addresses with Tegra's io.c's struct
> map_desc entries, so they can't get out of sync. So, the include can
> either use the relative path as quoted above (which I don't think will
> cause any significant maintenance issue), or Tegra's iomap.h would have
> to be moved somewhere public so e.g. <tegra-iomap.h> could be included.

I don't have a good answer for this unfortunately. I wouldn't want relative
include paths to take over because they can paper over a lot of other
problems when people get lazy.

> Second, is the Kconfig.debug change reasonable? I guess I could remove
> the second choice menu I added, and just put all the options in the main
> "Kernel low-level debugging port" choice. However, that would make the
> "if" statements in "config DEBUG_LL_INCLUDE" rather more unwieldy.

It looks ok to me in principle, but you could also solve this by making
DEBUG_TEGRA_UART a silent option like this:

@@ -345,6 +345,46 @@ choice
                  Say Y here if you want kernel low-level debugging support
                  on SOCFPGA based platforms.

+       config DEBUG_TEGRA_UARTA
+               depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+               bool "Use Tegra UARTA for low-level debug"
+               help
+                 Say Y here if you want kernel low-level debugging support
+                 on Tegra based platforms.
+
+       config DEBUG_TEGRA_UARTB
+               depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+               bool "Use Tegra UARTB for low-level debug"
+               help
+                 Say Y here if you want kernel low-level debugging support
+                 on Tegra based platforms.
+
+       config DEBUG_TEGRA_UARTC
+               depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+               bool "Use Tegra UARTC for low-level debug"
+               help
+                 Say Y here if you want kernel low-level debugging support
+                 on Tegra based platforms.
+
+       config DEBUG_TEGRA_UARTD
+               depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+               bool "Use Tegra UARTD for low-level debug"
+               help
+                 Say Y here if you want kernel low-level debugging support
+                 on Tegra based platforms.
+
+       config DEBUG_TEGRA_UARTE
+               depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+               bool "Use Tegra UARTE for low-level debug"
+               help
+                 Say Y here if you want kernel low-level debugging support
+                 on Tegra based platforms.
+
        config DEBUG_VEXPRESS_UART0_DETECT
                bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
                depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -409,6 +416,36 @@ choice
 
 endchoice
 
+config DEBUG_TEGRA_UART
+	bool


I don't have a strong preference either way.

	ARnd
