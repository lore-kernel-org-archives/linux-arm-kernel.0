From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 18 Jul 2012 10:11:56 -0500
Subject: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
In-Reply-To: <20120718071906.GJ6522@atomide.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com> <500439A8.1050705@ti.com>
 <20120718071906.GJ6522@atomide.com>
Message-ID: <5006D23C.5010004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 07/18/2012 02:19 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120716 09:01]:
>> On 07/13/2012 09:15 PM, Rob Herring wrote:
>>
>> Tony, Tarun,
>>
>> How would you feel on replacing omap_dmtimer_request_specific(int id)
>> with say omap_dm_timer_request_by_cap(int cap)?
>>
>> I was thinking of changing the name so that it is clear that the API has
>> changed. The "int cap" passed to the above function would be an OR of
>> the appropriate the capabilities flags we have in dmtimer.h ...
>>
>> /* timer capabilities used in hwmod database */
>> #define OMAP_TIMER_SECURE                               0x80000000
>> #define OMAP_TIMER_ALWON                                0x40000000
>> #define OMAP_TIMER_HAS_PWM                              0x20000000
>> ...
> 
> That may break coprocessors where the firmware may expect a hardcoded
> specific timer.. So at least that should be checked before the change.
> If the specific timer is still needed for some firmware, it's best to
> add a separate function for the capabilities.

I have seen that timers are used by the GPU and Ducati. Maybe I can
check with the authors to see if we can get them to request by
capability instead. If we can't then I need to figure out a way to
resolve the timer ID when using DT. Per Rob's comments using alias is
not the intended use. An alternative would be to extract the ID from the
hwmod name, but was not sure if that would be appropriate either :-(

> Also, I believe it's up to the firmware running in secure mode to
> select the secure timers. So unless there's some way to query which
> timers are claimed by the secure mode, that too needs to be passed
> via DT.

Yes, that is handled by patch 2/4. If we are on a secure device, then
will not register any timers marked with the "ti,timer-secure" property.

Cheers
Jon
