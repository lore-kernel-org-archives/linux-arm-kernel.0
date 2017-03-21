From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Mar 2017 14:07:42 +0000
Subject: [PATCH v6 03/11] dt-bindings: perf: hisi: Add Devicetree
 bindings for Hisilicon SoC PMU
In-Reply-To: <1489127248-112605-1-git-send-email-anurup.m@huawei.com>
References: <1489127248-112605-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170321140741.GD22188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 01:27:27AM -0500, Anurup M wrote:
> +HiSilicon SoC chip is encapsulated by multiple CPU and IO dies. The CPU die
> +is called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
> +in HiP05/06/07 chips are further grouped as CPU clusters (CCL) which includes
> +4 cpu-cores each.
> +e.g. In the case of HiP05/06/07, each SCCL has 1 L3 cache and 1 MN PMU device.
> +The L3 cache is further grouped as 4 L3 cache banks in a SCCL.
> +
> +The Hisilicon SoC PMU DT node bindings for uncore PMU devices are as below.
> +For PMU devices like L3 cache. MN etc. which are accessed using the djtag,
> +the parent node will be the djtag node of the corresponding CPU die (SCCL).
> +
> +L3 cache
> +---------
> +The L3 cache is dedicated for each SCCL. Each SCCL in HiP05/06/07 chips have 4
> +L3 cache banks. Each L3 cache bank have separate DT nodes.
> +
> +Required properties:
> +
> +	- compatible : This value should be as follows
> +		(a) "hisilicon,hip05-pmu-l3c-v1" for v1 hw in HiP05 chipset
> +		(b) "hisilicon,hip06-pmu-l3c-v1" for v1 hw in HiP06 chipset
> +		(c) "hisilicon,hip07-pmu-l3c-v2" for v2 hw in HiP07 chipset
> +
> +	- hisilicon,module-id : This property is a combination of two values
> +	    in the below order.
> +		a) Module ID: The module identifier for djtag.
> +		b) Instance or Bank ID: This will identify the L3 cache bank
> +		 or instance.

I take it this is intended two mean this property is two cells in
length, with one cell for each of the below.

This is a somewhat confusing proeprty given that the name only applies
to the first half of the value...

> +
> +	*The counter overflow IRQ is not supported in v1, v2 hardware (HiP05/06/07).
> +
> +Miscellaneous Node
> +------------------
> +The MN is dedicated for each SCCL and hence there are separate DT nodes for MN
> +for each SCCL.
> +
> +Required properties:
> +
> +	- compatible : This value should be as follows
> +		(a) "hisilicon,hip05-pmu-mn-v1" for v1 hw in HiP05 chipset
> +		(b) "hisilicon,hip06-pmu-mn-v1" for v1 hw in HiP06 chipset
> +		(c) "hisilicon,hip07-pmu-mn-v2" for v2 hw in HiP07 chipset
> +
> +	- hisilicon,module-id : Module ID to input for djtag.

This needs to be described more thoroughly.

Thanks,
Mark.

> +
> +	*The counter overflow IRQ is not supported in v1, v2 hardware (HiP05/06/07).
> +
> +Example:
> +
> +	djtag0: djtag at 60010000 {
> +		compatible = "hisilicon,hip07-cpu-djtag-v2";
> +		reg = <0x0 0x60010000 0x0 0x10000>;
> +		hisilicon,scl-id = <0x03>;
> +
> +		pmul3c0 {
> +			compatible = "hisilicon,hip07-pmu-l3c-v2";
> +			hisilicon,module-id = <0x01 0x01>;
> +		};
> +
> +		pmul3c1 {
> +			compatible = "hisilicon,hip07-pmu-l3c-v2";
> +			hisilicon,module-id = <0x02 0x01>;
> +		};
> +
> +		pmul3c2 {
> +			compatible = "hisilicon,hip07-pmu-l3c-v2";
> +			hisilicon,module-id = <0x03 0x01>;
> +		};
> +
> +		pmul3c3 {
> +			compatible = "hisilicon,hip07-pmu-l3c-v2";
> +			hisilicon,module-id = <0x04 0x01>;
> +		};
> +
> +		pmumn0 {
> +			compatible = "hisilicon,hip07-pmu-mn-v2";
> +			hisilicon,module-id = <0x21>;
> +		};
> +	};
> -- 
> 2.1.4
> 
