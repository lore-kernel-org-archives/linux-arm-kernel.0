From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 22 Oct 2009 16:09:45 -0700
Subject: [PATCH v2 24/32] PM: Disable usb host HW save and restore
In-Reply-To: <1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1256252993-24328-25-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The hardware SAVEANDRESTORE mechanism seems to leave
USB HOST power domain permanently into active state
after one transition from off to active state.
Disabling for now.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomains34xx.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index f70eb2d..fd09b08 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -338,7 +338,13 @@ static struct powerdomain usbhost_pwrdm = {
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
-	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBHOST ctrlr only */
+	/*
+	 * REVISIT: Enabling usb host save and restore mechanism seems to
+	 * leave the usb host domain permanently in ACTIVE mode after
+	 * changing the usb host power domain state from OFF to active once.
+	 * Disabling for now.
+	 */
+	/*.flags	  = PWRDM_HAS_HDWR_SAR,*/ /* for USBHOST ctrlr only */
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */
-- 
1.6.4.3
