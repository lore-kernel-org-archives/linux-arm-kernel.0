From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 22 Mar 2018 16:33:47 +0100
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
Message-ID: <20180322153347.GX3417@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

I'd really like to get this in the kernel soon as we have platform that
still can't boot with a mainline kernel because they don't have a PIT.

On 23/02/2018 at 18:15:52 +0100, Alexandre Belloni wrote:
> Hi,
> 
> This series gets back on the TCB drivers rework. It introduces a new driver to
> handle the clocksource and clockevent devices.
> 
> As a reminder, this is necessary because:
>  - the current tcb_clksrc driver is probed too late to be able to be used at
>    boot and we now have SoCs that don't have a PIT. They currently are not able
>    to boot a mainline kernel.
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART and their interrupt flags are
>    incompatible)
>  - the current solution is wasting some TCB channels
> 
> The plan is to get this driver upstream, then convert the TCB PWM driver to be
> able to get rid of the tcb_clksrc driver along with atmel_tclib.
> 
> changes in v3:
>  - use SPDX tag in include/soc/at91/atmel_tcb.h
>  - rework option selection to make the clocksource option silent
> 
> Main changes in v2:
>  - use direct IO instead of regmap when accessing channel specific registers to
>    avoid the regmap locking
>  - implement suspend/resume
> 
> 
> Alexandre Belloni (6):
>   ARM: at91: add TCB registers definitions
>   clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
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
>  drivers/clocksource/timer-atmel-tcb.c | 608 ++++++++++++++++++++++++++++++++++
>  include/soc/at91/atmel_tcb.h          | 216 ++++++++++++
>  7 files changed, 865 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clocksource/timer-atmel-tcb.c
>  create mode 100644 include/soc/at91/atmel_tcb.h
> 
> -- 
> 2.16.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
