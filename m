From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:35 +0200
Subject: [PATCH v5 15/24] drm: i915: explicitly apply PWM config extracted
 from pwm_args
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-16-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call pwm_apply_args() just after requesting the PWM device so that the
polarity and period are initialized according to the information provided
in pwm_args.

This is an intermediate state, and pwm_apply_args() should be dropped as
soon as the atomic PWM infrastructure is in place and the driver makes
use of it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/i915/intel_panel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_panel.c b/drivers/gpu/drm/i915/intel_panel.c
index 21ee647..dc3a2e4 100644
--- a/drivers/gpu/drm/i915/intel_panel.c
+++ b/drivers/gpu/drm/i915/intel_panel.c
@@ -1640,6 +1640,12 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 		return -ENODEV;
 	}
 
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(panel->backlight.pwm);
+
 	retval = pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERIOD_NS,
 			    CRC_PMIC_PWM_PERIOD_NS);
 	if (retval < 0) {
-- 
2.5.0
