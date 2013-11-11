From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Nov 2013 11:19:33 +0100
Subject: [PATCH 2/4] cpu: advertise CPU features over udev in a generic way
In-Reply-To: <1384165175-16134-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1384165175-16134-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1384165175-16134-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements a generic modalias 'cpu:type:...:feature:...'
which enables CPU feature flag based module loading in a generic way.
All the arch needs to do is enable CONFIG_ARCH_HAS_CPU_AUTOPROBE and
implement arch_print_cpu_modalias(). The modules need to declare the
CPU feature they depend on with MODULE_DEVICE_TABLE(cpu, ...)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/mod_devicetable.h   | 11 +++++++++++
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 45e9214..da20e57 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -564,6 +564,17 @@ struct x86_cpu_id {
 #define X86_MODEL_ANY  0
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
 
+/*
+ * Generic table type for tracking CPU features.
+ * @feature:	the bit number of the feature (0000 - ffff)
+ *
+ * How the bit numbers map to actual CPU features is entirely up to the arch
+ */
+
+struct generic_cpu_id {
+	__u16	feature;
+};
+
 #define IPACK_ANY_FORMAT 0xff
 #define IPACK_ANY_ID (~0)
 struct ipack_device_id {
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index bb5d115..1aa2126 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -174,6 +174,9 @@ int main(void)
 	DEVID_FIELD(x86_cpu_id, model);
 	DEVID_FIELD(x86_cpu_id, vendor);
 
+	DEVID(generic_cpu_id);
+	DEVID_FIELD(generic_cpu_id, feature);
+
 	DEVID(mei_cl_device_id);
 	DEVID_FIELD(mei_cl_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 2370863..efc7abe 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1135,6 +1135,16 @@ static int do_x86cpu_entry(const char *filename, void *symval,
 }
 ADD_TO_DEVTABLE("x86cpu", x86_cpu_id, do_x86cpu_entry);
 
+/* LOOKS like cpu:type:*:feature:*FEAT* */
+static int do_cpu_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, generic_cpu_id, feature);
+
+	sprintf(alias, "cpu:type:*:feature:*%04X*", feature);
+	return 1;
+}
+ADD_TO_DEVTABLE("cpu", generic_cpu_id, do_cpu_entry);
+
 /* Looks like: mei:S */
 static int do_mei_entry(const char *filename, void *symval,
 			char *alias)
-- 
1.8.3.2
