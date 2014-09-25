From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Sep 2014 15:27:30 -0700
Subject: [RFC PATCH 4/4] ARM: dts: k2hk-evm: add pm domains for net,
 qmss and knav_dmas
In-Reply-To: <1411657537-25238-5-git-send-email-grygorii.strashko@ti.com>
 (Grygorii Strashko's message of "Thu, 25 Sep 2014 18:05:37 +0300")
References: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>
 <1411657537-25238-5-git-send-email-grygorii.strashko@ti.com>
Message-ID: <7hd2aj9vzh.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> Add Keystone PM domains nodes for NetCP, NetCPx, QMSS, KNAV-DMA
> devices.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/boot/dts/k2hk-evm.dts | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
> index 91371f7..a7b468c 100644
> --- a/arch/arm/boot/dts/k2hk-evm.dts
> +++ b/arch/arm/boot/dts/k2hk-evm.dts
> @@ -58,6 +58,13 @@
>  				clock-output-names = "refclk-ddr3b";
>  			};
>  		};
> +
> +		qmss_domain: qmss_pm_controller {
> +			compatible = "ti,keystone-gpc";
> +			clocks = <&chipclk13>;
> +			#power-domain-cells = <0>;
> +		};

Hmm, I'm still a bit confused by what you're attempting to do here.
Unless I'm missing someting, clocks are properties of the device, not
the pm-domain...

>  		qmss: qmss at 2a40000 {
>  			compatible = "ti,keystone-navigator-qmss";
>  			dma-coherent;
> @@ -65,6 +72,8 @@
>  			#size-cells = <1>;
>  			clocks = <&chipclk13>;
>  			ranges;
> +			power-domains = <&qmss_domain>;

...  Also, each of the pm domains is duplicating the list of clocks from
the device node, so I'm not sure what this is accomplishing.

Why not just have a single, more generic power domain that gets the list
of clocks from the device node.

Kevin
