From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Jul 2016 12:24:48 -0600
Subject: [PATCH V2 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <20160721145434.GA15915@krava>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
 <20160721074722.GB7192@krava>
 <CANLsYkxj+kccmvTtOLAYwyN9fOp0pMxdPcWy5cJHQDQLoj-NmQ@mail.gmail.com>
 <20160721145434.GA15915@krava>
Message-ID: <CANLsYkwx+iOE6uwOVPtsHFMmNaH0=NjeDP8z0GZhHja2oibt8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2016 at 08:54, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Jul 21, 2016 at 08:44:53AM -0600, Mathieu Poirier wrote:
>
> SNIP
>
>> >> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
>> >> index 7a2519435da0..1f7e11a6c5b3 100644
>> >> --- a/tools/perf/util/parse-events.l
>> >> +++ b/tools/perf/util/parse-events.l
>> >> @@ -53,6 +53,16 @@ static int str(yyscan_t scanner, int token)
>> >>       return token;
>> >>  }
>> >>
>> >> +static int drv_str(yyscan_t scanner, int token)
>> >> +{
>> >> +     YYSTYPE *yylval = parse_events_get_lval(scanner);
>> >> +     char *text = parse_events_get_text(scanner);
>> >> +
>> >> +     /* Strip off the '@' */
>> >> +     yylval->str = strdup(text + 1);
>> >> +     return token;
>> >> +}
>> >
>> > why don't let bison parse this with rule like:
>> >
>> > | '@' PE_DRV_CFG_TERM
>> > {
>> > ...
>> > }
>> >
>> >
>> > you could omit the drv_str function then
>>
>> I simply thought it was simple and clean to do it that way - and it
>> follows the trend already in place.  Are you sure you want me to move
>> this to bison?  Either way we have to add code...
>>
>> Many thanks for the review,
>> Mathieu
>
> hum, i might be missing something, but what I meant
> was something like below
>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 1f7e11a6c5b3..9b00f9b9caa2 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -53,16 +53,6 @@ static int str(yyscan_t scanner, int token)
>         return token;
>  }
>
> -static int drv_str(yyscan_t scanner, int token)
> -{
> -       YYSTYPE *yylval = parse_events_get_lval(scanner);
> -       char *text = parse_events_get_text(scanner);
> -
> -       /* Strip off the '@' */
> -       yylval->str = strdup(text + 1);
> -       return token;
> -}
> -
>  #define REWIND(__alloc)                                \
>  do {                                                           \
>         YYSTYPE *__yylval = parse_events_get_lval(yyscanner);   \
> @@ -220,7 +210,7 @@ no-overwrite                { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
>  {name_minus}           { return str(yyscanner, PE_NAME); }
>  \[all\]                        { return PE_ARRAY_ALL; }
>  "["                    { BEGIN(array); return '['; }
> -@{drv_cfg_term}                { return drv_str(yyscanner, PE_DRV_CFG_TERM); }
> +{drv_cfg_term}         { return PE_DRV_CFG_TERM; }
>  }
>
>  <mem>{
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -602,12 +602,12 @@ PE_NAME array '=' PE_VALUE
>         $$ = term;
>  }
>  |
> -PE_DRV_CFG_TERM
> +'@' PE_DRV_CFG_TERM
>  {
>         struct parse_events_term *term;
>
>         ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
> -                                       $1, $1, &@1, NULL));
> +                                       $2, $2, &@2, NULL));
>         $$ = term;
>  }
>

I've been experimenting with the above solution and it is not yielding
the results one might think at first glance.

If we use the example: -e event/@cfg1/ ...

First if we leave things exactly the way they are suggested in the
code snippet flex doesn't know what do to with the '@' character and
returns an error.  To deal with that a new clause

"@"        { return '@'; }

can be inserted in the config state.  But that doesn't link '@' with
'cfg1', and 'cfg1' gets interpreted as a PE_NAME.  Introducing a new
state upon hitting '@' would get us around that but we are moving away
from our initial goal of keeping things simple.

Another solution is to have something like this:

drv_cfg_term    @[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?

But then we need to strip off the '@' character in the parse-events.y
file, which isn't pretty given that it can be done so easily with the
solution I had before.

So I'm a little puzzled on how to proceed here, but I'm well aware
that my flex/bison knowledge might also be too shallow...

Thanks,
Mathieu
