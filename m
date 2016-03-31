From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Thu, 31 Mar 2016 09:04:04 +0200
Subject: [PATCH 1/3] leds: trigger: Introduce a kernel panic LED trigger
In-Reply-To: <20160330191109.GA27372@laptop.cereza>
References: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1459283749-22451-2-git-send-email-ezequiel@vanguardiasur.com.ar>
 <56FB9C6A.2090402@samsung.com> <20160330191109.GA27372@laptop.cereza>
Message-ID: <56FCCBE4.7010004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 03/30/2016 09:11 PM, Ezequiel Garcia wrote:
> +lkml
>
> On 30 Mar 11:29 AM, Jacek Anaszewski wrote:
>> Hi Ezequiel,
>>
>> Thanks for the patch. I've tested it on exynos4412-trats2 board
>> with leds-aat1290 driver, by executing:
>>
>> echo "c" > /proc/sysrq-trigger
>>
>> I was able to notice the blinking then.
>>
>> Applied to the for-next branch of linux-leds.git.
>>
>
> Notice that we currently need LEDs to be dedicated
> to the panic trigger, which is pretty lame as LEDs
> are scarce and are most likely assigned to something else.
>
> So, here's a toy patch to switch all the installed LEDs
> to the panic trigger on kernel panic. Patch is half-baked,
> but it shows the idea.
>
> (Interestingly, it also blinks the LEDs on a USB keyboard!)
>
> Is there any value in polishing this and find a way upstream?

I like the idea, but I'd rather explicitly mark LEDs as panic
indicators.

How about adding a "kernel-panic-indicator" Device Tree property to
common LED bindings? LED class device could be registered for the
panic trigger on kernel panic notification only when the property is
present.

Adding Rob, Mark and devicetree list.

> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index aa84e5b37593..caaf6161a7ae 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -321,6 +321,20 @@ void devm_led_classdev_unregister(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_led_classdev_unregister);
>
> +static int led_panic_notifier(struct notifier_block *nb,
> +			      unsigned long code, void *unused)
> +{
> +	struct led_classdev *led_cdev;
> +
> +	list_for_each_entry(led_cdev, &leds_list, node)
> +		led_trigger_set_at_panic(led_cdev, "panic");
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block led_panic_nb = {
> +	.notifier_call = led_panic_notifier,
> +};
> +
>   static int __init leds_init(void)
>   {
>   	leds_class = class_create(THIS_MODULE, "leds");
> @@ -328,6 +342,8 @@ static int __init leds_init(void)
>   		return PTR_ERR(leds_class);
>   	leds_class->pm = &leds_class_dev_pm_ops;
>   	leds_class->dev_groups = led_groups;
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &led_panic_nb);
>   	return 0;
>   }
>
> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
> index 2181581795d3..8c1d33acdfa8 100644
> --- a/drivers/leds/led-triggers.c
> +++ b/drivers/leds/led-triggers.c
> @@ -148,6 +148,21 @@ void led_trigger_remove(struct led_classdev *led_cdev)
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_remove);
>
> +void led_trigger_set_at_panic(struct led_classdev *led_cdev, const char *name)
> +{

"name" parameter is not required, since setting other trigger than panic
on kernel panic doesn't make sense.

> +	struct led_trigger *trig;
> +
> +	list_for_each_entry(trig, &trigger_list, next_trig) {
> +		if (strcmp(name, trig->name))
> +			continue;
> +		list_add_tail(&led_cdev->trig_list, &trig->led_cdevs);
> +		led_cdev->trigger = trig;
> +		if (trig->activate)
> +			trig->activate(led_cdev);
> +		break;
> +	}
> +}
> +
>   void led_trigger_set_default(struct led_classdev *led_cdev)
>   {
>   	struct led_trigger *trig;
> diff --git a/drivers/leds/leds.h b/drivers/leds/leds.h
> index db3f20da7221..8cfa10f626a6 100644
> --- a/drivers/leds/leds.h
> +++ b/drivers/leds/leds.h
> @@ -21,6 +21,7 @@ static inline int led_get_brightness(struct led_classdev *led_cdev)
>   	return led_cdev->brightness;
>   }
>
> +void led_trigger_set_at_panic(struct led_classdev *led_cdev, const char *name);
>   void led_init_core(struct led_classdev *led_cdev);
>   void led_stop_software_blink(struct led_classdev *led_cdev);
>   void led_set_brightness_nopm(struct led_classdev *led_cdev,
>


-- 
Best regards,
Jacek Anaszewski
