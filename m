From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:36:46 +0200
Subject: [PATCH 3/5] ARM: dove: add MBus DT node
In-Reply-To: <1375101114-28858-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1375101114-28858-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <51F661DE.1070106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 02:31 PM, Sebastian Hesselbarth wrote:
> This adds a MBus node including ranges and pcie apertures required later.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>   arch/arm/boot/dts/dove.dtsi |   19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 397674c..bdda016 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -29,6 +29,20 @@
>   		marvell,tauros2-cache-features = <0>;
>   	};
>
> +	mbus {
> +		compatible = "marvell,dove-mbus", "marvell,mbus", "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256M MEM space */
> +		pcie-io-aperture  = <0xf2000000 0x00200000>; /*   2M I/O space */

Actually, current v9 of the mbus patch set still requires "controller"
property to match the corresponding controller node. I had a short
discussion with Ezequiel to possibly just use of_find_compatible_node
and blindly assumed post-v8 will already use it.

I will re-post the final patch set anyway on what mbus binding will be
merged for v3.12.

Sebastian

> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x0100000   /* MBUS regs  1M */
> +			  MBUS_ID(0xf0, 0x02) 0 0xf1800000 0x1000000   /* AXI  regs 16M */
> +			  MBUS_ID(0x01, 0xfd) 0 0xf8000000 0x8000000   /* BootROM  128M */
> +			  MBUS_ID(0x03, 0x01) 0 0xc8000000 0x0100000   /* CESA SRAM  1M */
> +			  MBUS_ID(0x0d, 0x00) 0 0xf0000000 0x0100000>; /* PMU  SRAM  1M */
> +	};
> +
>   	soc at f1000000 {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
> @@ -44,6 +58,11 @@
>   		          0xf2100000 0xf2100000 0x0100000   /* PCIe0 I/O   1M */
>   		          0xf8000000 0xf8000000 0x8000000>; /* BootROM   128M */
>
> +		mbusc: mbus-ctrl at 20000 {
> +			compatible = "marvell,mbus-controller";
> +			reg = <0x20000 0x80>, <0x800100 0x8>;
> +		};
> +
>   		timer: timer at 20300 {
>   			compatible = "marvell,orion-timer";
>   			reg = <0x20300 0x20>;
>
