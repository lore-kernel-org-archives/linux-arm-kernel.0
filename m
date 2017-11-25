From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 25 Nov 2017 15:33:24 -0800
Subject: [PATCH 0/5] Make gpio_keys accept board descriptors
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Message-ID: <20171125233324.afdt4netamvkrkm2@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Nov 24, 2017 at 10:30:40AM +0100, Linus Walleij wrote:
> The goal I'm working toward is to rid the kernel of the global
> GPIO numberspace.
> 
> This means GPIO lines should be references by the local offset
> on the GPIO chip.
> 
> This patch set starts to move gpio_keys toward using GPIO
> look-up tables instead of global GPIO numbers to find their
> GPIOs.
> 
> As an example I did (I think) the necessary patches to
> convert DaVinci and i.MX to use this. There are several users
> also x86 platform devices.
> 
> Strategy:
> 
> - Merge the patch to input/keyboard/gpio_keys* to support
>   using descriptors from board files.
> 
> - Refactor the whole universe to get proper names on GPIO
>   chips, and reference the GPIO lines with local offsets using
>   tables, as in the example patches in this series. These
>   can trickle in after the first patch is merged in Input.
>   The work to be done can be seen if you type:
>   git grep gpio_keys_platform_data
> 
> - When all are refactored, remove the "gpio" and "active low"
>   members from the platform data and delete the associated
>   legacy GPIO handling in the input driver for gpio_keys.
> 
> Posting this with the examples to get buy-in from Dmitry
> before I go and spend time refactoring the world.

I think this is a worthy goal, but I wonder if we could get static GPIO
descriptors work with fwnode_get_named_gpiod() so we could retire the
platform data parsing altogether. We'd need to extend static device
properties to have notion of children though.

Thanks.

-- 
Dmitry
