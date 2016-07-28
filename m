From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 28 Jul 2016 10:15:52 -0600
Subject: [PATCH V2 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <20160727192639.GC23264@krava>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-4-git-send-email-mathieu.poirier@linaro.org>
 <20160721074722.GB7192@krava>
 <CANLsYkxj+kccmvTtOLAYwyN9fOp0pMxdPcWy5cJHQDQLoj-NmQ@mail.gmail.com>
 <20160721145434.GA15915@krava>
 <CANLsYkwx+iOE6uwOVPtsHFMmNaH0=NjeDP8z0GZhHja2oibt8g@mail.gmail.com>
 <20160726204139.GA13377@krava>
 <CANLsYkzr0iFFEUoeR8-58E02DyqdGndfNBL8v0tS2tQqBszN_A@mail.gmail.com>
 <20160727192639.GC23264@krava>
Message-ID: <CANLsYkxzSBHXGwe2y-593D4yDyLy9+vdcTHmP_rqF30x0qTiug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 July 2016 at 13:26, Jiri Olsa <jolsa@redhat.com> wrote:
> On Wed, Jul 27, 2016 at 11:59:50AM -0600, Mathieu Poirier wrote:
>
> SNIP
>
>> > -PE_DRV_CFG_TERM
>> > +'@' PE_NAME '=' PE_NAME
>> >  {
>> >         struct parse_events_term *term;
>> >
>> >         ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
>> > -                                       $1, $1, &@1, NULL));
>> > +                                       $2, $4, &@2, &@4));
>> >         $$ = term;
>> >  }
>> >
>>
>> The problem here is that the correlation between the first and the
>> second PE_NAME is lost and instead of seeing "PE_NAME=PE_NAME", the
>> kernel only gets the value associated with the second PE_NAME.
>>
>> For example,
>>
>> -e event/@cfg1=value1, at cfg2=value2/ ...
>>
>> The above code will send "value1" and "value2" to the kernel driver
>> where there is no way to know what configurable the values correspond
>
> hum.. you get the 'cfg1' and 'cfg2' strings in $1 no?

Indeed you do.

Macro ADD_CONFIG_TERM in function get_config_terms() only account for
the __val parameter and struct parse_events_term::config is completely
ignored.  We could concatenate the fields before calling
ADD_CONFIG_TERM() but between that and freeing the reserved memory, I
think it is cleaner to let flex do the work.

Mathieu

>
> jirka
>
>> to.  To go around that we'd have to concatenate $2 and $4 in function
>> parse_events_term__str() (or new_term()) when @type_term ==
>> PARSE_EVENTS__TERM_TYPE_DRV_CFG, something that definitely looks
>> hackish to me.
>>
>> Thanks,
>> Mathieu
