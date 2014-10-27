From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 27 Oct 2014 01:27:15 +0100
Subject: [PATCH] ARM: dts: rockchip: use internal pull-up resistors on I2C
 busses
In-Reply-To: <1413556830-27854-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1413556830-27854-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <8843018.dv9ckEkBvo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Am Freitag, 17. Oktober 2014, 16:40:30 schrieb Julien CHAUVEAU:
> According to the I2C bus specification, it is required to use pull-up
> resistors on the clock and data lines. Probing the I2C busses with
> i2cdetect results in bad results when no devices are connected and no
> external resistors are used.
> 
> This patch configures the I2C busses to use the internal pull-up resistors
> on the RK3066, RK3188 and RK3288 Rockchip processors. It should also be
> noted that these default pull settings match the original configuration on
> these SoCs.
> 
> Below is the results of using i2cdetect on a I2C bus with no devices
> connected before (1) and after (2) applying this patch.
> 
> (1) root at localhost:~# i2cdetect 3
> 
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-3.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: -- -- -- -- -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x81, state: 2
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 2
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 2
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
> ...
> 
> (2) root at localhost:~# i2cdetect 3
> 
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-3.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 20 ++++++++++----------
>  arch/arm/boot/dts/rk3188.dtsi  | 20 ++++++++++----------
>  arch/arm/boot/dts/rk3288.dtsi  | 24 ++++++++++++------------
>  3 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index ad9c2db..c5cdf55 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -202,36 +202,36 @@
> 
>  		i2c0 {
>  			i2c0_xfer: i2c0-xfer {
> -				rockchip,pins = <RK_GPIO2 28 RK_FUNC_1 &pcfg_pull_none>,
> -						<RK_GPIO2 29 RK_FUNC_1 &pcfg_pull_none>;
> +				rockchip,pins = <RK_GPIO2 28 RK_FUNC_1 &pcfg_pull_up>,
> +						<RK_GPIO2 29 RK_FUNC_1 &pcfg_pull_up>;

The rk3066a does not support distinguishing between up and down pulls. On it 
only &pcfg_pull_default is possible that configures the pull to a pin-specific 
pull direction. For the i2c pins the direction is (of course) "up".



Heiko
