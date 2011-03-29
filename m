From: dilinger@queued.net (Andres Salomon)
Date: Mon, 28 Mar 2011 17:22:30 -0700
Subject: [PATCH resend] ARM: mx51_efika: fix build error due to new mfd changes
Message-ID: <20110328172230.01756522@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


MFD changes in 4ec1b54c ('mfd: mfd_cell is now implicitly available
to mc13xxx drivers') changed the mc13xxx_platform_data struct layout.
At the time all users were changed, but this driver was introduced in
another tree at the same time.  This updates the mc13xxx_platform_data
user, fixing a build error.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 arch/arm/mach-mx5/mx51_efika.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 51a67fc..868af8f 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -572,8 +572,10 @@ static struct mc13xxx_regulator_init_data mx51_efika_regulators[] = {
 
 static struct mc13xxx_platform_data mx51_efika_mc13892_data = {
 	.flags = MC13XXX_USE_RTC | MC13XXX_USE_REGULATOR,
-	.num_regulators = ARRAY_SIZE(mx51_efika_regulators),
-	.regulators = mx51_efika_regulators,
+	.regulators = {
+		.num_regulators = ARRAY_SIZE(mx51_efika_regulators),
+		.regulators = mx51_efika_regulators,
+	},
 };
 
 static struct spi_board_info mx51_efika_spi_board_info[] __initdata = {
-- 
1.7.2.5
