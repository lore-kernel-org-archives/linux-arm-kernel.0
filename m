From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 30 Mar 2016 13:12:52 +0300
Subject: [PATCH 2/7] ARM: dts: skeleton: add unit name to memory node
In-Reply-To: <1459290646-3592-3-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-3-git-send-email-manabian@gmail.com>
Message-ID: <56FBA6A4.2050509@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On 30.03.2016 01:30, Joachim Eastwood wrote:
> Add unit name to memory to remove the following warning:
>  Warning (unit_address_vs_reg): Node /memory has a reg or ranges
> 				property, but no unit name
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  arch/arm/boot/dts/skeleton.dtsi   | 2 +-
>  arch/arm/boot/dts/skeleton64.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/skeleton.dtsi b/arch/arm/boot/dts/skeleton.dtsi
> index b41d241..a20da0a 100644
> --- a/arch/arm/boot/dts/skeleton.dtsi
> +++ b/arch/arm/boot/dts/skeleton.dtsi
> @@ -9,5 +9,5 @@
>  	#size-cells = <1>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; reg = <0 0>; };
> +	memory at 0 { device_type = "memory"; reg = <0 0>; };
>  };
> diff --git a/arch/arm/boot/dts/skeleton64.dtsi b/arch/arm/boot/dts/skeleton64.dtsi
> index b5d7f36..6dbe9f9 100644
> --- a/arch/arm/boot/dts/skeleton64.dtsi
> +++ b/arch/arm/boot/dts/skeleton64.dtsi
> @@ -9,5 +9,5 @@
>  	#size-cells = <2>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; reg = <0 0 0 0>; };
> +	memory at 0 { device_type = "memory"; reg = <0 0 0 0>; };
>  };
> 

this looks wrong, because all inherited compiled dtbs will contain memory at 0
device node, for example (with applied 4/7 from this series):

% scripts/dtc/dtc -I dtb -O dts arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb
| grep -A3 memory@

	memory at 0 {
		device_type = "memory";
		reg = <0x0 0x0>;
	};
--
	memory at 28000000 {
		device_type = "memory";
		reg = <0x28000000 0x2000000>;
	};

--
With best wishes,
Vladimir
