From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 19 Jun 2017 14:35:33 +0300
Subject: [PATCH v5 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
In-Reply-To: <20170619050245.2632-3-o.rempel@pengutronix.de>
References: <20170619050245.2632-1-o.rempel@pengutronix.de>
 <20170619050245.2632-3-o.rempel@pengutronix.de>
Message-ID: <1497872133.5380.11.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-19 at 07:02 +0200, Oleksij Rempel wrote:
> One of the Freescale recommended sequences for power off with
> external
> PMIC is the following:
> ...
> 3.??SoC is programming PMIC for power off when standby is asserted.
> 4.??In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> 
> See:
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww
> .nxp.com%2Fassets%2Fdocuments%2Fdata%2Fen%2Freference-
> manuals%2FIMX6DQRM.pdf&data=01%7C01%7Cleonard.crestez%40nxp.com%7C32c
> df19d0ab44ed8e24d08d4b6d097f4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&
> sdata=CWDpnEGikPGmSTM3dQH8IMxQCVzcIvHL69nu962d8M0%3D&reserved=0
> page 5083
> 
> This patch implements step 4. of this sequence.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> ?arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
> ?1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-
> imx6.c
> index e61b1d1027e1..cb76832935f0 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -602,6 +602,28 @@ static void __init imx6_pm_common_init(const
> struct imx6_pm_socdata
> ?				???IMX6Q_GPR1_GINT);
> ?}
> ?
> +static void imx6_pm_poweroff(void)
> +{
> +	imx6_set_lpm(STOP_POWER_OFF);
> +	cpu_suspend(0, imx6q_suspend_finish);

It's a bit strange that you're using parts of the suspend code for
this. Perhaps you could just write your bits to CLPCR and then execute
a WFI?

It would also be nice to rename this to something like
imx6_pm_stby_poweroff to make it clear that it's only for a certain
power off path.
