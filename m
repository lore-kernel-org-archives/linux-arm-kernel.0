From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Tue, 5 Apr 2016 23:36:05 +0200
Subject: [PATCH 1/5] leds: triggers: Allow to switch the trigger to
 "panic" on a kernel panic
In-Reply-To: <1459801326-5541-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1459801326-5541-2-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <57042FC5.5090707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Thanks for the patch. I have one comment below.

On 04/04/2016 10:22 PM, Ezequiel Garcia wrote:
> This commit adds a new led_cdev flag LED_BLINK_AT_PANIC, which
> allows to mark a specific LED to be switched to the "panic"
> trigger, on a kernel panic.
>
> This is useful to allow the user to assign a regular trigger
> to a given LED, and still blink that LED on a kernel panic.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>   drivers/leds/led-triggers.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/leds.h        |  1 +
>   2 files changed, 53 insertions(+)
>
> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
> index 2181581795d3..f5c9d7c4d181 100644
> --- a/drivers/leds/led-triggers.c
> +++ b/drivers/leds/led-triggers.c
> @@ -148,6 +148,43 @@ void led_trigger_remove(struct led_classdev *led_cdev)
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_remove);
>
> +/*
> + * This is a called in a special context by the atomic panic
> + * notifier. This means the trigger can be changed without
> + * worrying about locking.
> + */
> +static void led_trigger_set_panic(struct led_classdev *led_cdev)
> +{
> +	struct led_trigger *trig;
> +
> +	list_for_each_entry(trig, &trigger_list, next_trig) {
> +		if (strcmp("panic", trig->name))
> +			continue;
> +		if (led_cdev->trigger)
> +			list_del(&led_cdev->trig_list);
> +		list_add_tail(&led_cdev->trig_list, &trig->led_cdevs);
> +		led_cdev->trigger = trig;
> +		if (trig->activate)
> +			trig->activate(led_cdev);
> +		break;
> +	}
> +}
> +
> +static int led_trigger_panic_notifier(struct notifier_block *nb,
> +				      unsigned long code, void *unused)
> +{
> +	struct led_classdev *led_cdev;
> +
> +	list_for_each_entry(led_cdev, &leds_list, node)
> +		if (led_cdev->flags & LED_BLINK_AT_PANIC)
> +			led_trigger_set_panic(led_cdev);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block led_trigger_panic_nb = {
> +	.notifier_call = led_trigger_panic_notifier,
> +};
> +
>   void led_trigger_set_default(struct led_classdev *led_cdev)
>   {
>   	struct led_trigger *trig;
> @@ -356,6 +393,21 @@ void led_trigger_unregister_simple(struct led_trigger *trig)
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_unregister_simple);
>
> +static int __init leds_trigger_init(void)
> +{
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &led_trigger_panic_nb);
> +	return 0;
> +}
> +
> +static void __exit leds_trigger_exit(void)
> +{
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &led_trigger_panic_nb);
> +}
> +module_init(leds_trigger_init);
> +module_exit(leds_trigger_exit);
> +
>   MODULE_AUTHOR("Richard Purdie");
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("LED Triggers Core");
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index f203a8f89d30..7f1428bb1e69 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -50,6 +50,7 @@ struct led_classdev {
>   #define LED_SYSFS_DISABLE	(1 << 22)
>   #define LED_DEV_CAP_FLASH	(1 << 23)
>   #define LED_HW_PLUGGABLE	(1 << 24)
> +#define LED_BLINK_AT_PANIC	(1 << 25)

LED_BLINK prefixed macros control LED subsystem inherent
blinking feature.

Would you mind renaming it to LED_PANIC_INDICATOR?

>
>   	/* Set LED brightness level
>   	 * Must not sleep. Use brightness_set_blocking for drivers
>

-- 
Best regards,
Jacek Anaszewski
