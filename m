From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 21 Jul 2016 08:44:53 -0600
Subject: [PATCH V2 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <20160721074722.GB7192@krava>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
 <20160721074722.GB7192@krava>
Message-ID: <CANLsYkxj+kccmvTtOLAYwyN9fOp0pMxdPcWy5cJHQDQLoj-NmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2016 at 01:47, Jiri Olsa <jolsa@redhat.com> wrote:
> On Wed, Jul 20, 2016 at 02:38:17PM -0600, Mathieu Poirier wrote:
>
> SNIP
>
>> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
>> index d1edbf8cc66a..8d09a976fca8 100644
>> --- a/tools/perf/util/parse-events.h
>> +++ b/tools/perf/util/parse-events.h
>> @@ -71,6 +71,7 @@ enum {
>>       PARSE_EVENTS__TERM_TYPE_MAX_STACK,
>>       PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
>>       PARSE_EVENTS__TERM_TYPE_OVERWRITE,
>> +     PARSE_EVENTS__TERM_TYPE_DRV_CFG,
>>       __PARSE_EVENTS__TERM_TYPE_NR,
>>  };
>>
>> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
>> index 7a2519435da0..1f7e11a6c5b3 100644
>> --- a/tools/perf/util/parse-events.l
>> +++ b/tools/perf/util/parse-events.l
>> @@ -53,6 +53,16 @@ static int str(yyscan_t scanner, int token)
>>       return token;
>>  }
>>
>> +static int drv_str(yyscan_t scanner, int token)
>> +{
>> +     YYSTYPE *yylval = parse_events_get_lval(scanner);
>> +     char *text = parse_events_get_text(scanner);
>> +
>> +     /* Strip off the '@' */
>> +     yylval->str = strdup(text + 1);
>> +     return token;
>> +}
>
> why don't let bison parse this with rule like:
>
> | '@' PE_DRV_CFG_TERM
> {
> ...
> }
>
>
> you could omit the drv_str function then

I simply thought it was simple and clean to do it that way - and it
follows the trend already in place.  Are you sure you want me to move
this to bison?  Either way we have to add code...

Many thanks for the review,
Mathieu

>
> thanks,
> jirka
