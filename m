From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 3 Aug 2011 11:28:29 +0100
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110803102829.GC2607@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

On Wed, Aug 03, 2011 at 05:34:33PM +0800, Bryan Wu wrote:
> Attempting to consolidate the ARM LED code, this removes the
> custom RealView LED trigger code to turn LEDs on and off in
> response to CPU activity and replace it with a standard trigger.
> 
> (bryan.wu at canonical.com:
> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
> It also provides ledtrig_cpu trigger event stub in <linux/leds.h>.
> Although it was inspired by ARM work, it can be used in other arch.)
> 
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  drivers/leds/Kconfig       |   10 +++
>  drivers/leds/Makefile      |    1 +
>  drivers/leds/ledtrig-cpu.c |  144 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/leds.h       |   15 +++++
>  4 files changed, 170 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/leds/ledtrig-cpu.c
> 
> diff --git a/drivers/leds/ledtrig-cpu.c b/drivers/leds/ledtrig-cpu.c
> new file mode 100644
> index 0000000..0537c3b
[...]
> +static DEFINE_PER_CPU(struct ledtrig_cpu_data *, ledtrig_cpu_triggers);
[...]
> +static void ledtrig_cpu_activate_cpu(void *data)
> +{
> +	struct ledtrig_cpu_data *cpu_data;
> +	struct led_classdev *led = data;
> +	int my_cpu = smp_processor_id();
> +	unsigned long target_cpu = (unsigned long) led->trigger_data;
> +
> +	if (target_cpu != my_cpu)
> +		return;
> +
> +	cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
> +	if (!cpu_data)
> +		return;
> +
> +	dev_info(led->dev, "led %s indicate activity on CPU %d\n",
> +		 led->name, my_cpu);
> +
> +	cpu_data->led = led;
> +	__get_cpu_var(ledtrig_cpu_triggers) = cpu_data;
> +}
> +
> +static void ledtrig_cpu_activate(struct led_classdev *led)
> +{
> +	on_each_cpu(ledtrig_cpu_activate_cpu, led, 1);
> +}
> +
> +static void ledtrig_cpu_deactivate(struct led_classdev *led)
> +{
> +	struct ledtrig_cpu_data *cpu_data = led->trigger_data;
> +
> +	kfree(cpu_data);
> +}

Is this deactivation correct?  My (limited) understanding of the smp api 
is that we'll allocate the ledtrig_cpu_data for each CPU and store it in 
the ledtrig_cpu_triggers pointers.  So shouldn't this be doing a 
__get_cpu_var(ledtrig_cpu_triggers) and a kfree() on that (and setting 
to NULL)?

Also, where does led->trigger_data get assigned with the cpu id?

Jamie
