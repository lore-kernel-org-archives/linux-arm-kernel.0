From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 15 May 2018 10:11:02 -0500
Subject: [PATCHv2] arm64: dts: stratix10: Add QSPI support for Stratix10
In-Reply-To: <1526055052-11371-1-git-send-email-thor.thayer@linux.intel.com>
References: <1526055052-11371-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20b33e1d-0609-78dd-dc9c-922658a11f18@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/11/2018 11:10 AM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add qspi_clock
>    The qspi_clk frequency is updated by U-Boot before starting Linux.
> Add QSPI interface node.
> Add QSPI flash memory child node.
>    Setup the QSPI memory in 2 partitions.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  s/_/-/ in qspi-clk
>     rename flash node.
>     use partition child node notation
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 22 ++++++++++++++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 35 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index e6b059378dc0..bac01b0b7907 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -119,6 +119,12 @@
>  				#clock-cells = <0>;
>  				compatible = "fixed-clock";
>  			};
> +
> +			qspi_clk: qspi-clk {
> +				#clock-cells = <0>;
> +				compatible = "fixed-clock";
> +				clock-frequency = <200000000>;
> +			};
>  		};
>  
>  		gmac0: ethernet at ff800000 {
> @@ -466,5 +472,21 @@
>  				interrupts = <16 4>, <48 4>;
>  			};
>  		};
> +
> +		qspi: spi at ff8d2000 {
> +			compatible = "cdns,qspi-nor";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0xff8d2000 0x100>,
> +			      <0xff900000 0x100000>;
> +			interrupts = <0 3 4>;
> +			cdns,fifo-depth = <128>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x00000000>;
> +			clocks = <&qspi_clk>;
> +			bus-num = <1>;

I don't you need "bus-num" anymore right? I don't see it getting used
anywhere in the driver.

Dinh
