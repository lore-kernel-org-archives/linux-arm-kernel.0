From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Fri, 5 Aug 2016 15:48:19 +0200
Subject: [PATCH v4 0/7] rk3399 support ddr frequency scaling
In-Reply-To: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
Message-ID: <CAAObsKBpWUP0rd2TgGE7y-foQFwHq0+2jEZzkS_Ks3SSTJiazg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2016 at 09:56, Lin Huang <hl@rock-chips.com> wrote:
> rk3399 platform have dfi controller can monitor ddr load,
> and dcf controller to handle ddr register so we can get the
> right ddr frequency and make ddr controller happy work(which
> will implement in bl31). So we do ddr frequency scaling with
> following flow:
>
>              kernel                                bl31
>
>         monitor ddr load
>                 |
>                 |
>         get_target_rate
>                 |
>                 |           pass rate to bl31
>         clk_set_rate(ddr) --------------------->run dcf flow
>                 |                                   |
>                 |                                   |
>         wait dcf interrupt<-------------------trigger dcf interrupt
>                 |
>                 |
>               return

Hi Lin,

can you confirm that the hardware isn't capable of raising interrupts
when programmable load thresholds are trespassed? From reading the
TRM, looks like it should be possible.

Or is there any reason to merge now a driver that polls for load stats?

Thanks,

Tomeu

> Lin Huang (6):
>   clk: rockchip: add new clock-type for the ddrclk
>   clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
>   clk: rockchip: rk3399: add ddrc clock support
>   PM / devfreq: event: support rockchip dfi controller
>   PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
>   drm/rockchip: Add dmc notifier in vop driver
>
>
> Heiko St?bner (1):
>   clk: rockchip: add clock flag parameter when register pll
>
> Lin Huang (6):
>   clk: rockchip: add new clock-type for the ddrclk
>   clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
>   clk: rockchip: rk3399: add ddrc clock support
>   PM / devfreq: event: support rockchip dfi controller
>   PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
>   drm/rockchip: Add dmc notifier in vop driver
>
>  drivers/clk/rockchip/Makefile               |   1 +
>  drivers/clk/rockchip/clk-ddr.c              | 146 +++++++++
>  drivers/clk/rockchip/clk-pll.c              |   4 +-
>  drivers/clk/rockchip/clk-rk3399.c           |  19 ++
>  drivers/clk/rockchip/clk.c                  |  11 +-
>  drivers/clk/rockchip/clk.h                  |  29 +-
>  drivers/devfreq/Kconfig                     |   1 +
>  drivers/devfreq/Makefile                    |   1 +
>  drivers/devfreq/event/Kconfig               |   7 +
>  drivers/devfreq/event/Makefile              |   1 +
>  drivers/devfreq/event/rockchip-dfi.c        | 253 +++++++++++++++
>  drivers/devfreq/rockchip/Kconfig            |   8 +
>  drivers/devfreq/rockchip/Makefile           |   1 +
>  drivers/devfreq/rockchip/rk3399_dmc.c       | 473 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 124 +++++++-
>  include/dt-bindings/clock/rk3399-cru.h      |   1 +
>  include/soc/rockchip/rockchip_sip.h         |  27 ++
>  17 files changed, 1098 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/clk/rockchip/clk-ddr.c
>  create mode 100644 drivers/devfreq/event/rockchip-dfi.c
>  create mode 100644 drivers/devfreq/rockchip/Kconfig
>  create mode 100644 drivers/devfreq/rockchip/Makefile
>  create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
>  create mode 100644 include/soc/rockchip/rockchip_sip.h
>
> --
> 1.9.1
>
