From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 31 May 2011 11:27:00 +0300
Subject: [PATCHv2 1/2] omap: rx51: Set regulator V28_A always on
Message-ID: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V28_A domain in Nokia N900 that supplies VDD voltages to TLV320AIC34 and
TPA6130A2 should not be shutdown. This is because otherwise there will be
leak from VIO to VDD in TLV320AIC34 and this leak consumes more battery
current that is saved from keeping V28_A off. With this patch the battery
current consumption is approximately 1.5 mA lower.

Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
No changes from v1. Just sent together with 2/2.
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index f6247e7..02a6587 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -488,6 +488,7 @@ static struct regulator_init_data rx51_vmmc2 = {
 		.name			= "V28_A",
 		.min_uV			= 2800000,
 		.max_uV			= 3000000,
+		.always_on		= true, /* due VIO leak to AIC34 VDDs */
 		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
-- 
1.7.4.4
