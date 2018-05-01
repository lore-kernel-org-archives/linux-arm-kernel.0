From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 1 May 2018 10:06:20 +0200
Subject: [PATCH 00/12] clk: imx: add imx8qxp clock support
In-Reply-To: <61f81e36a71f5c02f77163c8f32e1e5b@agner.ch>
References: <1524855403-15301-1-git-send-email-aisheng.dong@nxp.com>
 <20180501060330.l5j6rztqal2whgge@pengutronix.de>
 <61f81e36a71f5c02f77163c8f32e1e5b@agner.ch>
Message-ID: <20180501080620.vid3i5dqni4ld6uk@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 09:32:11AM +0200, Stefan Agner wrote:
> On 01.05.2018 08:03, Oleksij Rempel wrote:
> > Hi,
> > 
> > same functionality is actually needed on iMX7d and many other non NXP
> > socs.
> 
> How is this needed on iMX7D?
> 
> Afaik, on i.MX8QXP Linux does not have any direct access to the clock
> registers. It is all managed by SCU. However, on i.MX 7 Linux as is
> today accesses the clocks registers directly...

iMX7D and iMX6SX provide access to same register set from Cortex A and
Cortex M side. Since it is just dangerous to toggle same bits from two
systems, only one should control it. After implementing imx_rproc
driver and bringing up system on Cortex M4 side, we faced a problem of
needing to properly control clocks and pins for other side. Clocks and
pins should be configured only if some functionality is requested, so we
can't just force defaults which will always work.
I assume that only right solution for this problem is to introduce some
generic clock-to-rpmsg, pinmux-to-rpmsg bridge. So far I know, many
system vendors have same problem with different SoCs (Renesas, TI, ST, QCOM) and
I assume it is a generic AMP issue. If each vendor will upstream firmware
specific kernel side implementation to solve common problem, we will have
tons on unmaintainable SoC/Firmware specific code.

> > IMO proper solution is to introduce generic clock proxy or some thing
> > like this on top of rpmsg/virtio 
> 
> Given that NXP already used rpmsg in the past, I was wondering too why a
> new messaging mechanism had to be invented.
> 
> Dong, do you know why?
> 
> --
> Stefan
> 
> > 
> > On Sat, Apr 28, 2018 at 02:56:31AM +0800, Dong Aisheng wrote:
> >> This patch series adds i.MX8QXP clock support which is based
> >> on the clock service provided by SCU firmware.
> >> It depends on SCU APIs patch set.
> >>
> >> Dong Aisheng (12):
> >>   clk: imx: add configuration option for mmio clks
> >>   clk: imx: scu: add scu clock common part
> >>   clk: imx: scu: add scu clock divider
> >>   clk: imx: scu: add scu clock gpr divider
> >>   clk: imx: scu: add scu clock gate
> >>   clk: imx: scu: add scu clock gpr gate
> >>   clk: imx: scu: add scu clock mux
> >>   clk: imx: scu: add scu clock gpr mux
> >>   clk: imx: add common imx_clk_hw_fixed functions
> >>   clk: imx: add imx_check_clk_hws helper function
> >>   dt-bindings: clock: add imx8qxp clock binding doc
> >>   clk: imx: add imx8qxp clk driver
> >>
> >>  .../devicetree/bindings/clock/imx8qxp-clk.txt      |  39 ++
> >>  arch/arm/mach-imx/Kconfig                          |  10 +
> >>  drivers/clk/Kconfig                                |   1 +
> >>  drivers/clk/imx/Kconfig                            |   7 +
> >>  drivers/clk/imx/Makefile                           |   4 +-
> >>  drivers/clk/imx/clk-common.h                       |  27 ++
> >>  drivers/clk/imx/scu/Kconfig                        |   5 +
> >>  drivers/clk/imx/scu/Makefile                       |  12 +
> >>  drivers/clk/imx/scu/clk-divider-gpr-scu.c          | 131 +++++++
> >>  drivers/clk/imx/scu/clk-divider-scu.c              | 129 +++++++
> >>  drivers/clk/imx/scu/clk-gate-gpr-scu.c             |  84 ++++
> >>  drivers/clk/imx/scu/clk-gate-scu.c                 | 193 ++++++++++
> >>  drivers/clk/imx/scu/clk-imx8qxp.c                  | 426 +++++++++++++++++++++
> >>  drivers/clk/imx/scu/clk-mux-gpr-scu.c              |  90 +++++
> >>  drivers/clk/imx/scu/clk-mux-scu.c                  |  89 +++++
> >>  drivers/clk/imx/scu/clk-scu.c                      |  25 ++
> >>  drivers/clk/imx/scu/clk-scu.h                      |  97 +++++
> >>  include/dt-bindings/clock/imx8qxp-clock.h          | 362 +++++++++++++++++
> >>  include/soc/imx/imx8qxp/lpcg.h                     | 186 +++++++++
> >>  19 files changed, 1916 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-clk.txt
> >>  create mode 100644 drivers/clk/imx/Kconfig
> >>  create mode 100644 drivers/clk/imx/clk-common.h
> >>  create mode 100644 drivers/clk/imx/scu/Kconfig
> >>  create mode 100644 drivers/clk/imx/scu/Makefile
> >>  create mode 100644 drivers/clk/imx/scu/clk-divider-gpr-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-divider-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-gate-gpr-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-gate-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-imx8qxp.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-mux-gpr-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-mux-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-scu.c
> >>  create mode 100644 drivers/clk/imx/scu/clk-scu.h
> >>  create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
> >>  create mode 100644 include/soc/imx/imx8qxp/lpcg.h
> >>
> >> --
> >> 2.7.4
> >>
> >>
> >>
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180501/5ea31b9b/attachment.sig>
