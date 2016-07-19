From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Jul 2016 16:53:53 -0600
Subject: [PATCH 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <1468968836-12695-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468968836-12695-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468968836-12695-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds PMU driver specific configuration to the parser
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
---
 tools/perf/util/evsel.c        |  1 +
 tools/perf/util/evsel.h        |  4 +++
 tools/perf/util/parse-events.c | 67 +++++++++++++++++++++++++++++++-----------
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l | 12 ++++++++
 tools/perf/util/parse-events.y | 11 +++++++
 6 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5d7037ef7d3b..7f97bae594ff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -213,6 +213,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->node);
 	INIT_LIST_HEAD(&evsel->config_terms);
+	INIT_LIST_HEAD(&evsel->drv_config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
 	perf_evsel__calc_id_pos(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c1f10159804c..0441be00a366 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -44,6 +44,7 @@ enum {
 	PERF_EVSEL__CONFIG_TERM_CALLGRAPH,
 	PERF_EVSEL__CONFIG_TERM_STACK_USER,
 	PERF_EVSEL__CONFIG_TERM_INHERIT,
+	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_MAX,
 };
 
@@ -55,6 +56,7 @@ struct perf_evsel_config_term {
 		u64	freq;
 		bool	time;
 		char	*callgraph;
+		char	*drv_cfg;
 		u64	stack_user;
 		bool	inherit;
 	} val;
@@ -75,6 +77,7 @@ struct perf_evsel_config_term {
  *          PERF_SAMPLE_IDENTIFIER) in a non-sample event i.e. if sample_id_all
  *          is used there is an id sample appended to non-sample events
  * @priv:   And what is in its containing unnamed union are tool specific
+ * @drv_config_terms: List of configurables sent directly to the PMU driver
  */
 struct perf_evsel {
 	struct list_head	node;
@@ -122,6 +125,7 @@ struct perf_evsel {
 	char			*group_name;
 	bool			cmdline_group_boundary;
 	struct list_head	config_terms;
+	struct list_head	drv_config_terms;
 	int			bpf_fd;
 };
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c6fd0479f4cd..a12284091666 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -302,7 +302,8 @@ static struct perf_evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    char *name, struct cpu_map *cpus,
-	    struct list_head *config_terms)
+	    struct list_head *config_terms,
+	    struct list_head *drv_config_terms)
 {
 	struct perf_evsel *evsel;
 
@@ -321,6 +322,10 @@ __add_event(struct list_head *list, int *idx,
 	if (config_terms)
 		list_splice(config_terms, &evsel->config_terms);
 
+	if (drv_config_terms)
+		list_splice(drv_config_terms, &evsel->drv_config_terms);
+
+
 	list_add_tail(&evsel->node, list);
 	return evsel;
 }
@@ -329,7 +334,8 @@ static int add_event(struct list_head *list, int *idx,
 		     struct perf_event_attr *attr, char *name,
 		     struct list_head *config_terms)
 {
-	return __add_event(list, idx, attr, name, NULL, config_terms) ? 0 : -ENOMEM;
+	return __add_event(list, idx, attr, name,
+			   NULL, config_terms, NULL) ? 0 : -ENOMEM;
 }
 
 static int parse_aliases(char *str, const char *names[][PERF_EVSEL__MAX_ALIASES], int size)
@@ -900,6 +906,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_STACKSIZE]		= "stack-size",
 	[PARSE_EVENTS__TERM_TYPE_NOINHERIT]		= "no-inherit",
 	[PARSE_EVENTS__TERM_TYPE_INHERIT]		= "inherit",
+	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 };
 
 static bool config_term_shrinked;
