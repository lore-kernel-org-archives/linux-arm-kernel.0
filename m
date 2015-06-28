From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 Jun 2015 23:07:42 +0800
Subject: [PATCH v2 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
In-Reply-To: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
Message-ID: <20150628150742.GF10332@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 01:15:59PM -0700, Tim Harvey wrote:
> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltage for
> the CPU when coming out of reset at 800Mhz.
> 
> This uses a new device-tree property 'ext-reset-output' to indicate the
> board has such a reset and to cause the watchdog to be configured to assert
> WDOG_B instead of an internal reset both on a watchdog timeout and in
> system_restart.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2:
>  - rename property to 'ext-reset-output' based on ML feedback
>  - simplify setting SRS bit if external-reset
>  - update comments and commit msg
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.txt        |  2 ++
>  drivers/watchdog/imx2_wdt.c                             | 17 +++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> index 8dab6fd..9b89b3a 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> @@ -9,6 +9,8 @@ Optional property:
>  - big-endian: If present the watchdog device's registers are implemented
>    in big endian mode, otherwise in native mode(same with CPU), for more
>    detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
> +- ext-reset-output: If present the watchdog device is configured to assert its
> +  external reset (WDOG_B) instead of issuing a software reset.

This is a vendor specific binding property rather than generic one, so
it should have a vendor prefix, i.e. "fsl,".  Other than that,

Acked-by: Shawn Guo <shawn.guo@linaro.org>
