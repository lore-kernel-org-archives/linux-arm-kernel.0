From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 3 Apr 2017 10:12:44 +0200
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <db45d0d68957d699f13a0d92f4f84d8ebfd0270e.1491118230.git.guillaume.tucker@collabora.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <db45d0d68957d699f13a0d92f4f84d8ebfd0270e.1491118230.git.guillaume.tucker@collabora.com>
Message-ID: <a01a50d3-bb1b-2c56-2a15-30651fa2fac9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2017 09:59 AM, Guillaume Tucker wrote:
> The ARM Mali Midgard GPU family is present in a number of SoCs
> from many different vendors such as Samsung Exynos and Rockchip.
> 
> Import the device tree bindings documentation from the r16p0
> release of the Mali Midgard GPU kernel driver:
> 
>   https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu/TX011-SW-99002-r16p0-00rel0.tgz
> 
> The following optional bindings have been omitted in this initial
> version as they are only used in very specific cases:
> 
>   * snoop_enable_smc
>   * snoop_disable_smc
>   * jm_config
>   * power_model
>   * system-coherency
>   * ipa-model
> 
> The example has been simplified accordingly.
> 
> The compatible string definition has been limited to
> "arm,mali-midgard" to avoid checkpatch.pl warnings and to match
> what the driver actually expects (as of r16p0 out-of-tree).
> 
> CC: John Reitan <john.reitan@arm.com>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> new file mode 100644
> index 000000000000..da8fc6d21bbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -0,0 +1,53 @@
> +#
> +# (C) COPYRIGHT 2013-2016 ARM Limited.
> +# Copyright (C) 2017 Collabora Ltd
> +#
> +# This program is free software and is provided to you under the terms of the
> +# GNU General Public License version 2 as published by the Free Software
> +# Foundation, and any use by you of this program is subject to the terms
> +# of such GNU licence.
> +#
Hi Guillaume,

This is unnecessary, please remove.

> +
> +
> +ARM Mali Midgard GPU
> +====================
> +
> +Required properties:
> +
> +- compatible : Should be "arm,mali-midgard".
> +- reg : Physical base address of the device and length of the register area.
> +- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
> +- interrupt-names : Contains the names of IRQ resources in the order they were
> +  provided in the interrupts property. Must contain: "JOB, "MMU", "GPU".


Please follow the bindings introduced for the utgard family :
https://patchwork.kernel.org/patch/9553745/

- an entry for each mali-midgard revision, i.e. "arm,mali-t820"
- an entry for each vendor specific wrapping if necessary, i.e. "amlogic,meson-gxm-mali"
- low-case for interrupt names

> +
> +Optional:
> +
> +- clocks : Phandle to clock for the Mali Midgard device.
> +- clock-names : Shall be "clk_mali".
> +- mali-supply : Phandle to regulator for the Mali device. Refer to
> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> +- operating-points : Refer to Documentation/devicetree/bindings/power/opp.txt
> +  for details.

Please add :
   * Must be one of the following:
      "arm,mali-t820"
   * And, optionally, one of the vendor specific compatible:
      "amlogic,meson-gxm-mali"

with my Ack for the amlogic platform.

> +
> +Example for a Mali-T602:
> +
> +gpu at 0xfc010000 {
> +	compatible = "arm,mali-midgard";
> +	reg = <0xfc010000 0x4000>;
> +	interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
> +	interrupt-names = "JOB", "MMU", "GPU";
> +
> +	clocks = <&pclk_mali>;
> +	clock-names = "clk_mali";
> +	mali-supply = <&vdd_mali>;
> +	operating-points = <
> +		/* KHz   uV */
> +		533000 1250000,
> +		450000 1150000,
> +		400000 1125000,
> +		350000 1075000,
> +		266000 1025000,
> +		160000  925000,
> +		100000  912500,
> +	>;
> +};
> 

Thanks,
Neil