@@ -1021,7 +1028,8 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct parse_events_error *err)
 {
-	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER)
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
+	    term->type_term == PARSE_EVENTS__TERM_TYPE_DRV_CFG)
 		/*
 		 * Always succeed for sysfs terms, as we dont know
 		 * at this point what type they need to have.
@@ -1067,10 +1075,7 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(struct list_head *head_config,
-			    struct list_head *head_terms __maybe_unused)
-{
-#define ADD_CONFIG_TERM(__type, __name, __val)			\
+#define ADD_CONFIG_TERM(__type, __name, __val, __head_terms)	\
 do {								\
 	struct perf_evsel_config_term *__t;			\
 								\
@@ -1081,33 +1086,41 @@ do {								\
 	INIT_LIST_HEAD(&__t->list);				\
 	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
 	__t->val.__name = __val;				\
-	list_add_tail(&__t->list, head_terms);			\
+	list_add_tail(&__t->list, __head_terms);		\
 } while (0)
 
+static int get_config_terms(struct list_head *head_config,
+			    struct list_head *head_terms)
+{
 	struct parse_events_term *term;
 
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
-			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
+			ADD_CONFIG_TERM(PERIOD, period,
+					term->val.num, head_terms);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
-			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
+			ADD_CONFIG_TERM(FREQ, freq, term->val.num, head_terms);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_TIME:
-			ADD_CONFIG_TERM(TIME, time, term->val.num);
+			ADD_CONFIG_TERM(TIME, time, term->val.num, head_terms);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
-			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
+			ADD_CONFIG_TERM(CALLGRAPH, callgraph,
+					term->val.str, head_terms);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
-			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
+			ADD_CONFIG_TERM(STACK_USER, stack_user,
+					term->val.num, head_terms);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_INHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
+			ADD_CONFIG_TERM(INHERIT, inherit,
+					term->val.num ? 1 : 0, head_terms);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
-			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
+			ADD_CONFIG_TERM(INHERIT, inherit,
+					term->val.num ? 0 : 1, head_terms);
 			break;
 		default:
 			break;
@@ -1117,6 +1130,21 @@ do {								\
 	return 0;
 }
 
+static int get_drv_config_terms(struct list_head *head_config,
+				struct list_head *head_terms)
+{
+	struct parse_events_term *term;
+
+	list_for_each_entry(term, head_config, list) {
+		if (term->type_term != PARSE_EVENTS__TERM_TYPE_DRV_CFG)
+			continue;
+
+		ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str, head_terms);
+	}
+
+	return 0;
+}
+
 int parse_events_add_tracepoint(struct list_head *list, int *idx,
 				char *sys, char *event,
 				struct parse_events_error *err,
@@ -1172,6 +1200,7 @@ int parse_events_add_pmu(struct parse_events_evlist *data,
 	struct perf_pmu *pmu;
 	struct perf_evsel *evsel;
 	LIST_HEAD(config_terms);
+	LIST_HEAD(drv_config_terms);
 
 	pmu = perf_pmu__find(name);
 	if (!pmu)
@@ -1186,7 +1215,8 @@ int parse_events_add_pmu(struct parse_events_evlist *data,
 
 	if (!head_config) {
 		attr.type = pmu->type;
-		evsel = __add_event(list, &data->idx, &attr, NULL, pmu->cpus, NULL);
+		evsel = __add_event(list, &data->idx, &attr,
+				    NULL, pmu->cpus, NULL, NULL);
 		return evsel ? 0 : -ENOMEM;
 	}
 
@@ -1203,12 +1233,15 @@ int parse_events_add_pmu(struct parse_events_evlist *data,
 	if (get_config_terms(head_config, &config_terms))
 		return -ENOMEM;
 
+	if (get_drv_config_terms(head_config, &drv_config_terms))
+		return -ENOMEM;
+
 	if (perf_pmu__config(pmu, &attr, head_config, data->error))
 		return -EINVAL;
 
 	evsel = __add_event(list, &data->idx, &attr,
 			    get_config_name(head_config), pmu->cpus,
-			    &config_terms);
+			    &config_terms, &drv_config_terms);
 	if (evsel) {
 		evsel->unit = info.unit;
 		evsel->scale = info.scale;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d740c3ca9a1d..b933a3796ae4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -68,6 +68,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_STACKSIZE,
 	PARSE_EVENTS__TERM_TYPE_NOINHERIT,
 	PARSE_EVENTS__TERM_TYPE_INHERIT,
+	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 1477fbc78993..7e59cc3698c2 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,6 +53,16 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
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
@@ -124,6 +134,7 @@ num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
 name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
+drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
 modifier_event	[ukhpPGHSDI]+
 modifier_bp	[rwx]{1,3}
@@ -206,6 +217,7 @@ no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
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
