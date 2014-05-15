From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 May 2014 12:35:17 +0200
Subject: [PATCH 1/3] ARM: dts: kirkwood: resynch 98dx4122 dtsi
In-Reply-To: <1400147335-20947-2-git-send-email-valentin.longchamp@keymile.com>
References: <1400147335-20947-1-git-send-email-valentin.longchamp@keymile.com>
 <1400147335-20947-2-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <53749865.809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 11:48 AM, Valentin Longchamp wrote:
> The 98DX4122 dtsi file lacks the defintion of the PCIe controller which
> is present on this SoC.

Valentin,

good to have you back on 98dx4122. I was already thinking about
reworking the current kirkwood.dtsi and kirkwood-<soc>.dtsi as I
feel there may be more issues with "common" IP that was removed
in 98dx4122.

> The SATA phys must also be explicitely disabled since they are not
> present on this SoC. If they remain enabled, a hardlock occures when
> their clock gates are enabled.

While I am ok with disabling now, we should really rethink the
current SoC-specific includes as we are already facing some issues
that cause headaches.

Actually, the initial idea was to remove all nodes from kirkwood.dtsi
that are not available in one of the SoCs and rather put them into
the SoC-specific include.

But over time we end up with a mix of both, SoC-specific nodes like
pcie below _and_ SoC-specific fixes like sata-phy below.

To be consitent, we should either duplicate the sata-phy nodes in
kirkwood-6foo.dtsi - or what I prefer - move most of it back to
kirkwood.dtsi and use "disabled" in the SoC-specific ones.

Although, it would be nice to have a common include and SoC-specific
include on top, I have the strong feeling we may never be able to
cleanly separate them.

For the patch itself, you get a tentative

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

to make KM boot again.

Sebastian

> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
>
>   arch/arm/boot/dts/kirkwood-98dx4122.dtsi | 43 ++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
> index 2e8e412..9e1f741 100644
> --- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
> @@ -1,4 +1,39 @@
>   / {
> +	mbus {
> +		pciec: pcie-controller {
> +			compatible = "marvell,kirkwood-pcie";
> +			status = "disabled";
> +			device_type = "pci";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			bus-range = <0x00 0xff>;
> +
> +			ranges =
> +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
> +				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
> +				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
> +
> +			pcie0: pcie at 1,0 {
> +				device_type = "pci";
> +				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
> +				reg = <0x0800 0 0 0 0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				#interrupt-cells = <1>;
> +				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> +					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
> +				interrupt-map-mask = <0 0 0 0>;
> +				interrupt-map = <0 0 0 0 &intc 9>;
> +				marvell,pcie-port = <0>;
> +				marvell,pcie-lane = <0>;
> +				clocks = <&gate_clk 2>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
>   	ocp at f1000000 {
>   		pinctrl: pin-controller at 10000 {
>   			compatible = "marvell,98dx4122-pinctrl";
> @@ -6,3 +41,11 @@
>   		};
>   	};
>   };
> +
> +&sata_phy0 {
> +	status = "disabled";
> +};
> +
> +&sata_phy1 {
> +	status = "disabled";
> +};
>
