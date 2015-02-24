From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Feb 2015 18:38:31 +0000
Subject: [PATCH] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <8ac3037c175711dec0adcd0d898be7d9722e0ed0.1424764548.git.michal.simek@xilinx.com>
References: <8ac3037c175711dec0adcd0d898be7d9722e0ed0.1424764548.git.michal.simek@xilinx.com>
Message-ID: <20150224183831.GZ9714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

I have a few minor comments below, but generally this is looking like
one of the best dts submissions I've seen!

[...]

> +/ {
> +       model = "ZynqMP EP108";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };

Thanks for using stdout-path with the full parameters.

Does your UART have earlycon support?

[...]

> +/ {
> +       compatible = "xlnx,zynqmp";
> +       #address-cells = <2>;
> +       #size-cells = <1>;

I guess this is fine, though to me it feels more natural to use
#size-cells = <2> in case we need to describe larger ranges for some bus
later.

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       reg = <0x0>;
> +               };
> +
> +               cpu at 1 {
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       reg = <0x1>;
> +               };
> +
> +               cpu at 2 {
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       reg = <0x2>;
> +               };
> +
> +               cpu at 3 {
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       reg = <0x3>;
> +               };
> +       };

These look fine.

> +
> +       psci {
> +               compatible = "arm,psci-0.2";
> +               method = "smc";
> +       };

Neat!

What are you using as your implementation? Are all the mandatory
PSCIv0.2 features implemented (e.g. MIGRATE_INFO_TYPE)?

I take it this boots at EL2 on all CPUs?

Does CPU0 hotplug work?

Do you need to keep a CPU online or do you require MIGRATE? e.g. does
MIGRATE_INFO_TYPE return something other than 2 ("MP or not present")?

[...]

> +       amba_apu {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               timer {
> +                       compatible = "arm,armv8-timer";
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <1 13 0xff01>,
> +                                    <1 14 0xff01>,
> +                                    <1 11 0xff01>,
> +                                    <1 10 0xff01>;
> +               };

The architected timer should just be under the root node, given it's a
component of the CPU -- it doesn't live on any bus.

I take it CNTFRQ is configured appropriately on all CPUs?

[...]

> +               i2c_clk: i2c_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0x0>;
> +                       clock-frequency = <111111111>;
> +               };

That clock-frequency looks a little odd. Is that right?

I haven't taken an in-depth look at the other nodes. They look sane at a
high-level, and assuming they are all already documented and supported
they look fine to me.

Thanks,
Mark.
