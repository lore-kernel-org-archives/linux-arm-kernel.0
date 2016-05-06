From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 06 May 2016 11:03:42 +0200
Subject: [PATCH v3 1/3] leds: triggers: Allow to switch the trigger to
 "panic" on a kernel panic
In-Reply-To: <57230B26.9010300@samsung.com>
References: <1461881020-13964-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1461881020-13964-2-git-send-email-ezequiel@vanguardiasur.com.ar>
 <57230B26.9010300@samsung.com>
Message-ID: <572C5DEE.3070307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2016 09:20 AM, Jacek Anaszewski wrote:
> Hi Ezequiel,
>
> Thanks for the update. It's indeed reasonable to have all the
> switching infrastructure in ledtrig-panic.c.
>
> I've noticed two minor issues below.

Since the merge window is imminent, I've addressed those issues by
myself and applied the patch set to the for-next branch
of linux-leds.git.

Thanks,
Jacek Anaszewski

> On 04/29/2016 12:03 AM, Ezequiel Garcia wrote:
>> This commit adds a new led_cdev flag LED_PANIC_INDICATOR, which
>> allows to mark a specific LED to be switched to the "panic"
>> trigger, on a kernel panic.
>>
>> This is useful to allow the user to assign a regular trigger
>> to a given LED, and still blink that LED on a kernel panic.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>>   drivers/leds/led-triggers.c          |  2 +-
>>   drivers/leds/leds.h                  |  1 +
>>   drivers/leds/trigger/Kconfig         |  3 +++
>>   drivers/leds/trigger/ledtrig-panic.c | 47
>> ++++++++++++++++++++++++++++++++++++
>>   include/linux/leds.h                 |  1 +
>>   5 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
>> index 2181581795d3..55fa65e1ae03 100644
>> --- a/drivers/leds/led-triggers.c
>> +++ b/drivers/leds/led-triggers.c
>> @@ -26,7 +26,7 @@
>>    * Nests outside led_cdev->trigger_lock
>>    */
>>   static DECLARE_RWSEM(triggers_list_lock);
>> -static LIST_HEAD(trigger_list);
>> +LIST_HEAD(trigger_list);
>>
>>    /* Used by LED Class */
>>
>> diff --git a/drivers/leds/leds.h b/drivers/leds/leds.h
>> index db3f20da7221..7d38e6b9a740 100644
>> --- a/drivers/leds/leds.h
>> +++ b/drivers/leds/leds.h
>> @@ -30,5 +30,6 @@ void led_set_brightness_nosleep(struct led_classdev
>> *led_cdev,
>>
>>   extern struct rw_semaphore leds_list_lock;
>>   extern struct list_head leds_list;
>> +extern struct list_head trigger_list;
>>
>>   #endif    /* __LEDS_H_INCLUDED */
>> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
>> index beac8c31c51b..4e4521c9072a 100644
>> --- a/drivers/leds/trigger/Kconfig
>> +++ b/drivers/leds/trigger/Kconfig
>> @@ -121,6 +121,9 @@ config LEDS_TRIGGER_PANIC
>>       depends on LEDS_TRIGGERS
>>       help
>>         This allows LEDs to be configured to blink on a kernel panic.
>> +      Enabling this option will allow to mark certain LEDs as
>> 'panic-indicators',
>
> s/"panic-indicators"/panic indicators/
>
> I understand that you referred here to the DT property name, but this
> is not obvious at first glance, and it is an implementation detail.
>
>> +      allowing to blink them on a kernel panic, even if they are set to
>> +      a different trigger.
>>         If unsure, say Y.
>>
>>   endif # LEDS_TRIGGERS
>> diff --git a/drivers/leds/trigger/ b/drivers/leds/trigger/ledtrig-panic.c
>> index 627b350c5ec3..3e447bd2064a 100644
>> --- a/drivers/leds/trigger/ledtrig-panic.c
>> +++ b/drivers/leds/trigger/ledtrig-panic.c
>> @@ -11,10 +11,54 @@
>>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> +#include <linux/notifier.h>
>>   #include <linux/leds.h>
>> +#include "../leds.h"
>>
>>   static struct led_trigger *trigger;
>>
>> +/*
>> + * This is a called in a special context by the atomic panic
>
> s/is a/is/
>
>> + * notifier. This means the trigger can be changed without
>> + * worrying about locking.
>> + */
>> +static void led_trigger_set_panic(struct led_classdev *led_cdev)
>> +{
>> +    struct led_trigger *trig;
>> +
>> +    list_for_each_entry(trig, &trigger_list, next_trig) {
>> +        if (strcmp("panic", trig->name))
>> +            continue;
>> +        if (led_cdev->trigger)
>> +            list_del(&led_cdev->trig_list);
>> +        list_add_tail(&led_cdev->trig_list, &trig->led_cdevs);
>> +
>> +        /* Avoid the delayed blink path */
>> +        led_cdev->blink_delay_on = 0;
>> +        led_cdev->blink_delay_off = 0;
>> +
>> +        led_cdev->trigger = trig;
>> +        if (trig->activate)
>> +            trig->activate(led_cdev);
>> +        break;
>> +    }
>> +}
>> +
>> +static int led_trigger_panic_notifier(struct notifier_block *nb,
>> +                      unsigned long code, void *unused)
>> +{
>> +    struct led_classdev *led_cdev;
>> +
>> +    list_for_each_entry(led_cdev, &leds_list, node)
>> +        if (led_cdev->flags & LED_PANIC_INDICATOR)
>> +            led_trigger_set_panic(led_cdev);
>> +    return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block led_trigger_panic_nb = {
>> +    .notifier_call = led_trigger_panic_notifier,
>> +};
>> +
>>   static long led_panic_blink(int state)
>>   {
>>       led_trigger_event(trigger, state ? LED_FULL : LED_OFF);
>> @@ -23,6 +67,9 @@ static long led_panic_blink(int state)
>>
>>   static int __init ledtrig_panic_init(void)
>>   {
>> +    atomic_notifier_chain_register(&panic_notifier_list,
>> +                       &led_trigger_panic_nb);
>> +
>>       led_trigger_register_simple("panic", &trigger);
>>       panic_blink = led_panic_blink;
>>       return 0;
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index 19eb10278bea..7e9fb00e15e8 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -50,6 +50,7 @@ struct led_classdev {
>>   #define LED_SYSFS_DISABLE    (1 << 22)
>>   #define LED_DEV_CAP_FLASH    (1 << 23)
>>   #define LED_HW_PLUGGABLE    (1 << 24)
>> +#define LED_PANIC_INDICATOR    (1 << 25)
>>
>>       /* Set LED brightness level
>>        * Must not sleep. Use brightness_set_blocking for drivers
>>
>
