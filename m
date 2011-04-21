From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 21 Apr 2011 12:01:32 -0600
Subject: [PATCH 4/4] ARM: tegra: Harmony: Register and configure WM8903 IRQ
	GPIO
In-Reply-To: <1303408892-7472-1-git-send-email-swarren@nvidia.com>
References: <1303408892-7472-1-git-send-email-swarren@nvidia.com>
Message-ID: <1303408892-7472-5-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Technically, we need to request and configure the GPIO used as the WM8903
interrupt. This prevents conflicting registrations, and assures that the
GPIO is correctly configured in all cases, e.g. if the bootloader left the
GPIO in some unexpected state.

In practice, the previous code works as-is, at least when using ChromeOS's
U-Boot as the boot-loader.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Note: For Harmony, we don't have to do this inside harmony_pinmux_init
(see Seaboard's seaboard_pinmux_init in patch 3 in this series) because
pingroup SPIC pins are all input on Harmony.

 arch/arm/mach-tegra/board-harmony.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 30e18bc..87cbc4b 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -131,6 +131,9 @@ static void __init harmony_i2c_init(void)
 	platform_device_register(&tegra_i2c_device3);
 	platform_device_register(&tegra_i2c_device4);
 
+	gpio_request(TEGRA_GPIO_CDC_IRQ, "wm8903");
+	gpio_direction_input(TEGRA_GPIO_CDC_IRQ);
+
 	i2c_register_board_info(0, &wm8903_board_info, 1);
 }
 
-- 
1.7.1
