From: mpallaka@codeaurora.org (Mohan Pallaka)
Date: Wed, 18 May 2011 18:30:52 +0530
Subject: [PATCH 1/2] pwm: Add stubs for pwm operations
Message-ID: <1305723652-22737-1-git-send-email-mpallaka@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chip drivers that support both pwm and non-pwm modes
would encounter compilation errors if the platform doesn't
have support for pwm, even though the chip is programmed
to work in non-pwm mode. Add stubs for pwm functions to
avoid compilation errors in these scenarios.

Change-Id: Iec4c55fce253bda809947672be82a7bd14bcd663
Signed-off-by: Mohan Pallaka <mpallaka@codeaurora.org>
---
 include/linux/pwm.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7c77575..a3cb33f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,6 +3,7 @@
 
 struct pwm_device;
 
+#if defined(CONFIG_HAVE_PWM)
 /*
  * pwm_request - request a PWM device
  */
@@ -28,4 +29,27 @@ int pwm_enable(struct pwm_device *pwm);
  */
 void pwm_disable(struct pwm_device *pwm);
 
+#else
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	return NULL;
+}
+
+void pwm_free(struct pwm_device *pwm) { }
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	return -EINVAL;
+}
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	return -EINVAL;
+}
+
+void pwm_disable(struct pwm_device *pwm) { }
+
+
+#endif /* CONFIG_PWM */
 #endif /* __LINUX_PWM_H */
-- 
1.7.1.1
