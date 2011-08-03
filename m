From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Aug 2011 17:22:02 +0200
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <20110803102829.GC2607@pulham.picochip.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
	<20110803102829.GC2607@pulham.picochip.com>
Message-ID: <CACRpkdZRh=gcedJQh6V3aUCfi2arn2V_P67MgZE2mB_hYZ-OnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 12:28 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> Hi Bryan,
> [...]
>> +static DEFINE_PER_CPU(struct ledtrig_cpu_data *, ledtrig_cpu_triggers);
> [...]
>> +static void ledtrig_cpu_activate_cpu(void *data)
>> +{
>> + ? ? struct ledtrig_cpu_data *cpu_data;
>> + ? ? struct led_classdev *led = data;
>> + ? ? int my_cpu = smp_processor_id();
>> + ? ? unsigned long target_cpu = (unsigned long) led->trigger_data;
>> +
>> + ? ? if (target_cpu != my_cpu)
>> + ? ? ? ? ? ? return;
>> +
>> + ? ? cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
>> + ? ? if (!cpu_data)
>> + ? ? ? ? ? ? return;
>> +
>> + ? ? dev_info(led->dev, "led %s indicate activity on CPU %d\n",
>> + ? ? ? ? ? ? ?led->name, my_cpu);
>> +
>> + ? ? cpu_data->led = led;
>> + ? ? __get_cpu_var(ledtrig_cpu_triggers) = cpu_data;
>> +}
>> +
>> +static void ledtrig_cpu_activate(struct led_classdev *led)
>> +{
>> + ? ? on_each_cpu(ledtrig_cpu_activate_cpu, led, 1);
>> +}
>> +
>> +static void ledtrig_cpu_deactivate(struct led_classdev *led)
>> +{
>> + ? ? struct ledtrig_cpu_data *cpu_data = led->trigger_data;
>> +
>> + ? ? kfree(cpu_data);
>> +}
>
> Is this deactivation correct? ?My (limited) understanding of the smp api
> is that we'll allocate the ledtrig_cpu_data for each CPU and store it in
> the ledtrig_cpu_triggers pointers.

At this point you have a handle to a specific LED and that one is tied
to a certain CPU aldready, since it is a member of
struct ledtrig_cpu_data. The LED is CPU-local by nature already since
it is looked up in the code being called from the ARM kernel,
i.e. the activate/deactivate pairs get called once per CPU.

> So shouldn't this be doing a
> __get_cpu_var(ledtrig_cpu_triggers) and a kfree() on that (and setting
> to NULL)?

You could do that but why? There is no way the pointer value
can make any harm. If activate() is called again it will be overwritten
with the new pointer.

> Also, where does led->trigger_data get assigned with the cpu id?

The activate() function is called on every core and if the CPU ID
is not equal to the assigned CPU it just exits, here:

+     int my_cpu = smp_processor_id();
+     unsigned long target_cpu = (unsigned long) led->trigger_data;
+
+     if (target_cpu != my_cpu)
+             return;

Yours,
Linus Walleij
