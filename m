From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:54 +0200
Subject: [PATCH v5 31/46] pwm: update documentation
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-32-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the PWM subsystem documentation to reflect the atomic PWM changes.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/pwm.txt | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index ca895fd..cb25fca 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -42,9 +42,23 @@ variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
 
 After being requested, a PWM has to be configured using:
 
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
+int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *pstate);
 
-To start/stop toggling the PWM output use pwm_enable()/pwm_disable().
+This API controls both the PWM period/duty_cycle config and the
+enable/disable state.
+
+The legacy pwm_config(), pwm_enable() and pwm_disable() are now deprecated,
+and should be replaced by pwm_apply_state() calls.
+
+The PWM user API also allows one to query the PWM state with pwm_get_state().
+
+In addition to the PWM state, the PWM API also exposes PWM arguments, which
+are the reference PWM config one should use on this PWM.
+PWM arguments are usually platform-specific and allows the PWM user to only
+care about dutycycle relatively to the full period (like, duty = 50% of the
+period). struct pwm_args contains 2 fields (period and polarity) and should
+be used to set the initial PWM config (usually done in the probe function
+of the PWM user). PWM arguments are retrieved with pwm_get_args().
 
 Using PWMs with the sysfs interface
 -----------------------------------
@@ -105,6 +119,15 @@ goes low for the remainder of the period. Conversely, a signal with inversed
 polarity starts low for the duration of the duty cycle and goes high for the
 remainder of the period.
 
+Drivers are encouraged to implement ->apply() instead of the legacy
+->enable(), ->disable() and ->config() methods. Doing that should provide
+atomicity in the PWM config workflow, which is required when the PWM controls
+a critical device (like a regulator).
+
+The implementation of ->get_state() (a method used to retrieve initial PWM
+state) is also encouraged for the same reason: letting the PWM user know
+about the current PWM state would allow him to avoid glitches.
+
 Locking
 -------
 
-- 
2.5.0
