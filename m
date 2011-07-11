From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 11 Jul 2011 22:36:49 +0800
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <20110710092426.GR4812@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>
	<20110710092426.GR4812@n2100.arm.linux.org.uk>
Message-ID: <CAK5ve-+Pr8EDa8mfhZVbf8ADc2YDU0EyTPL3Fwwipj237tgKQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 5:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 06, 2011 at 08:34:46PM +0800, Bryan Wu wrote:
>> diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
>> index 5778274..13e4e5d 100644
>> --- a/arch/arm/mach-sa1100/assabet.c
>> +++ b/arch/arm/mach-sa1100/assabet.c
>> @@ -19,6 +19,8 @@
>> ?#include <linux/mtd/partitions.h>
>> ?#include <linux/delay.h>
>> ?#include <linux/mm.h>
>> +#include <linux/leds.h>
>> +#include <linux/slab.h>
>>
>> ?#include <mach/hardware.h>
>> ?#include <asm/mach-types.h>
>> @@ -445,6 +447,79 @@ static void __init assabet_map_io(void)
>> ? ? ? sa1100_register_uart(2, 3);
>> ?}
>>
>> +/* LEDs */
>> +struct assabet_led {
>> + ? ? struct led_classdev cdev;
>> + ? ? u32 mask;
>> +};
>> +
>> +/*
>> + * The triggers lines up below will only be used if the
>> + * LED triggers are compiled in.
>> + */
>> +static const struct {
>> + ? ? const char *name;
>> + ? ? const char *trigger;
>> +} assabet_leds[] = {
>> + ? ? { "assabet:red", "cpu",},
>> + ? ? { "assabet:green", "heartbeat", },
>> +};
>> +
>> +static void assabet_led_set(struct led_classdev *cdev,
>> + ? ? ? ? ? ? enum led_brightness b)
>> +{
>> + ? ? struct assabet_led *led = container_of(cdev,
>> + ? ? ? ? ? ? ? ? ? ? struct assabet_led, cdev);
>> +
>> + ? ? if (b != LED_OFF)
>> + ? ? ? ? ? ? ASSABET_BCR_clear(led->mask);
>> + ? ? else
>> + ? ? ? ? ? ? ASSABET_BCR_set(led->mask);
>> +}
>> +
>> +static enum led_brightness assabet_led_get(struct led_classdev *cdev)
>> +{
>> + ? ? struct assabet_led *led = container_of(cdev,
>> + ? ? ? ? ? ? ? ? ? ? struct assabet_led, cdev);
>> +
>> + ? ? return (ASSABET_BCR & led->mask) ? LED_OFF : LED_FULL;
>> +}
>> +
>> +static int __init assabet_leds_init(void)
>> +{
>> + ? ? int i;
>> +
>> + ? ? for (i = 0; i < ARRAY_SIZE(assabet_leds); i++) {
>> + ? ? ? ? ? ? struct assabet_led *led;
>> +
>> + ? ? ? ? ? ? led = kzalloc(sizeof(*led), GFP_KERNEL);
>> + ? ? ? ? ? ? if (!led)
>> + ? ? ? ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? ? ? ? led->cdev.name = assabet_leds[i].name;
>> + ? ? ? ? ? ? led->cdev.brightness_set = assabet_led_set;
>> + ? ? ? ? ? ? led->cdev.brightness_get = assabet_led_get;
>> + ? ? ? ? ? ? led->cdev.default_trigger = assabet_leds[i].trigger;
>> +
>> + ? ? ? ? ? ? if (!i)
>> + ? ? ? ? ? ? ? ? ? ? led->mask = ASSABET_BCR_LED_RED;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? led->mask = ASSABET_BCR_LED_GREEN;
>> +
>> + ? ? ? ? ? ? if (led_classdev_register(NULL, &led->cdev) < 0) {
>> + ? ? ? ? ? ? ? ? ? ? kfree(led);
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> + ? ? return 0;
>> +}
>> +
>> +/*
>> + * Since we may have triggers on any subsystem, defer registration
>> + * until after subsystem_init.
>> + */
>> +fs_initcall(assabet_leds_init);
>
> This is buggy. ?init functions are called irrespective of what platform
> we're running on, so this means if assabet is built in to the kernel,
> then we'll register its LEDs and try to access the BCR register
> irrespective of whether we are on assabet or not.
>

Right, I got it. So if we are going to run a single binary for all the
sa1100 machines, how about we check the machine in each fs_initcall

static int __init assabet_leds_init(void)
{
 ? ? int i;

     if (!machine_is_assabet())
          return -ENODEV,

 ? ? for (i = 0; i < ARRAY_SIZE(assabet_leds); i++) {
 ? ? ? ? ? ? struct assabet_led *led;

Thanks,

>> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
>> index cfb7607..6f87258 100644
>> --- a/arch/arm/mach-sa1100/simpad.c
>> +++ b/arch/arm/mach-sa1100/simpad.c
>> @@ -13,6 +13,8 @@
>> ?#include <linux/mtd/mtd.h>
>> ?#include <linux/mtd/partitions.h>
>> ?#include <linux/io.h>
>> +#include <linux/leds.h>
>> +#include <linux/slab.h>
>>
>> ?#include <asm/irq.h>
>> ?#include <mach/hardware.h>
>> @@ -205,7 +207,53 @@ static struct platform_device *devices[] __initdata = {
>> ? ? ? &simpad_mq200fb
>> ?};
>>
>> +/* LEDs */
>> +#define LED_GREEN ? ?1
>>
>> +static void simpad_led_set(struct led_classdev *cdev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? enum led_brightness b)
>> +{
>> + ? ? if (b != LED_OFF)
>> + ? ? ? ? ? ? set_cs3_bit(LED_GREEN);
>> + ? ? else
>> + ? ? ? ? ? ? clear_cs3_bit(LED_GREEN);
>> +}
>> +
>> +static enum led_brightness simpad_led_get(struct led_classdev *cdev)
>> +{
>> + ? ? u32 reg = *(CS3BUSTYPE *)(CS3_BASE);
>> +
>> + ? ? return (reg & LED_GREEN) ? LED_FULL : LED_OFF;
>> +}
>> +
>> +static int __init simpad_leds_init(void)
>> +{
>> + ? ? struct led_classdev *simpad_led;
>> + ? ? int ret;
>> +
>> + ? ? simpad_led = kzalloc(sizeof(*simpad_led), GFP_KERNEL);
>> + ? ? if (!simpad_led)
>> + ? ? ? ? ? ? return -ENOMEM;
>> +
>> + ? ? simpad_led->name = "simpad:green";
>> + ? ? simpad_led->brightness_set = simpad_led_set;
>> + ? ? simpad_led->brightness_get = simpad_led_get;
>> + ? ? simpad_led->default_trigger = "heartbeat";
>> +
>> + ? ? ret = led_classdev_register(NULL, simpad_led);
>> + ? ? if (ret < 0) {
>> + ? ? ? ? ? ? kfree(simpad_led);
>> + ? ? ? ? ? ? return ret;
>> + ? ? }
>> +
>> + ? ? return 0;
>> +}
>> +
>> +/*
>> + * Since we may have triggers on any subsystem, defer registration
>> + * until after subsystem_init.
>> + */
>> +fs_initcall(simpad_leds_init);
>
> Looks like simpad is similarly afflicted. ?I haven't gone through the
> rest to check for similar issues.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
