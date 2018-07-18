From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 18 Jul 2018 15:48:07 -0600
Subject: [PATCH v3 7/7] perf tools: Use ioctl function to send sink
 configuration to kernel
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531950487-24554-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using sysFS to communicate sink information for a trace session doesn't
work when more than one CPU is involved in the scenario.  As such
communicate the sink information to each event by using the SET_DRV_CONFIG
ioctl command.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 54 ++++-----------------------------------
 1 file changed, 5 insertions(+), 49 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..cb0978eb7181 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -599,55 +599,10 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	return NULL;
 }
 
-static FILE *cs_device__open_file(const char *name)
+static int cs_etm_set_drv_config_term(struct perf_evsel *evsel,
+				      const char *term)
 {
-	struct stat st;
-	char path[PATH_MAX];
-	const char *sysfs;
-
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		return NULL;
-
-	snprintf(path, PATH_MAX,
-		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
-
-	if (stat(path, &st) < 0)
-		return NULL;
-
-	return fopen(path, "w");
-
-}
-
-static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
-{
-	va_list args;
-	FILE *file;
-	int ret = -EINVAL;
-
-	va_start(args, fmt);
-	file = cs_device__open_file(name);
-	if (file) {
-		ret = vfprintf(file, fmt, args);
-		fclose(file);
-	}
-	va_end(args);
-	return ret;
-}
-
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
-{
-	int ret;
-	char enable_sink[ENABLE_SINK_MAX];
-
-	snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
-		 term->val.drv_cfg, "enable_sink");
-
-	ret = cs_device__print_file(enable_sink, "%d", 1);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return perf_evsel__apply_drv_config(evsel, term);
 }
 
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
@@ -660,7 +615,8 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		err = cs_etm_set_drv_config_term(term);
+		err = cs_etm_set_drv_config_term(evsel,
+						 term->val.drv_cfg);
 		if (err) {
 			*err_term = term;
 			break;
-- 
2.7.4
