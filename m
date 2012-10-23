From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2012 10:08:05 +0100
Subject: IMX breaking Versatile Express build
Message-ID: <20121023090805.GQ21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest Versatile Express specific build is failing due to:

arch/arm/mach-imx/built-in.o: In function `imx_cpu_die':
platform-imx-dma.c:(.text+0x1624): undefined reference to `imx_enable_cpu'
arch/arm/mach-imx/built-in.o: In function `imx_boot_secondary':
platform-imx-dma.c:(.cpuinit.text+0x14): undefined reference to `imx_set_cpu_jump'
platform-imx-dma.c:(.cpuinit.text+0x20): undefined reference to `imx_enable_cpu'

Config:

http://www.home.arm.linux.org.uk/developer/build/file.php?type=config&idx=2464

This does not seem to have any IMX support selected.

Thanks to the reduced default configuration files, Kconfig is deciding to
select the new MULTI_* options on these target specific Kconfigs, which
may have some reason as to the above.

However, even so, we should _not_ be seeing such build failures.  It looks
to me like platform-imx-dma is missing some kind of dependency.
