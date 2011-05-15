From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 15 May 2011 19:50:26 +0200
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <20110515133312.GM4071@lunn.ch>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110503172712.GE6538@lunn.ch>
	<BANLkTi=ncV3M1q5SXNdUaXmtfkZ8Wn9dmw@mail.gmail.com>
	<20110515133312.GM4071@lunn.ch>
Message-ID: <BANLkTi=O_mZEqMhOS_Fz0vAYCQ-XpyG4UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/15 Andrew Lunn <andrew@lunn.ch>:

> With a bit of scripting, came to the following results. Each line is
> on pinmux function description what would be needed in the driver. The
> number at the front says how many boards would use it. In total there
> are 33 descriptions needed. Of these, 18 are used only once. This to
> me suggests the board needs to be able to specify a pin description
> when there is no reuse with other boards.

As indicated elsewhere in this thread, a pinmux driver can pass in
platform/package/board/system data just like any other platform
driver in the kernel tree can.

You will have to specify it somehow in a custom header file, just
like with any other platform driver.

Example from:
arch/arm/mach-orion5x/ls-chl-setup.c:

static struct gpio_led lschl_led_pins[] = {
        {
                .name = "alarm:red",
                .gpio = LSCHL_GPIO_LED_ALARM,
                .active_low = 1,
        }, {
                .name = "info:amber",
                .gpio = LSCHL_GPIO_LED_INFO,
                .active_low = 1,
        }, {
                .name = "func:blue:top",
                .gpio = LSCHL_GPIO_LED_FUNC,
                .active_low = 1,
        }, {
                .name = "power:blue:bottom",
                .gpio = LSCHL_GPIO_LED_PWR,
        },
};

static struct gpio_led_platform_data lschl_led_data = {
        .leds = lschl_led_pins,
        .num_leds = ARRAY_SIZE(lschl_led_pins),
};

static struct platform_device lschl_leds = {
        .name = "leds-gpio",
        .id = -1,
        .dev = {
                .platform_data = &lschl_led_data,
        },
};

Still, the driver for these LEDs is in
drivers/leds/leds-gpio.c and the above structure is
described in include/linux/leds.h

There is no difference between this and letting
drivers/pinmux/pinmux-orion.c have a header file in
include/linux/pinmux/orion.h and pass in necessary board
data that way.

Are we now in agreement that this will work just fine?

Yours,
Linus Walleij
