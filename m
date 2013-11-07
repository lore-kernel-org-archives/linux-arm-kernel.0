From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  7 Nov 2013 18:17:35 +0100
Subject: [RFC PATCH 2/4] cpu: advertise CPU features over udev in a generic way
In-Reply-To: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1383844657-17487-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements a generic modalias 'cpu:feature:...' which
enables CPU feature flag based module loading in a generic way.
All the arch needs to do is enable CONFIG_ARCH_HAS_CPU_AUTOPROBE
and export a u32 called 'cpu_features'. (What each bit actually
means is irrelevant on this level.)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/base/cpu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 49c6f4b..a661d31 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -276,6 +276,30 @@ static void cpu_device_release(struct device *dev)
 }
 
 #ifdef CONFIG_ARCH_HAS_CPU_AUTOPROBE
+ssize_t print_cpu_modalias(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	extern u32 __weak cpu_features;
+	ssize_t n;
+	int i;
+	u32 f;
+
+	/*
+	 * With 32 features maximum (taking 3 bytes each to print), we don't
+	 * need to worry about overrunning the PAGE_SIZE sized buffer.
+	 */
+	n = sprintf(buf, "cpu:feature:");
+	for (f = cpu_features, i = 0; f; f >>= 1, i++)
+		if (f & 1)
+			n += sprintf(&buf[n], ",%02X", i);
+	buf[n++] = '\n';
+	return n;
+}
+
+ssize_t __attribute__((weak, alias("print_cpu_modalias")))
+arch_print_cpu_modalias(struct device *, struct device_attribute *, char *);
+
 static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
-- 
1.8.3.2
