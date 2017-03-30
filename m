From: ore@pengutronix.de (Oleksij Rempel)
Date: Thu, 30 Mar 2017 13:02:54 +0200
Subject: proper power off implementation for iMX6 with external pmic
Message-ID: <d8d013f7-9417-c7c9-5f60-dd33465e9b42@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo all,

i'm looking for proper way to implement pm_power_off for IMX6 with 
external PMIC.

http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
page 5083

According to this documentation, there are two ways to power off, 
depending on board configuration. With internal and external PMIC.

Internal variant is implemented in:
drivers/power/reset/imx-snvs-poweroff.c

and should provide support for fallowing sequence:

Configuration with internal PMIC:
1.  SoC button is pressed for a short duration.
2.  Interrupt request (irq) is sent to SoC from FSM
3.  Alarm timer is set up by software routine and started.
4.  Upon alarm_in assertion to '1', PMIC_ON_REQ goes '0'.
5.  External regulator goes OFF.

Suddenly i can't find any existing code for external PMIC.

Configuration with external PMIC:
1.  Button is pressed for a short duration on the external PMIC.
2.  Interrupt request (irq) is sent to SoC from external PMIC
3.  SoC is programming PMIC for power off when standby is asserted.
4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.

partially needed  code is implemented here:
  arch/arm/mach-imx/pm-imx6.c
...
         case STOP_POWER_OFF:
                 val |= 0x2 << BP_CLPCR_LPM;
                 val |= 0x3 << BP_CLPCR_STBY_COUNT;
                 val |= BM_CLPCR_VSTBY;
                 val |= BM_CLPCR_SBYOS;
....
but used only for PM_SUSPEND_MEM and never for pm_power_off.

do i miss some thing, or are there any patches floating around?
If it is not implemented jet and no one is working on this i would do it.
I assume it should be configurable over device tree. Correct?
