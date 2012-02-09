From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 9 Feb 2012 14:03:56 +0200
Subject: [PATCH] gpio: omap: be more aggressive with pm_runtime
In-Reply-To: <20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <877gzwyivt.fsf@ti.com>
 <20120209060939.GB1121@legolas.emea.dhcp.ti.com>
 <20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
Message-ID: <CANOLnONWuEyp9pCPs-tJgyOd_-RdTNAz1axQHJ0d_0Rq37b3=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2012 at 1:11 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi again,
>
> On Thu, Feb 09, 2012 at 08:09:40AM +0200, Felipe Balbi wrote:
>> On Wed, Feb 08, 2012 at 04:01:42PM -0800, Kevin Hilman wrote:
>> > Felipe Balbi <balbi@ti.com> writes:
>> >
>> > > try to keep gpio block suspended as much as possible.
>> > >
>> > > Tested with pandaboard and a sysfs exported gpio.
>> > >
>> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > > ---
>> >
>> > Looks like you need a few more get/puts around other places where
>> > registers are accessed. ?It currently causes a boot crash on OMAP3 in
>> > _set_gpio_triggering().
>>
>> it was a missing get/put on gpio_irq_set_type(). Fixed.
>>
>> > Did you test GPIO wakeups? ?both IO ring wakeups and GPIO module-level
>> > wakeups?
>>
>> how can I test that easily with panda ?
>
> Ok, I have added gpio-keys to panda's boardfile:
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 30ad40d..0a38282 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -23,6 +23,7 @@
> ?#include <linux/io.h>
> ?#include <linux/leds.h>
> ?#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> ?#include <linux/usb/otg.h>
> ?#include <linux/i2c/twl.h>
> ?#include <linux/regulator/machine.h>
> @@ -90,7 +91,30 @@ static struct platform_device leds_gpio = {
> ? ? ? ?},
> ?};
>
> +static struct gpio_keys_button gpio_buttons[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .code ? ? ? ? ? = BTN_EXTRA,
> + ? ? ? ? ? ? ? .gpio ? ? ? ? ? = 121,
> + ? ? ? ? ? ? ? .desc ? ? ? ? ? = "user",
> + ? ? ? ? ? ? ? .wakeup ? ? ? ? = 1,

While at it, could you also test GPIO module wakeups with debounce
feature enabled? Kevin says it should work but it doesn't for me. Just
add:
    .debounce_interval = 10,


-- 
Gra?vydas
