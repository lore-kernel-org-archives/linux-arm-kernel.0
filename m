From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:17:29 +0200
Subject: [PATCH 00/16] ARM: at91: PMC driver rework
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150930161729.GD3639@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen, all,

Please disregard 01/16 and 02/16 as they are already in clk-next.

On 30/09/2015 at 18:10:53 +0200, Alexandre Belloni wrote :
> Hi,
> 
> This patch set is a cleanup that properly separate drivers needing to access the
> PMC (PM and USB) from the clock driver by exposing the PMC as a syscon.
> 
> This also allows to implement a fix for preempt-rt. Currently, at91 platform are
> crashing when using preempt-rt because the irq handler are transformed in
> threaded irq handler but at the time the pmc registers its clocks, it is not
> possible to creat threads, leading to a NULL pointer dereference in the kernel.
> 
> The new infrastructure uses polling until it is late enough to register threaded
> irqs.
> 
> :w
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> 
> Alexandre Belloni (13):
>   clk: at91: utmi: use pmc_read when the at91_pmc is available
>   clk: at91: system: don't try to free_irq when there is no IRQ
>   ARM: at91/dt: use syscon for PMC
>   clk: at91: clk-main: factorize irq handling
>   clk: at91: make IRQ optional and register them later
>   clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe
>   clk: at91: pmc: move pmc structures to C file
>   ARM: at91: pm: simply call at91_pm_init
>   ARM: at91: pm: find and remap the pmc
>   ARM: at91: pm: move idle functions to pm.c
>   ARM: at91: remove useless includes and function prototypes
>   usb: gadget: atmel: access the PMC using regmap
>   clk: at91: pmc: drop at91_pmc_base
> 
> Boris Brezillon (3):
>   clk: at91: make use of syscon to share PMC registers in several
>     drivers
>   clk: at91: make use of syscon/regmap internally
>   clk: at91: only enable available IRQs
> 
>  arch/arm/boot/dts/at91rm9200.dtsi       |   2 +-
>  arch/arm/boot/dts/at91sam9260.dtsi      |   2 +-
>  arch/arm/boot/dts/at91sam9261.dtsi      |   2 +-
>  arch/arm/boot/dts/at91sam9263.dtsi      |   2 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi      |   2 +-
>  arch/arm/boot/dts/at91sam9n12.dtsi      |   2 +-
>  arch/arm/boot/dts/at91sam9rl.dtsi       |   2 +-
>  arch/arm/boot/dts/at91sam9x5.dtsi       |   2 +-
>  arch/arm/boot/dts/sama5d2.dtsi          |   2 +-
>  arch/arm/boot/dts/sama5d3.dtsi          |   2 +-
>  arch/arm/boot/dts/sama5d4.dtsi          |   2 +-
>  arch/arm/mach-at91/Kconfig              |   1 +
>  arch/arm/mach-at91/at91rm9200.c         |   2 -
>  arch/arm/mach-at91/at91sam9.c           |   2 -
>  arch/arm/mach-at91/generic.h            |  13 +-
>  arch/arm/mach-at91/pm.c                 |  69 +++++-
>  arch/arm/mach-at91/sama5.c              |   2 +-
>  drivers/clk/at91/clk-h32mx.c            |  33 ++-
>  drivers/clk/at91/clk-main.c             | 403 +++++++++++++++++++-------------
>  drivers/clk/at91/clk-master.c           | 134 +++++++----
>  drivers/clk/at91/clk-peripheral.c       | 131 +++++++----
>  drivers/clk/at91/clk-pll.c              | 190 +++++++++------
>  drivers/clk/at91/clk-plldiv.c           |  42 ++--
>  drivers/clk/at91/clk-programmable.c     |  92 ++++----
>  drivers/clk/at91/clk-slow.c             |  27 ++-
>  drivers/clk/at91/clk-smd.c              |  54 +++--
>  drivers/clk/at91/clk-system.c           | 128 ++++++----
>  drivers/clk/at91/clk-usb.c              | 121 +++++-----
>  drivers/clk/at91/clk-utmi.c             | 116 +++++----
>  drivers/clk/at91/pmc.c                  | 300 ++++++------------------
>  drivers/clk/at91/pmc.h                  |  93 +-------
>  drivers/usb/gadget/udc/atmel_usba_udc.c |  20 +-
>  drivers/usb/gadget/udc/atmel_usba_udc.h |   2 +
>  include/linux/clk/at91_pmc.h            |  12 -
>  34 files changed, 1059 insertions(+), 950 deletions(-)
> 
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
