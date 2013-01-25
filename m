From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 25 Jan 2013 11:53:38 +0530
Subject: [PATCH 1/2] ARM: davinci: da850: add DT node for eth0.
In-Reply-To: <1358749759-20517-2-git-send-email-prabhakar.lad@ti.com>
References: <1358749759-20517-1-git-send-email-prabhakar.lad@ti.com>
 <1358749759-20517-2-git-send-email-prabhakar.lad@ti.com>
Message-ID: <510224EA.9080705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prabhakar,

On 1/21/2013 11:59 AM, Prabhakar Lad wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> Add eth0 device tree node information to da850 by
> providing interrupt details and local mac address of eth0.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: netdev at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Heiko Schocher <hs@denx.de>
> ---
>  arch/arm/boot/dts/da850-evm.dts |    3 +++
>  arch/arm/boot/dts/da850.dtsi    |   15 +++++++++++++++

Can you rebase this to apply to v3.9/dt branch of my tree?

>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 37dc5a3..a1d6e3e 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -24,5 +24,8 @@
>  		serial2: serial at 1d0d000 {
>  			status = "okay";
>  		};
> +		eth0: emac at 1e20000 {
> +			status = "okay";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 640ab75..309cc99 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -56,5 +56,20 @@
>  			interrupt-parent = <&intc>;
>  			status = "disabled";
>  		};
> +		eth0: emac at 1e20000 {
> +			compatible = "ti,davinci-dm6467-emac";
> +			reg = <0x220000 0x4000>;
> +			ti,davinci-ctrl-reg-offset = <0x3000>;
> +			ti,davinci-ctrl-mod-reg-offset = <0x2000>;
> +			ti,davinci-ctrl-ram-offset = <0>;
> +			ti,davinci-ctrl-ram-size = <0x2000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <33
> +					34
> +					35
> +					36
> +					>;
> +			interrupt-parent = <&intc>;

instead of setting interrupt-parent for each node, this can be done once
for soc and child nodes should inherit this property. This needs to be
fixed for existing serial nodes too.

Also, can you take care of pinmux too? we should not be relying on
u-boot to setup the pinmux for us.

Thanks,
Sekhar
