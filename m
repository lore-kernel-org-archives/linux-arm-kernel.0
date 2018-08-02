From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu,  2 Aug 2018 09:23:21 +0200
Subject: [PATCH v9 0/4] add mailbox support for i.MX7D
Message-ID: <20180802072325.22991-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

20180802 changes v9:
- DT: remove notes about shmem
- imx-mailbox: reword changelog 
- imx-mailbox: use tasklet instead of workqueue
- imx-mailbox: remove imx_mu_last_tx_done
- imx-mailbox: move irq_desc to probe
- imx-mailbox: change (const == var) to (var == const)

20180731 changes v8:
- imx-mailbox & DT: rework driver from 4 channel bidirectional mode to
  16 channel unidirectional mode. 8 extra channels are implemented on
  top of General Purpose Interrupt bits provided by this MU.

20180726 changes v7:
- DT: add i.MX6SX and i.MX7S to the documentation.
- imx-mailbox: don't use devm_ functions for startup and shutdown.
- imx-mailbox: rename imx_mu_rmw to imx_mu_xcr_rmw and add locks
- imx-mailbox: pass of_property_read_bool directly to side_b

20180722 changes v6:
- include one more patch provided by Aisheng
- DT: add fall back compatible fsl,imx6sx-mu
- imx-mailbox: for now, use only fsl,imx6sx-mu

20180721 changes v5:
- DT: revert most of the changes from previous version
- imx-mailbox: remove struct imx_mu_cfg
- imx-mailbox: remove !! from imx_mu_last_tx_done()

20180718 changes v4:
- DT: change fsl,mu-side-a to fsl,mu-side-b
- DT: split the patches.
- DT: add all currently known SoCs.
- imx-mailbox: free allocated irq name on channel shutdown
- imx-mailbox: rename *_imx7 functions to *_generic

20180715 changes v3:
- DT: remove prosaic part of documentation. It describes software
  or firmware specific usage and not relevant for HW description.
- DT: use <soc>-mu instead of <soc>-mu-<mu side> and add fsl,mu-side-a
  parameter.
- DT: add most of know i.MX variants with MU
- imx-mailbox: use macros instead of precalculated bit index.
- imx-mailbox: remove warning message for clk.
- imx-mailbox: use imx_mu_chan[%idx] for devm_request_irq.
- imx-mailbox: depend on ARCH_MXC instead of SOX_IMX7

20180615 changes v2:
- DT: use mailbox@ instead of mu@
- DT: change interrupts description
- clk: use imx_clk_gate4 instead of imx_clk_gate2
- imx-mailbox: remove last_tx_done support
- imx-mailbox: fix module description 

This patches are providing support for mailbox (Messaging Unit)
for i.MX7D.
Functionality was tested on PHYTEC phyBOARD-Zeta i.MX7D with
Linux running on all cores: ARM Cortex-A7 and ARM Cortex-M4.

Both parts of i.MX messaging Unit are visible for all CPUs available
on i.MX7D. Communication worked independent of MU side in combination
with CPU. For example MU-A used on ARM Cortex-A7 and MU-B used on ARM Cortex-M4
or other ways around.

Dong Aisheng (1):
  dt-bindings: arm: fsl: add mu binding doc

Oleksij Rempel (3):
  dt-bindings: mailbox: imx-mu: add generic MU channel support
  ARM: dts: imx7s: add i.MX7 messaging unit support
  mailbox: Add support for i.MX messaging unit

 .../devicetree/bindings/mailbox/fsl,mu.txt    |  54 +++
 arch/arm/boot/dts/imx7s.dtsi                  |  19 +
 drivers/mailbox/Kconfig                       |   6 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/imx-mailbox.c                 | 357 ++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 drivers/mailbox/imx-mailbox.c

-- 
2.18.0
