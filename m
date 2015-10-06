From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 09:57:45 -0500
Subject: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
In-Reply-To: <13543270.oBfHhoNL28@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20151005175230.GG18784@saruman.tx.rr.com> <87io6lf6i4.fsf@saruman.tx.rr.com>
 <13543270.oBfHhoNL28@wuerfel>
Message-ID: <87612k3uza.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 05 October 2015 14:41:07 Felipe Balbi wrote:
>> 
>> /**
>>  * omap_get_timer_dt - get a timer using device-tree
>>  * @match       - device-tree match structure for matching a device type
>>  * @property    - optional timer property to match
>>  *
>>  * Helper function to get a timer during early boot using device-tree for use
>>  * as kernel system timer. Optionally, the property argument can be used to
>>  * select a timer with a specific property. Once a timer is found then mark
>>  * the timer node in device-tree as disabled, to prevent the kernel from
>>  * registering this timer as a platform device and so no one else can use it.
>>  */
>> static struct device_node * __init omap_get_timer_dt(const struct of_device_id *match,
>>                                                      const char *property)
>> {
>>         struct device_node *np;
>> 
>>         for_each_matching_node(np, match) {
>>                 if (!of_device_is_available(np))
>>                         continue;
>> 
>>                 if (property && !of_get_property(np, property, NULL))
>>                         continue;
>> 
>>                 if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
>>                                   of_get_property(np, "ti,timer-dsp", NULL) ||
>>                                   of_get_property(np, "ti,timer-pwm", NULL) ||
>>                                   of_get_property(np, "ti,timer-secure", NULL)))
>>                         continue;
>> 
>>                 of_add_property(np, &device_disabled);
>>                 return np;
>>         }
>> 
>>         return NULL;
>> }
>> 
>> I'll patch this up and drop $subject
>> 
>
> Ah, good.
>
> I'm seeing the "ti,timer-alwon" property here, we probably need to take
> that into account when setting the CLOCK_SOURCE_SUSPEND_NONSTOP flag, if
> that isn't how it gets done already.

that flag is not set for 32k in any dts. Seems like it should, though,
judging by the binding documentation:

- ti,timer-alwon:	Indicates the timer is in an alway-on power
  domain.

Tony, care to comment if we should add timer-alwon to 32k ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/40ca5657/attachment.sig>
