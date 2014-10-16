From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Oct 2014 09:31:20 +0100
Subject: Latest build test randconfig errors
Message-ID: <20141016083120.GN27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cause seems to be a missing dependency between the Tegra DRM
code and COMMON_CLK, caused by:

commit 158b50aefa14ba18ee94b691f83a7e5d30539433
Author: Thierry Reding <treding@nvidia.com>
Date:   Wed Nov 20 20:39:35 2013 +0100

    drm/tegra: Increase compile test coverage

ARCH_MULTIPLATFORM would have selected COMMON_CLK, and ARCH_TEGRA
requires ARCH_MULTIPLATFORM to be set so that part was redundant
in the original dependencies:

menuconfig ARCH_TEGRA
        bool "NVIDIA Tegra" if ARCH_MULTI_V7

Here's the errors:

drivers/built-in.o: In function `tegra_output_rgb_setup_clock':
debugfs.c:(.text+0x9b5d0): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_dc_rgb_probe':
debugfs.c:(.text+0x9b6a0): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_output_hdmi_check_mode':
debugfs.c:(.text+0x9b9e0): undefined reference to `clk_get_parent'
drivers/built-in.o: In function `tegra_output_hdmi_setup_clock':
debugfs.c:(.text+0x9ba24): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_hdmi_probe':
debugfs.c:(.text+0x9da80): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_output_dsi_setup_clock':
debugfs.c:(.text+0x9e12c): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_dsi_probe':
debugfs.c:(.text+0x9f374): undefined reference to `clk_get_parent'
debugfs.c:(.text+0x9f384): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_output_sor_disable':
debugfs.c:(.text+0x9f860): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_output_sor_setup_clock':
debugfs.c:(.text+0x9ff00): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `tegra_output_sor_enable':
debugfs.c:(.text+0xa0318): undefined reference to `clk_set_parent'
drivers/built-in.o: In function `hdmi_runtime_resume':
debugfs.c:(.text+0x2653e0): undefined reference to `clk_set_parent'
drivers/built-in.o:debugfs.c:(.text+0x2662c4): more undefined references to `clk_set_parent' follow
make[1]: *** [vmlinux] Error 1
make[1]: Target `uImage' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `uImage' not remade because of errors.
make: Target `dtbs' not remade because of errors.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
