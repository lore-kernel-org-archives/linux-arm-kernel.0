From: s-anna@ti.com (Suman Anna)
Date: Tue, 2 Jan 2018 17:30:04 -0600
Subject: [PATCH 1/8] ARM: dts: keystone: Move keystone_irq to under
 device-state-control
In-Reply-To: <20180102170202.15045-2-afd@ti.com>
References: <20180102170202.15045-1-afd@ti.com>
 <20180102170202.15045-2-afd@ti.com>
Message-ID: <cce1676d-8e91-c3d4-be79-7896011a8f26@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 01/02/2018 11:01 AM, Andrew F. Davis wrote:
> The keystone_irq node describes a device that is a component of the device
> state control module. 

I would prefer 'address space' to be added to this statement as this
module is really not a single IP but really a collection of different
register sets providing different functionalities. Some of these
comments apply to the following patches as well.

As such, it should not be a member of soc0 bus
> but instead a sub-node of device-state-control.
> 
> This move also fixes a warning about not having a reg property. Now
> that this is a sub-node of device-state-control, a syscon type node,
> we add this reg property but relative to the syscon base, this way
> when the dt-binding/driver are updated we can drop the non-standard
> ti,syscon-dev property completely and simply use get_resource() in
> the driver.

Please add an appropriate 'ranges' property in the parent node following
the parent-child node convention, it's upto individual drivers to use
the appropriate API for whether they want to deal with the offset or the
actual bus addresses. You should not tie this into forcing to use a
get_resource() without ranges to get the offset.

> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/keystone.dtsi | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index 93ea5c69ea77..158e0a903f7e 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -87,8 +87,19 @@
>  		};
>  
>  		devctrl: device-state-control at 2620000 {
> -			compatible = "ti,keystone-devctrl", "syscon";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "ti,keystone-devctrl", "syscon", "simple-mfd";

nit, can you please maintain the current order of compatible and reg,
and add the new properties after them.

regards
Suman

>  			reg = <0x02620000 0x1000>;
> +
> +			kirq0: keystone_irq at 2a0 {
> +				compatible = "ti,keystone-irq";
> +				reg = <0x2a0 0x4>;
> +				interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				ti,syscon-dev = <&devctrl 0x2a0>;
> +			};
>  		};
>  
>  		rstctrl: reset-controller {
> @@ -282,14 +293,6 @@
>  				  1 0 0x21000A00 0x00000100>;
>  		};
>  
> -		kirq0: keystone_irq at 26202a0 {
> -			compatible = "ti,keystone-irq";
> -			interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
> -			interrupt-controller;
> -			#interrupt-cells = <1>;
> -			ti,syscon-dev = <&devctrl 0x2a0>;
> -		};
> -
>  		pcie0: pcie at 21800000 {
>  			compatible = "ti,keystone-pcie", "snps,dw-pcie";
>  			clocks = <&clkpcie>;
> 
