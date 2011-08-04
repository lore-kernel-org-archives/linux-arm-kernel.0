From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 4 Aug 2011 17:18:08 +0800
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <CAHXqBF+8i7P9WhR0pjUPaew0bkzwE26Pr1u2V09PSZwhkdmCUQ@mail.gmail.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
	<CAHXqBF+8i7P9WhR0pjUPaew0bkzwE26Pr1u2V09PSZwhkdmCUQ@mail.gmail.com>
Message-ID: <CAK5ve-KYfa1Tvd4mwUs8uyY2jX=eDgxG4=rWevHsXfTariffJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/3 Micha? Miros?aw <mirqus@gmail.com>:
> 2011/8/3 Bryan Wu <bryan.wu@canonical.com>:
>> Attempting to consolidate the ARM LED code, this removes the
>> custom RealView LED trigger code to turn LEDs on and off in
>> response to CPU activity and replace it with a standard trigger.
> [...]
>> +void ledtrig_cpu(enum cpu_led_event ledevt)
>> +{
>> + ? ? ? struct ledtrig_cpu_data *trigdata = __get_cpu_var(ledtrig_cpu_triggers);
>> +
>> + ? ? ? if (!trigdata)
>> + ? ? ? ? ? ? ? return;
>> +
>> + ? ? ? /* Locate the correct CPU LED */
>> +
>> + ? ? ? switch (ledevt) {
>> + ? ? ? case CPU_LED_IDLE_START:
>> + ? ? ? case CPU_LED_START:
>> + ? ? ? ? ? ? ? /* Will turn the LED on, max brightness */
>> + ? ? ? ? ? ? ? if (trigdata->led)
>> + ? ? ? ? ? ? ? ? ? ? ? led_set_brightness(trigdata->led,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?trigdata->led->max_brightness);
>> + ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? case CPU_LED_IDLE_END:
>> + ? ? ? case CPU_LED_STOP:
>> + ? ? ? case CPU_LED_HALTED:
>> + ? ? ? ? ? ? ? /* Will turn the LED off */
>> + ? ? ? ? ? ? ? if (trigdata->led)
>> + ? ? ? ? ? ? ? ? ? ? ? led_set_brightness(trigdata->led, LED_OFF);
>> + ? ? ? ? ? ? ? break;
>
> Might be better to swap CPU_LED_IDLE_START with CPU_LED_IDLE_END here
> so that when entering idle state the leds turn off.
>

Good point, I will change that.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
