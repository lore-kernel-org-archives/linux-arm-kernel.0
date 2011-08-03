From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Aug 2011 18:12:28 +0200
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <20110803153035.GL2607@pulham.picochip.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
	<20110803102829.GC2607@pulham.picochip.com>
	<CACRpkdZRh=gcedJQh6V3aUCfi2arn2V_P67MgZE2mB_hYZ-OnQ@mail.gmail.com>
	<20110803153035.GL2607@pulham.picochip.com>
Message-ID: <CACRpkdaxiBa=aBAxvE+k7WFgZ-zY_YgCsV4-JVv3SRcm_pX5hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 5:30 PM, Jamie Iles <jamie@jamieiles.com> wrote:
>> > So shouldn't this be doing a
>> > __get_cpu_var(ledtrig_cpu_triggers) and a kfree() on that (and setting
>> > to NULL)?
>>
>> You could do that but why? There is no way the pointer value
>> can make any harm. If activate() is called again it will be overwritten
>> with the new pointer.
>
> Yes, but can't ledtrig_cpu() potentially still be called after
> deactivation, then the:
>
> ? ? ? ?if (!trigdata)
> ? ? ? ? ? ? ? ?return;
>
> would be incorrect? ?My main point though was that it looks like
> led->trigger_data is the processor id and kfree() is being called on
> that.

You're right, it just works fine because trigdata is always NULL...

>> > Also, where does led->trigger_data get assigned with the cpu id?
>>
>> The activate() function is called on every core and if the CPU ID
>> is not equal to the assigned CPU it just exits, here:
>>
>> + ? ? int my_cpu = smp_processor_id();
>> + ? ? unsigned long target_cpu = (unsigned long) led->trigger_data;
>> +
>> + ? ? if (target_cpu != my_cpu)
>> + ? ? ? ? ? ? return;
>
> I understand that bit, but I can't see anything that actually assigns
> led->trigger_data in the first place.

You're right, it's because nothing really does. And since
kfree(NULL); is fine this works, and makes the above thing work
fine as well.

Since led->trigger_data is never used we shouldn't touch it in
I believe, Bryan can you just take it out and replace with something
like this (totally untested):

static void ledtrig_cpu_deactivate_cpu(struct led_classdev *led)
{
       struct ledtrig_cpu_data *cpu_data = __get_cpu_var(ledtrig_cpu_triggers);
       int my_cpu = smp_processor_id();
       unsigned long target_cpu = (unsigned long) led->trigger_data;

       if (target_cpu != my_cpu)
               return;

       kfree(cpu_data);
       __get_cpu_var(ledtrig_cpu_triggers) = NULL;
}

static void ledtrig_cpu_activate(struct led_classdev *led)
{
       on_each_cpu(ledtrig_cpu_deactivate_cpu, led, 1);
}

Bryan can you test this change?

Thanks!
Linus Walleij
