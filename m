From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 25 Jun 2012 10:33:10 +0200
Subject: [PATCH v3 0/7] ARM: at91: add sparse irq support and introduce
 aic5
In-Reply-To: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
References: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4FE82246.4050506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2012 06:05 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> This set of patches introduces AIC5 support with the goal to have only one
> kernel image for all SOCs. That's why sparse irq support was added.
> AIC5 can manage up to 128 irq lines. It introduces a new register map and
> a source select register to select the IRQ line we want to configure.

Thanks for this nice series.

I will queue it up in a at91-3.6-cleanup branch soon.

Bye,

> v3 changes:
> - of irq priorities support patch reworked: add a cell for priority value.
> - sparse irq support patch reworked: no more using nr_irqs, so have to shift
> static irq number by NR_IRQS_LEGACY.
> 
> v2 changes:
> - add Jean-Christophe patches since my patches are based on abd there have
> not been submitted yet
> - I missed some machine descriptors in the first version, it
> is corrected with this new one.
> - correct sparse irq support and remove mach/irqs.h.
> - correct issue on AIC5 support (missing allocation).
> 
> Jean-Christophe PLAGNIOL-VILLARD (1):
>   ARM: at91: aic add dt support for external irqs
> 
> Ludovic Desroches (6):
>   ARM: at91: add of irq priorities support
>   ARM: at91: remove static irq priorities for sam9x5
>   ARM: at91: at91 based machines specify their own irq handler at run
>     time
>   ARM: at91: sparse irq support
>   ARM: at91: remove mach/irqs.h
>   ARM: at91: add AIC5 support
> 
>  .../devicetree/bindings/arm/atmel-aic.txt          |    9 +-
>  arch/arm/boot/dts/at91sam9260.dtsi                 |   37 +-
>  arch/arm/boot/dts/at91sam9263.dtsi                 |   31 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   39 +-
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |   30 +-
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |   39 +-
>  arch/arm/mach-at91/Kconfig                         |    2 +
>  arch/arm/mach-at91/at91rm9200.c                    |    1 +
>  arch/arm/mach-at91/at91rm9200_devices.c            |   84 ++--
>  arch/arm/mach-at91/at91sam9260.c                   |    1 +
>  arch/arm/mach-at91/at91sam9260_devices.c           |   92 +++---
>  arch/arm/mach-at91/at91sam9261.c                   |    1 +
>  arch/arm/mach-at91/at91sam9261_devices.c           |   68 ++--
>  arch/arm/mach-at91/at91sam9263.c                   |    1 +
>  arch/arm/mach-at91/at91sam9263_devices.c           |   80 ++--
>  arch/arm/mach-at91/at91sam926x_time.c              |    2 +-
>  arch/arm/mach-at91/at91sam9g45.c                   |    1 +
>  arch/arm/mach-at91/at91sam9g45_devices.c           |  108 +++---
>  arch/arm/mach-at91/at91sam9rl.c                    |    1 +
>  arch/arm/mach-at91/at91sam9rl_devices.c            |   76 ++--
>  arch/arm/mach-at91/at91sam9x5.c                    |   40 --
>  arch/arm/mach-at91/at91x40.c                       |    1 +
>  arch/arm/mach-at91/board-1arm.c                    |    2 +
>  arch/arm/mach-at91/board-afeb-9260v1.c             |    2 +
>  arch/arm/mach-at91/board-cam60.c                   |    2 +
>  arch/arm/mach-at91/board-carmeva.c                 |    2 +
>  arch/arm/mach-at91/board-cpu9krea.c                |    2 +
>  arch/arm/mach-at91/board-cpuat91.c                 |    2 +
>  arch/arm/mach-at91/board-csb337.c                  |    2 +
>  arch/arm/mach-at91/board-csb637.c                  |    2 +
>  arch/arm/mach-at91/board-dt.c                      |    2 +
>  arch/arm/mach-at91/board-eb01.c                    |    2 +
>  arch/arm/mach-at91/board-eb9200.c                  |    2 +
>  arch/arm/mach-at91/board-ecbat91.c                 |    2 +
>  arch/arm/mach-at91/board-eco920.c                  |    2 +
>  arch/arm/mach-at91/board-flexibity.c               |    2 +
>  arch/arm/mach-at91/board-foxg20.c                  |    2 +
>  arch/arm/mach-at91/board-gsia18s.c                 |    2 +
>  arch/arm/mach-at91/board-kafa.c                    |    2 +
>  arch/arm/mach-at91/board-kb9202.c                  |    2 +
>  arch/arm/mach-at91/board-neocore926.c              |    2 +
>  arch/arm/mach-at91/board-pcontrol-g20.c            |    2 +
>  arch/arm/mach-at91/board-picotux200.c              |    2 +
>  arch/arm/mach-at91/board-qil-a9260.c               |    2 +
>  arch/arm/mach-at91/board-rm9200dk.c                |    2 +
>  arch/arm/mach-at91/board-rm9200ek.c                |    2 +
>  arch/arm/mach-at91/board-rsi-ews.c                 |    2 +
>  arch/arm/mach-at91/board-sam9-l9260.c              |    2 +
>  arch/arm/mach-at91/board-sam9260ek.c               |    2 +
>  arch/arm/mach-at91/board-sam9261ek.c               |    2 +
>  arch/arm/mach-at91/board-sam9263ek.c               |    2 +
>  arch/arm/mach-at91/board-sam9g20ek.c               |    3 +
>  arch/arm/mach-at91/board-sam9m10g45ek.c            |    2 +
>  arch/arm/mach-at91/board-sam9rlek.c                |    2 +
>  arch/arm/mach-at91/board-snapper9260.c             |    2 +
>  arch/arm/mach-at91/board-stamp9g20.c               |    3 +
>  arch/arm/mach-at91/board-usb-a926x.c               |    4 +
>  arch/arm/mach-at91/board-yl-9200.c                 |    2 +
>  arch/arm/mach-at91/generic.h                       |    2 +
>  arch/arm/mach-at91/include/mach/at91_aic.h         |   34 ++
>  arch/arm/mach-at91/include/mach/entry-macro.S      |   27 --
>  arch/arm/mach-at91/include/mach/irqs.h             |   41 --
>  arch/arm/mach-at91/irq.c                           |  400 +++++++++++++++++---
>  arch/arm/mach-at91/pm.c                            |    1 +
>  64 files changed, 818 insertions(+), 507 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/entry-macro.S
>  delete mode 100644 arch/arm/mach-at91/include/mach/irqs.h
> 


-- 
Nicolas Ferre
