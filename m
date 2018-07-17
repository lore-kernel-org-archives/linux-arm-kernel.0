From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 17 Jul 2018 21:16:08 +0200
Subject: [PATCH 0/4] rework ULP1 patches
In-Reply-To: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
References: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180717191608.GA3211@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/2018 11:26:53+0300, Claudiu Beznea wrote:
> Hi,
> 
> Based on the discussion at [1] and private discussion I had with Alexandre
> Belloni on IRC, I reworked ULP1 patches to remove device tree bindings
> proposed in [1].
> 
> The implementation from this patches (mostly patch 4/4) is using
> device_may_wakeup() API that current Linux code provides and the fact that
> for the ULP1 the wakeup souces are known and well defined.
> Basically, this rework (mostly patch 4/4) loops through well defined ULP1
> wakeup sources and check if those wakeup sources were configured to wake
> up the system (vid DT or sysfs) and, based on that (and in case of RTC,
> based on SHDWC.MR), set the PMC fast startup mode and polarity registers.
> In [1] PMC fast startup mode and polarity registers were configured by
> introducing new DT bindings.
> 
> Since with these patches SHDWC registers are used in ULP1 wakeup sources
> configuration the patch 4/4 changed a bit the PM initialization phase for
> SAMA5D2 in order to have mapped also the SHDWC in case ULP1 needs to be
> initialized. In case ULP1 configuration fails the ULP0 mode is used (same
> approach as in backup mode case).
> 
> I measure the delay introduced in suspend sequence by using an oscilloscope
> connected to a GPIO and calling gpio_direction_output(PIN, 0) at the beginning
> of at91_pm_config_ws() and gpio_direction_output(PIN, 1) at the end of
> at91_pm_config_ws(). With these I measureed on oscilloscope the difference
> b/w the front changes. The measured time was *1.56ms*. Keep in mind that
> gpio_direction_output() will call, in the end,
> atmel_gpio_direction_output() which access 4 registers to toggle the PIN
> (in at91_pm_config_ws() there are also 4 peripheral register accesses).
> 
> Besides this rework, I took the chance and I appended few other patches to
> this series, based on Wenyou Yang's previous work, related to ULP modes.
> 
> Patch 1/4: replaces slow clock with ULP0
> Patch 2/4: is the Wenyou's patch wich adds ULP1 support
> Patch 3/4: is defining PMC fast startup registers
> 
> The patches were based on v4.18-rc1.
> 
> [1] https://patchwork.kernel.org/patch/8595091/
> 
> Claudiu Beznea (3):
>   ARM: at91: pm: Use ULP0 naming instead of slow clock
>   ARM: at91: pm: add PMC fast startup registers defines
>   ARM: at91: pm: configure wakeup sources for ULP1 mode
> 
> Wenyou Yang (1):
>   ARM: at91: pm: Add ULP1 mode support
> 
>  arch/arm/mach-at91/pm.c         | 184 +++++++++++++++++++++++++++++++++-------
>  arch/arm/mach-at91/pm.h         |   6 +-
>  arch/arm/mach-at91/pm_suspend.S | 142 ++++++++++++++++++++++++++-----
>  include/linux/clk/at91_pmc.h    |  15 ++++
>  4 files changed, 294 insertions(+), 53 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
