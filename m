From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 29 Aug 2016 09:56:02 -0600
Subject: [PATCH V6 1/5] perf tools: making coresight PMU listable
In-Reply-To: <20160828141611.GA32293@krava>
References: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
 <1472156445-24283-2-git-send-email-mathieu.poirier@linaro.org>
 <20160828141611.GA32293@krava>
Message-ID: <CANLsYky4TY5s46nVTra+7-Zx+czjWZbmmJgqHenLTRNd1TM=CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2016 at 08:16, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Aug 25, 2016 at 02:20:41PM -0600, Mathieu Poirier wrote:
>
> SNIP
>
>>  ARM/CORGI MACHINE SUPPORT
>>  M:   Richard Purdie <rpurdie@rpsys.net>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 24803c58049a..72edf83d76b7 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -746,10 +746,13 @@ ifdef LIBBABELTRACE
>>  endif
>>
>>  ifndef NO_AUXTRACE
>> -  ifeq ($(feature-get_cpuid), 0)
>> -    msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
>> -    NO_AUXTRACE := 1
>> -  else
>> +  ifeq ($(ARCH),x86)
>> +    ifeq ($(feature-get_cpuid), 0)
>> +      msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
>> +      NO_AUXTRACE := 1
>> +    endif
>> +  endif
>> +  ifndef NO_AUXTRACE
>
> hum, how's this hunk connected to the issue described in changelog?

Patch 1/6 and 2/6 are needed by [3, 4, 5, 6]/6 of this set.
Originally they were part of a separate patchset I but decided to
include them here for completeness.  Let me know if you'd like to see
them split again.

>
> thanks,
> jirka
>
>>      $(call detected,CONFIG_AUXTRACE)
>>      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
>>    endif
>
> SNIP
