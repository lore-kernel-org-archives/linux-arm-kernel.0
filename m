From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 12:34:45 -0500
Subject: [PATCH] i2c: designware-platdrv: implement bus recovery
In-Reply-To: <1460642696-1858-1-git-send-email-jszhang@marvell.com>
References: <1460642696-1858-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160414173445.GA21450@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 10:04:56PM +0800, Jisheng Zhang wrote:
> Implement bus recovery methods for i2c designware so we can recover
> from situations where SCL/SDA are stuck low.
> 
> The recovery method is similar as i2c-imx: "config the i2c pinctrl to
> gpio mode by calling pinctrl sleep set function, and then use GPIO to
> emulate the i2c protocol to send nine dummy clock to recover i2c
> device. After recovery, set i2c pinctrl to default group setting.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> depends on runtime pm patches
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422202.html
>  .../devicetree/bindings/i2c/i2c-designware.txt     | 12 ++++++
>  drivers/i2c/busses/i2c-designware-core.c           |  6 ++-
>  drivers/i2c/busses/i2c-designware-core.h           |  4 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c        | 50 ++++++++++++++++++++++
>  4 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc..51a55c6 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,13 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
>  
> + - scl-gpios: specify the gpio related to SCL pin
> +
> + - sda-gpios: specify the gpio related to SDA pin
> +
> + - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
> +   bus recovery, call it "gpio" state
> +

Make these common properties in i2c.txt (and a separate patch).

>  Example :
>  
>  	i2c at f0000 {
> @@ -42,4 +49,9 @@ Example :
>  		i2c-sda-hold-time-ns = <300>;
>  		i2c-sda-falling-time-ns = <300>;
>  		i2c-scl-falling-time-ns = <300>;
> +		pinctrl-names = "default", "gpio";
> +		pinctrl-0 = <&pinctrl_i2c1_default>;
> +		pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +		scl-gpios = <&porta 26 GPIO_ACTIVE_HIGH>;
> +		sda-gpios = <&porta 27 GPIO_ACTIVE_HIGH>;
>  	};
