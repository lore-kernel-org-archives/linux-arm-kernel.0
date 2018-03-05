From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon,  5 Mar 2018 11:25:17 +0100
Subject: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
Message-ID: <20180305102524.5905-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is providing power off support for Freescale/NXP iMX6 based
boards with external power management integrated circuit (PMIC).
As a first step the PMIC is configured to turn off the system if the
standby pin is asserted. On second step we assert the standby pin.
For this reason we need to use pm_power_off_prepare.

Usage of stnadby pin for power off is described in official iMX6
documentation.

2018.03.05:
As this patch set touches multiple subsystems I think it would make
sense for Shawn Guo to take the all patch set.
The only part which didn't receive an ACK is regulator stuff. So I would
hope that Mark Brown can ACK it.

Kind regards,
Oleksij Rempel

2017.12.06:
Adding Linus. Probably there is no maintainer for this patch set.
No changes are made, tested on v4.15-rc1.

2017.10.27:
Last version of this patch set was send at 20 Jun 2017, this is a rebase against
kernel v4.14-rc6. Probably this set got lost. If I forgot to address some comments,
please point me.

changes:
v6:
 - rename imx6_pm_poweroff to imx6_pm_stby_poweroff
 - fix "MPIC_STBY_REQ" typo in the comment.

v5:
 - remove useless includes from pm-imx6.c patch
 - add Acked-by to "regulator: pfuze100: add fsl,pmic-stby-poweroff property"
   patch

v4:
 - update comment in "regulator: pfuze100: add fsl,pmic-stby-poweroff ..."
   patch
 - add Acked-by to "ARM: imx6q: provide documentation for new ..."
   patch

v3:
 - set pm_power_off_prepare = NULL on .remove.
 - documentation and spelling fixes.
 - use %pf instead of lookup_symbol_name.


Oleksij Rempel (6):
  ARM: imx6q: provide documentation for new fsl,pmic-stby-poweroff
    property
  ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff"
    is set
  kernel/reboot.c: export pm_power_off_prepare
  regulator: pfuze100: add fsl,pmic-stby-poweroff property
  regulator: pfuze100-regulator: provide pm_power_off_prepare handler
  ARM: dts: imx6: RIoTboard provide standby on power off option

 .../devicetree/bindings/clock/imx6q-clock.txt      |  8 ++
 .../devicetree/bindings/regulator/pfuze100.txt     |  7 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  5 ++
 arch/arm/mach-imx/pm-imx6.c                        | 25 ++++++
 drivers/regulator/pfuze100-regulator.c             | 92 ++++++++++++++++++++++
 kernel/reboot.c                                    |  1 +
 6 files changed, 138 insertions(+)

-- 
2.16.1
