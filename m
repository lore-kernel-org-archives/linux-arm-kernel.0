From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 13 Mar 2014 01:36:43 +0100
Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART inputs
In-Reply-To: <6599423.XddAUl3dCe@typ>
References: <6599423.XddAUl3dCe@typ>
Message-ID: <3174671.zfR1X00SEg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Max,


Am Sonntag, 9. M?rz 2014, 20:43:11 schrieb Max Schwarz:
> Enable integrated pull-ups on the UART RX pins of Rockchip RK3188.
> 
> This fixes UART receive on the radxa Rock board, which has an input diode
> preventing the RX pin from being raised from the outside.
>
> Signed-off-by: Max Schwarz <max.schwarz@online.de>

Your patch changes the default behaviour for all rk3188 uarts, while the patch 
description suggests a Radxa Rock specific problem.
On my preproduction Radxa Rock the issue is not present, but I think I 
remember reading somewhere, that the diodes where added in the mass-production 
model.

So I've dug a bit through different sources:

- the schematics of another rk3188 based device, did not use diodes for the 
uarts like the Radxa, but

- the default values for pull configuration supports your observation:
	gpio1-0: pull-up
	gpio1-1: pull down [currently also none]
	gpio1-4: pull up
	gpio1-5: pull-down
		and so on for the two other pin-groups.

- and rockchip vendor kernels do not seem to change the uart pull configs

I've tested both your patch + enabling the pull down for the txd pin too. Both 
variants work on my radxa.

So I agree with you but would like to determine if we should also set the txd 
to pull down in one go, to restore the default pull setting of these pins or 
should leave them as is.
Thoughts?


Heiko


> ---
>  arch/arm/boot/dts/rk3188.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index 412f4d0..2e10bd7 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -149,7 +149,7 @@
> 
>  			uart0 {
>  				uart0_xfer: uart0-xfer {
> -					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 
&pcfg_pull_none>,
> +					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_up>,
>  							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_none>;
>  				};
> 
> @@ -164,7 +164,7 @@
> 
>  			uart1 {
>  				uart1_xfer: uart1-xfer {
> -					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 
&pcfg_pull_none>,
> +					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_up>,
>  							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_none>;
>  				};
> 
> @@ -179,7 +179,7 @@
> 
>  			uart2 {
>  				uart2_xfer: uart2-xfer {
> -					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 
&pcfg_pull_none>,
> +					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_up>,
>  							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_none>;
>  				};
>  				/* no rts / cts for uart2 */
> @@ -187,7 +187,7 @@
> 
>  			uart3 {
>  				uart3_xfer: uart3-xfer {
> -					rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 
&pcfg_pull_none>,
> +					rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 &pcfg_pull_up>,
>  							<RK_GPIO1 11 RK_FUNC_1 &pcfg_pull_none>;
>  				};
