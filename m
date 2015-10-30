From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Fri, 30 Oct 2015 13:00:11 -0400
Subject: [PATCH v3 0/2] imx6: Implement external watchdog reset
In-Reply-To: <1438097230-2653-1-git-send-email-tharvey@gateworks.com>
References: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
 <1438097230-2653-1-git-send-email-tharvey@gateworks.com>
Message-ID: <5633A21B.2040300@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/28/2015 11:27 AM, Tim Harvey wrote:
> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltate for
> the CPU when comming out of reset at 800Mhz when it was at 400Mhz prior to
> reset.
>
> This adds a new device-tree property 'ext-reset-output' to fsl-imx-wdt in
> order to indicate the board has such a reset and to cause the watchdog to be
> configured to assert WDOG_B instead of an internal reset both on a
> watchdog timeout and in system_restart.
>

Hi, was there a reason why this patch did not make it to the upstream 
kernel? We would like to use this feature on a Advantech/GE board and I 
can rebase the first patch onto the latest linux-next, resubmit if needed.

Thanks, Akshay

> The second patch adds the watchdog configuration and pinmux for Gateworks
> Ventana boards.
>
> I would expect that maintainers of other IMX6 boards that use PMIC's that
> are resettable via WDOG_B to follow-up with similar device-tree patches.
> I've attempted to Cc those individuals here.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Iain Paton <ipaton0@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>
> Tim Harvey (2):
>    watchdog: imx2_wdt: add external reset support via 'ext-reset-output'
>      dt prop
>    ARM: dts: ventana: Add ext-reset support
>
>   .../devicetree/bindings/watchdog/fsl-imx-wdt.txt     |  2 ++
>   arch/arm/boot/dts/imx6qdl-gw51xx.dtsi                | 12 ++++++++++++
>   arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                | 12 ++++++++++++
>   arch/arm/boot/dts/imx6qdl-gw53xx.dtsi                | 13 +++++++++++++
>   arch/arm/boot/dts/imx6qdl-gw54xx.dtsi                | 17 +++++++++++++++++
>   arch/arm/boot/dts/imx6qdl-gw551x.dtsi                | 12 ++++++++++++
>   arch/arm/boot/dts/imx6qdl-gw552x.dtsi                | 12 ++++++++++++
>   drivers/watchdog/imx2_wdt.c                          | 20 ++++++++++++++++++--
>   8 files changed, 98 insertions(+), 2 deletions(-)
>
