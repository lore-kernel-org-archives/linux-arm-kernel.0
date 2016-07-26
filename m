From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 26 Jul 2016 22:41:39 +0200
Subject: [PATCH V2 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <CANLsYkwx+iOE6uwOVPtsHFMmNaH0=NjeDP8z0GZhHja2oibt8g@mail.gmail.com>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
 <20160721074722.GB7192@krava>
 <CANLsYkxj+kccmvTtOLAYwyN9fOp0pMxdPcWy5cJHQDQLoj-NmQ@mail.gmail.com>
 <20160721145434.GA15915@krava>
 <CANLsYkwx+iOE6uwOVPtsHFMmNaH0=NjeDP8z0GZhHja2oibt8g@mail.gmail.com>
Message-ID: <20160726204139.GA13377@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 12:24:48PM -0600, Mathieu Poirier wrote:

SNIP

> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -602,12 +602,12 @@ PE_NAME array '=' PE_VALUE
> >         $$ = term;
> >  }
> >  |
> > -PE_DRV_CFG_TERM
> > +'@' PE_DRV_CFG_TERM
> >  {
> >         struct parse_events_term *term;
> >
> >         ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
> > -                                       $1, $1, &@1, NULL));
> > +                                       $2, $2, &@2, NULL));
> >         $$ = term;
> >  }
> >
> 
> I've been experimenting with the above solution and it is not yielding
> the results one might think at first glance.
> 
> If we use the example: -e event/@cfg1/ ...
> 
> First if we leave things exactly the way they are suggested in the
> code snippet flex doesn't know what do to with the '@' character and
> returns an error.  To deal with that a new clause
> 
> "@"        { return '@'; }
> 
> can be inserted in the config state.  But that doesn't link '@' with
> 'cfg1', and 'cfg1' gets interpreted as a PE_NAME.  Introducing a new
> state upon hitting '@' would get us around that but we are moving away
> from our initial goal of keeping things simple.

hum, then how about keeping the flex atoms simple like for the
other terms and do something like below.. untested ;-)

thanks,
jirka


---
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 1f7e11a6c5b3..8ba228e1c150 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,16 +53,6 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
-static int drv_str(yyscan_t scanner, int token)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	/* Strip off the '@' */
-	yylval->str = strdup(text + 1);
-	return token;
-}
-
 #define REWIND(__alloc)				\
 do {								\
 	YYSTYPE *__yylval = parse_events_get_lval(yyscanner);	\
@@ -134,7 +124,6 @@ num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
 name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
-drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
 modifier_event	[ukhpPGHSDI]+
 modifier_bp	[rwx]{1,3}
@@ -216,11 +205,11 @@ no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 ,			{ return ','; }
+"@"			{ return '@'; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
 \[all\]			{ return PE_ARRAY_ALL; }
 "["			{ BEGIN(array); return '['; }
-@{drv_cfg_term}		{ return drv_str(yyscanner, PE_DRV_CFG_TERM); }
 }
 
 <mem>{
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 879115f93edc..7e03e93dabca 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -602,12 +602,12 @@ PE_NAME array '=' PE_VALUE
 	$$ = term;
 }
 |
-PE_DRV_CFG_TERM
+'@' PE_NAME '=' PE_NAME
 {
 	struct parse_events_term *term;
 
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					$1, $1, &@1, NULL));
+					$2, $4, &@2, &@4));
 	$$ = term;
 }
 
