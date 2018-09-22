From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 22 Sep 2018 13:29:48 +0200
Subject: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
Message-ID: <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/2018 13:30, Alexandre Belloni wrote:
> Hi,
> 
> This series reworks the Atmel TCB drivers. It introduces a new driver to handle
> the clocksource and clockevent devices.
> 
> This is necessary because:
>  - the current tcb_clksrc driver is probed too late to be able to be used at
>    boot and we now have SoCs that don't have a PIT. They currently are not able
>    to boot a mainline kernel.
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART and their interrupt flags are
>    incompatible)

You say for rt the PIT is not suitable because of the shared irq but in
the driver, the interrupt is flagged as shared.

>  - the current solution is wasting some TCB channels
> 
> The plan is to get this driver upstream, then convert the TCB PWM driver to be
> able to get rid of the tcb_clksrc driver along with atmel_tclib now that AVR32
> is gone.
> 
> changes in v7:
>  - fixed a warning when building on 64 bit platforms
> 
> changes in v6:
>  - rebased on v4.19-rc1
>  - separated the clocksource/clockevent and the single clockevent in two
>    different patches
>  - removed struct tc_clkevt_device and simply use struct atmel_tcb_clksrc
>  - removed struct atmel_tcb_info
>  - moved tcb_clk_get and tcb_irq_get to users
> 
> changes in v5:
>  - rebased on v4.18-rc1
>  - fixed the clock enabling/disabling in atomic context under preempt-rt
> 
> Changes in v4:
>  - rebased on top of v4.17-rc1
>  - fixed an issue when setting max_delta for clockevents_config_and_register
> 
> Alexandre Belloni (7):
>   ARM: at91: add TCB registers definitions
>   clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
>   clocksource/drivers: timer-atmel-tcb: add clockevent device on
>     separate channel
>   clocksource/drivers: atmel-pit: make option silent
>   ARM: at91: Implement clocksource selection
>   ARM: configs: at91: use new TCB timer driver
>   ARM: configs: at91: unselect PIT
> 
>  arch/arm/configs/at91_dt_defconfig    |   2 +-
>  arch/arm/configs/sama5_defconfig      |   2 +-
>  arch/arm/mach-at91/Kconfig            |  25 ++
>  drivers/clocksource/Kconfig           |  13 +-
>  drivers/clocksource/Makefile          |   3 +-
>  drivers/clocksource/timer-atmel-tcb.c | 617 ++++++++++++++++++++++++++
>  include/soc/at91/atmel_tcb.h          | 183 ++++++++
>  7 files changed, 841 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clocksource/timer-atmel-tcb.c
>  create mode 100644 include/soc/at91/atmel_tcb.h
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
