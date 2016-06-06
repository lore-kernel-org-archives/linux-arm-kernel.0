From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:52 +0100
Subject: [PATCH 4/7] reset: Supply *_shared variant calls when using
 *_optional APIs
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160606155655.10860-5-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consumers need to be able to specify whether they are requesting an
'exclusive' or 'shared' reset line no matter which API (of_*, devm_*,
etc) they are using.  This change allows users of the optional_* API
in particular to specify that their request is for a 'shared' line.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/reset.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index fd69240..c358106 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -141,6 +141,12 @@ static inline struct reset_control *reset_control_get_optional_exclusive(
 	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
 }
 
+static inline struct reset_control *reset_control_get_optional_shared(
+					struct device *dev, const char *id)
+{
+	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 1);
+}
+
 /**
  * of_reset_control_get_exclusive - Lookup and obtain an exclusive reference
  *                                  to a reset controller.
@@ -270,6 +276,12 @@ static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 	return __devm_reset_control_get(dev, id, 0, 0);
 }
 
+static inline struct reset_control *devm_reset_control_get_optional_shared(
+					struct device *dev, const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, 1);
+}
+
 /**
  * devm_reset_control_get_exclusive_by_index - resource managed
  *                                             reset_control_get_exclusive()
-- 
2.8.3
