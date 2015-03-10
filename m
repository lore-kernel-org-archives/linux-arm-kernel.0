From: rjui@broadcom.com (Ray Jui)
Date: Tue, 10 Mar 2015 10:57:00 -0700
Subject: [PATCH v6 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <CACRpkdZ1ErfikdF41aANTM-7LE6AExizHtCZTq1_TTxwYjeSQA@mail.gmail.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>	<1425933902-20652-7-git-send-email-rjui@broadcom.com>
 <CACRpkdZ1ErfikdF41aANTM-7LE6AExizHtCZTq1_TTxwYjeSQA@mail.gmail.com>
Message-ID: <54FF306C.7020407@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 3/10/2015 3:20 AM, Linus Walleij wrote:
> On Mon, Mar 9, 2015 at 9:45 PM, Ray Jui <rjui@broadcom.com> wrote:
> 
>> This adds the initial support of the Broadcom Cygnus GPIO/PINCONF driver
>> that supports all 3 GPIO controllers on Cygnus including the ASIU GPIO
>> controller, the chipCommonG GPIO controller, and the always-on GPIO
>> controller. Basic PINCONF configurations such as bias pull up/down, and
>> drive strength are also supported in this driver.
>>
>> Pins from the ASIU GPIO controller can be individually muxed to GPIO
>> function, through interaction with the Cygnus IOMUX controller
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Tested-by: Dmitry Torokhov <dtor@chromium.org>
> 
> Patch applied! But please look at this:
> 
>> +#include <linux/gpio.h>
> 
> Doesn't just #include <linux/gpio/driver.h> work?
> 

I think I need linux/gpio.h for gpiochip_add_pin_range and some related
APIs.

>> +static int __init cygnus_gpio_init(void)
>> +{
>> +       return platform_driver_probe(&cygnus_gpio_driver, cygnus_gpio_probe);
>> +}
>> +arch_initcall_sync(cygnus_gpio_init);
> 
> arch_initcall_sync() is a bit brutal.
> 
> Can you please investigate if you can have this as a normal device_initcall()
> utilizing deferred probe if necessary?
> 
> Follow-up patches accepted!
> 

I understand. Further investigation is needed and this may take a while,
since a lot of our Cygnus drivers depend on GPIO and regulators (and all
need to be converted to check against deferred probe errors). If
possible, I'll definitely fix this.

> Yours,
> Linus Walleij
> 
