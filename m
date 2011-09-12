From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 12 Sep 2011 17:14:29 +0530
Subject: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
In-Reply-To: <87bouxz21m.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87bouxz21m.fsf@ti.com>
Message-ID: <CAC83ZvLkM+=SmcC-p0Yjmni00wug4XLGQ=HP0+-VZPsx7b1uMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> I tested this series on top of v3.1-rc4 using a 3430/n900 platform.
>
> During suspend the PER powerdomain does not hit the targetted power
> state. ?Also, in idle PER never hits retention.
>
> As with previous versions of this series, it appears to be related to
> debounce clocks being left enabled. ?On my n900, I removed debounce from
> all the GPIO keys pads and PER was then able to hit retention during
> suspend and idle.
>
> Please be sure to test on a platform that is using debounce, or modify
> the board file for one of the platforms your testing so that at least
> one of the GPIOs has debounce enabled so you are verifying the debounce
> clock gating during suspend and idle.
I was able to re-produce the problem by making explicit call to
_set_gpio_debounce() in *_mod_init().
Prior to calling this I initialized: bank->dbck = clk_get(bank->dev,
"dbclk"); as in the function below.
Later I realized that there is no alias associated with "dbclk" for GPIO[2-6].

static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
                unsigned debounce)
{
...
        if (!bank->dbck) {
                bank->dbck = clk_get(bank->dev, "dbclk");
...
        }

After incorporating the following alias I was able to put system to OFF.

static struct omap_clk omap3xxx_clks[] = {
...
        CLK("omap_gpio.6",       "dbclk",   &gpio6_dbck,    CK_3XXX),
        CLK("omap_gpio.5",       "dbclk",   &gpio5_dbck,    CK_3XXX),
        CLK("omap_gpio.4",       "dbclk",   &gpio4_dbck,    CK_3XXX),
        CLK("omap_gpio.3",       "dbclk",   &gpio3_dbck,    CK_3XXX),
        CLK("omap_gpio.2",       "dbclk",   &gpio2_dbck,    CK_3XXX),

--
Tarun
>
> Thanks,
>
> Kevin
>
