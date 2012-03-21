From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 21 Mar 2012 19:30:01 +0530
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
Message-ID: <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 5:12 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote:
>> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
>> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>> >>
>> >> I think you made very good point here. With the above patch, we are almost missing the capability of registering dmtimer as a clocksource for OMAP.
>> >> It will always use 32k-counter, and never fall back to dmtimer.
>> >>
>> >> Then the only options we have here is,
>> >>
>> >> 1) Register both the timers, 32k-counter and dmtimer for clocksource; let
>> >> ? Kernel pick up best rating clocksource out of these two.
>> >>
>> >> ? In case of OMAP1/2/3/4, kernel will use dmtimer, since it has better
>> >> ? Rating. User can choose the 32k-counter clocksource via bootargs.
>> >>
>> >> ? Impact: without bootargs for clocksource selection, kernel will choose
>> >> ? ? dmtimer, impacting loss of time during suspend/resume.
>> >>
>> This is the right option. The problem is gptimer clocksource
>> doesn't work across power transitions and hence it is broken.
>>
>> Even for the perf, with PM enabled, dmtimer can't be used or it needs
>> to be used with 32KHz clock which makes it no better than sync timer.
>>
>> So here keeping 32K sync timer is default clocksource makes sense since
>> it is the only working and viable option.
>>
>> So what can be done is register both 32K and gptimer together but make
>> gptimer clocksource registration depends on PM enabled.
>>
>> This should solve all the needs I guess.
>>
>
> I am not sure this will work on all platforms, for example, AM33XX, where
> We do not have 32ksync timer available, but we need PM support. Also, I
> personally think, we should not again use compile time option here.
>
Why not ?
If 32ksync timer is not available, don't register it. Then in AM case
you just have one clock-source. I am against the idea of making
gptimer as the default and asking user to choose sync32k from
command-line.

Btw, if you need PM, how are you going to use GPTIMER
as a clocksource. Note sys-clock is generally stopped in
low power states. So that leaves you option with using
gptimer with 32K clock and in that case, GPTIMER
is not a better clock-source compare to 32K sync timer
and so shouldn't be the rating.

Regards
Santosh
