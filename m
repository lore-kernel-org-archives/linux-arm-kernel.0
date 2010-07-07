From: tony@atomide.com (Tony Lindgren)
Date: Wed, 07 Jul 2010 12:44:16 +0300
Subject: [PATCH 05/13] omap: rx51: Set regulator V28 always on
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Message-ID: <20100707094416.2562.89163.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jarkko Nikula <jhnikula@gmail.com>

It seems that the battery cover sensor in Nokia N900 is powered from the
V28 domain. Now if this regulator is disabled it causes that the gpio 160
reads only zero which effectively causes uSD removal detection.

Currently the bootloader enabled V28 is kept on but this may change in the
future according to comment in
drivers/regulator/core.c: regulator_has_full_constraints.

Also if there are any consumers on the V28 domain doing regulator_enable
regulator_disable cycle the V28 will be disabled after that.

Prepare for these by defining the V28 as always_on regulator.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5ddf156..3d95534 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -361,6 +361,7 @@ static struct regulator_init_data rx51_vaux1 = {
 		.name			= "V28",
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
+		.always_on		= true, /* due battery cover sensor */
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
