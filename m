From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 20 Apr 2016 12:05:14 -0700
Subject: [PATCH v2 1/1] arm64: dts: NS2 secondary core enablement via PSCI
In-Reply-To: <1461174002-18178-1-git-send-email-luke.starrett@broadcom.com>
References: <1461174002-18178-1-git-send-email-luke.starrett@broadcom.com>
Message-ID: <5717D2EA.4030900@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good while we are using PSCI-1.0

Acked-by: Scott Branden <scott.branden@broadcom.com>

On 16-04-20 10:40 AM, Luke Starrett wrote:
> Declare PSCI-1.0 node and enable CPU_ON method via PSCI.  Spin-table
> memreserve has been removed as well as syscon based reset, as PSCI-1.0
> expects reset implementation in firmware.
>
> Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>
> ---
>
> Changes from v1:
>   - No code changes, adding missing reviewers to CC list
>
>   arch/arm64/boot/dts/broadcom/ns2.dtsi | 31 +++++++++----------------------
>   1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index 123cd9c..ec68ec1 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -33,8 +33,6 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/bcm-ns2.h>
>
> -/memreserve/ 0x84b00000 0x00000008;
> -
>   / {
>   	compatible = "brcm,ns2";
>   	interrupt-parent = <&gic>;
> @@ -49,8 +47,7 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a57", "arm,armv8";
>   			reg = <0 0>;
> -			enable-method = "spin-table";
> -			cpu-release-addr = <0 0x84b00000>;
> +			enable-method = "psci";
>   			next-level-cache = <&CLUSTER0_L2>;
>   		};
>
> @@ -58,8 +55,7 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a57", "arm,armv8";
>   			reg = <0 1>;
> -			enable-method = "spin-table";
> -			cpu-release-addr = <0 0x84b00000>;
> +			enable-method = "psci";
>   			next-level-cache = <&CLUSTER0_L2>;
>   		};
>
> @@ -67,8 +63,7 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a57", "arm,armv8";
>   			reg = <0 2>;
> -			enable-method = "spin-table";
> -			cpu-release-addr = <0 0x84b00000>;
> +			enable-method = "psci";
>   			next-level-cache = <&CLUSTER0_L2>;
>   		};
>
> @@ -76,8 +71,7 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a57", "arm,armv8";
>   			reg = <0 3>;
> -			enable-method = "spin-table";
> -			cpu-release-addr = <0 0x84b00000>;
> +			enable-method = "psci";
>   			next-level-cache = <&CLUSTER0_L2>;
>   		};
>
> @@ -86,6 +80,11 @@
>   		};
>   	};
>
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) |
> @@ -252,18 +251,6 @@
>   			mmu-masters;
>   		};
>
> -		crmu: crmu at 65024000 {
> -			compatible = "syscon";
> -			reg = <0x65024000 0x100>;
> -		};
> -
> -		reboot at 65024000 {
> -			compatible ="syscon-reboot";
> -			regmap = <&crmu>;
> -			offset = <0x90>;
> -			mask = <0xfffffffd>;
> -		};
> -
>   		gic: interrupt-controller at 65210000 {
>   			compatible = "arm,gic-400";
>   			#interrupt-cells = <3>;
>
