From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Apr 2014 17:31:50 +0200
Subject: [PATCH 23/29] ARM: orion5x: use DT to describe NOR on edmini_v2
In-Reply-To: <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140413153150.GD10033@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 04:40:00PM +0200, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for NOR flash, using the Device Bus.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 46 +++++++++++++++-
>  arch/arm/mach-orion5x/edmini_v2-setup.c            | 62 ----------------------
>  2 files changed, 45 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index ff90b01..44cc36a 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -27,7 +27,51 @@
>  
>  	soc {
>  		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
> -			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>;
> +			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
> +			 <MBUS_ID(0x01, 0x0f) 0 0xfff80000 0x80000>;
> +
> +		devbus-bootcs {
> +			status = "okay";
> +
> +			/* Read parameters */
> +			devbus,bus-width    = <8>;
> +			devbus,turn-off-ps  = <90000>;
> +			devbus,badr-skew-ps = <0>;
> +			devbus,acc-first-ps = <186000>;
> +			devbus,acc-next-ps  = <186000>;
> +
> +			/* Write parameters */
> +			devbus,wr-high-ps  = <90000>;
> +			devbus,wr-low-ps   = <90000>;
> +			devbus,ale-wr-ps   = <90000>;
> +
> +			/*
> +			 * Currently the MTD code does not recognize
> +			 * the MX29LV400CBCT as a bottom-type
> +			 * device. This could cause risks of
> +			 * accidentally erasing critical flash
> +			 * sectors. We thus define a single,
> +			 * write-protected partition covering the
> +			 * whole flash.  TODO: once the flash part
> +			 * TOP/BOTTOM detection issue is sorted out in
> +			 * the MTD code, break this into at least
> +			 * three partitions: 'u-boot code', 'u-boot
> +			 * environment' and 'whatever is left'.
> +			 */
> +			nor at 0 {
> +				compatible = "cfi-flash";
> +				reg = <0 0x80000>;
> +				bank-width = <1>;
> +		                #address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition at 0 {
> +					label = "Full512Kb";
> +					reg = <0 0x80000>;
> +					read-only;
> +				};
> +			};
> +		};
>  
>  		internal-regs {
>  			pinctrl at 10000 {
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> index 2eebc0c..6bef2d5 100644
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
> @@ -42,74 +42,12 @@
>   * EDMINI_V2 Info
>   ****************************************************************************/
>  
> -/*
> - * 512KB NOR flash Device bus boot chip select
> - */
> -
> -#define EDMINI_V2_NOR_BOOT_BASE		0xfff80000
> -#define EDMINI_V2_NOR_BOOT_SIZE		SZ_512K
> -
> -/*****************************************************************************
> - * 512KB NOR Flash on BOOT Device
> - ****************************************************************************/
> -
> -/*
> - * Currently the MTD code does not recognize the MX29LV400CBCT as a bottom
> - * -type device. This could cause risks of accidentally erasing critical
> - * flash sectors. We thus define a single, write-protected partition covering
> - * the whole flash.
> - * TODO: once the flash part TOP/BOTTOM detection issue is sorted out in the MTD
> - * code, break this into at least three partitions: 'u-boot code', 'u-boot
> - * environment' and 'whatever is left'.
> - */

Hi Thomas

Did you check if this is still true? If it is fixed, maybe now would
be a good time to swap to three partitions?

   Andrew
