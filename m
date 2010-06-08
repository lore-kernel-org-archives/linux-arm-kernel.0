From: tony@atomide.com (Tony Lindgren)
Date: Tue, 08 Jun 2010 15:03:35 +0300
Subject: [PATCH 4/5] omap: GPIO: fix auto-disable of debounce clock
In-Reply-To: <20100608120104.24902.36055.stgit@baageli.muru.com>
References: <20100608120104.24902.36055.stgit@baageli.muru.com>
Message-ID: <20100608120335.24902.28296.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

The addition of the new debounce code (commit
168ef3d9a56bd8bffe0ef4189c450888b4aefefe) broke the auto-disable of
debounce clocks on idle by forgetting to update the debounce clock
enable mask.

Add back the updating of bank->dbck_enable_mask so debounce clocks are
auto-disabled.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 393e921..9b7e354 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -673,6 +673,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 		if (cpu_is_omap34xx() || cpu_is_omap44xx())
 			clk_disable(bank->dbck);
 	}
+	bank->dbck_enable_mask = val;
 
 	__raw_writel(val, reg);
 }
