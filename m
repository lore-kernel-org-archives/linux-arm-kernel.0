From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 30 Aug 2016 10:19:23 -0600
Subject: [PATCH V7 3/5] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <1472573965-3881-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472573965-3881-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472573965-3881-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PMU driver specific configuration to the parser
infrastructure by preceding any term with the '@' letter.  As such
doing something like:

perf record -e some_event/@cfg1, at cfg2=config/ ...

will see 'cfg1' and 'cfg2=config' being added to the list of evsel config
terms.  Token 'cfg1' and 'cfg2=config' are not processed in user space
and are meant to be interpreted by the PMU driver.

First the lexer/parser are supplemented with the required definitions to
recognise the driver specific configuration.  From there they are simply
added to the list of event terms.  The bulk of the work is done in
function "parse_events_add_pmu()" where driver config event terms are
added to a new list of driver config terms, which in turn spliced with
the event's new driver configuration list.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 12 ++++++++++++
 tools/perf/util/evsel.h                  |  2 ++
 tools/perf/util/parse-events.c           |  7 ++++++-
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/parse-events.l           | 22 ++++++++++++++++++++++
 tools/perf/util/parse-events.y           | 11 +++++++++++
 6 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 379a2bed07c0..1a24f4d64328 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -60,6 +60,18 @@ OPTIONS
 	  Note: If user explicitly sets options which conflict with the params,
 	  the value set by the params will be overridden.
 
+	  Also not defined in .../<pmu>/format/* are PMU driver specific
+	  configuration parameters.  Any configuration parameter preceded by
+	  the letter '@' is not interpreted in user space and sent down directly
+	  to the PMU driver.  For example:
+
+	  perf record -e some_event/@cfg1, at cfg2=config/ ...
+
+	  will see 'cfg1' and 'cfg2=config' pushed to the PMU driver associated
+	  with the event for further processing.  There is no restriction on
+	  what the configuration parameters are, as long as their semantic is
+	  understood and supported by the PMU driver.
+
         - a hardware breakpoint event in the form of '\mem:addr[/len][:access]'
           where addr is the address in memory you want to break in.
           Access is the memory access type (read, write, execute) it can
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4d44129e050b..323806082c58 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -46,6 +46,7 @@ enum {
 	PERF_EVSEL__CONFIG_TERM_INHERIT,
 	PERF_EVSEL__CONFIG_TERM_MAX_STACK,
 	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
+	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_MAX,
 };
 
@@ -57,6 +58,7 @@ struct perf_evsel_config_term {
 		u64	freq;
 		bool	time;
 		char	*callgraph;
+		char	*drv_cfg;
 		u64	stack_user;
 		int	max_stack;
 		bool	inherit;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6c913c3914fb..2eb8b1ed4cc8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -904,6 +904,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_MAX_STACK]		= "max-stack",
 	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
+	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 };
 
 static bool config_term_shrinked;
@@ -1034,7 +1035,8 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_error *err)
 {
-	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER)
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
+	    term->type_term == PARSE_EVENTS__TERM_TYPE_DRV_CFG)
 		/*
 		 * Always succeed for sysfs terms, as we dont know
 		 * at this point what type they need to have.
@@ -1134,6 +1136,9 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
+			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d1edbf8cc66a..8d09a976fca8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -71,6 +71,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_MAX_STACK,
 	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
+	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7a2519435da0..9f43fda2570f 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,6 +53,26 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
+/*
+ * This function is called when the parser gets two kind of input:
+ *
+ * 	@cfg1 or @cfg2=config
+ *
+ * The leading '@' is stripped off before 'cfg1' and 'cfg2=config' are given to
+ * bison.  In the latter case it is necessary to keep the string intact so that
+ * the PMU kernel driver can determine what configurable is associated to
+ * 'config'.
+ */
+static int drv_str(yyscan_t scanner, int token)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	/* Strip off the '@' */
+	yylval->str = strdup(text + 1);
+	return token;
+}
+
 #define REWIND(__alloc)				\
 do {								\
 	YYSTYPE *__yylval = parse_events_get_lval(yyscanner);	\
@@ -124,6 +144,7 @@ num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
 name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
+drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
 modifier_event	[ukhpPGHSDI]+
 modifier_bp	[rwx]{1,3}
@@ -209,6 +230,7 @@ no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
 \[all\]			{ return PE_ARRAY_ALL; }
 "["			{ BEGIN(array); return '['; }
+@{drv_cfg_term}		{ return drv_str(yyscanner, PE_DRV_CFG_TERM); }
 }
 
 <mem>{
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5be4a5f216d6..879115f93edc 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -49,6 +49,7 @@ static void inc_group_count(struct list_head *list,
 %token PE_ERROR
 %token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
+%token PE_DRV_CFG_TERM
 %type <num> PE_VALUE
 %type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
@@ -63,6 +64,7 @@ static void inc_group_count(struct list_head *list,
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
 %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
+%type <str> PE_DRV_CFG_TERM
 %type <num> value_sym
 %type <head> event_config
 %type <head> opt_event_config
@@ -599,6 +601,15 @@ PE_NAME array '=' PE_VALUE
 	term->array = $2;
 	$$ = term;
 }
+|
+PE_DRV_CFG_TERM
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+					$1, $1, &@1, NULL));
+	$$ = term;
+}
 
 array:
 '[' array_terms ']'
-- 
2.7.4
