From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 9 Jun 2011 13:34:56 +0900
Subject: [PATCH v2 0/4] Samsung: Move Samsung SoCs GPIO drivers to
	drivers/gpio
In-Reply-To: <BANLkTikKs5E8WNSCG680mk2ow3+SH2WKLA@mail.gmail.com>
References: <BANLkTikKs5E8WNSCG680mk2ow3+SH2WKLA@mail.gmail.com>
Message-ID: <BANLkTima+xCpq5hKkPQkZuuyqsyk6Vhxww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2011 at 1:05 PM, Bhuvana Kakunoori
<bhuvana.kakunoori@linaro.org> wrote:
> Hi Kyungmin,
>
> This is regards to the patch submitted by you at
> http://www.spinics.net/lists/arm-kernel/msg125861.html
> I didnt have the thread in my mailbox, so starting another thread.
> Can you please let me know, what were your plans for consolidation when you
> moved these folders to drivers/gpio?

At least s5p100, s5pc110, and s5pc210 (aka exynos4) gpio drivers are
moved and merged already.
I want to make a simplified GPIO drivers for Samsung GPIOs.

e.g., most recent (please ignore the old s3c24xx series GPIOs) SoCs
use the 4-bit based GPIOs and has 8 pins at each banks.
so it can defined as below and use the macro at drivers.

#define SAMSUNG_GPIO(group, n)    (((group) * 8) + (n))
enum s5pv210_gpio_groups {
           S5PV210_GPA0,
           S5PV210_GPA1,
           ...
};

SAMSUNG_GPIO(S5PV210_GPA0, n);

In the view of files & directories
drivers/gpio/gpio-samsung.c for generic samsung gpio drivers.
pass the required information with platform data. then driver got the
platform data and register each gpio groups.
it only defined the how many gpio banks are required and its base address.
Of course there's special case, external GPIOs. then we set the flags
as SAMSUNG_EXTERNAL_GPIO_FLAGS
and register it as external gpios.

I also consider to use the basic_mmio_gpios but it required to modify
and need to expand for our use case since pullup and strength
handling. but finally these are also should be moved to proper
framework. as it's not defined at generic gpio drivers. Maybe pinmux
can handle these.

Do you have any ideas or opinions. then please let me know.

Thank you,
Kyungmin Park

> I was looking into the gpio code for samsung platforms, and wanted to know
> what you are working on.
>
> Regards
> Bhuvana
>
