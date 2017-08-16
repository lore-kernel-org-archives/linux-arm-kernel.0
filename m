From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Aug 2017 16:58:58 +0100
Subject: [PATCHv2 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <57156284c0a96dc710c660ec22c15563808cb760.1502886277.git.michal.simek@xilinx.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
 <57156284c0a96dc710c660ec22c15563808cb760.1502886277.git.michal.simek@xilinx.com>
Message-ID: <20170816155858.GA12389@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 02:24:58PM +0200, Michal Simek wrote:
> This patch is adding communication layer with firmware.

Which is used for what, exactly?

There are no users of this API introduced in this series.

> The most of request are coming thought ATF to PMUFW (platform management
> unit).

[...]

> +/**
> + * get_set_conduit_method - Choose SMC or HVC based communication
> + * @np:	Pointer to the device_node structure
> + *
> + * Use SMC or HVC-based functions to communicate with EL2/EL3
> + */
> +static void get_set_conduit_method(struct device_node *np)
> +{
> +	const char *method;
> +	struct device *dev;
> +
> +	dev = container_of(&np, struct device, of_node);
> +
> +	if (of_property_read_string(np, "method", &method)) {
> +		dev_warn(dev, "%s Missing \"method\" property - defaulting to smc\n",
> +			 __func__);
> +		do_fw_call = do_fw_call_smc;
> +		return;
> +	}

This is a mandatory property. Don't guess if it's not present.

[...]

> +/**
> + * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
> + * @reset:		Reset to be configured
> + * @assert_flag:	Flag stating should reset be asserted (1) or
> + *			released (0)
> + *
> + * Return:		Returns status, either success or error+reason
> + */
> +int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +			   const enum zynqmp_pm_reset_action assert_flag)
> +{
> +	return invoke_pm_fn(RESET_ASSERT, reset, assert_flag, 0, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);

Where is the reset nr expected to come from?

Nothing in this series defined bindings for those.

> +/**
> + * zynqmp_pm_mmio_write - Perform write to protected mmio
> + * @address:	Address to write to
> + * @mask:	Mask to apply
> + * @value:	Value to write
> + *
> + * This function provides access to PM-related control registers
> + * that may not be directly accessible by a particular PU.
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_mmio_write(const u32 address,
> +			 const u32 mask,
> +				     const u32 value)
> +{
> +	return invoke_pm_fn(MMIO_WRITE, address, mask, value, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_mmio_write);
> +
> +/**
> + * zynqmp_pm_mmio_read - Read value from protected mmio
> + * @address:	Address to write to
> + * @value:	Value to read
> + *
> + * This function provides access to PM-related control registers
> + * that may not be directly accessible by a particular PU.
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_mmio_read(const u32 address, u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	invoke_pm_fn(MMIO_READ, address, 0, 0, 0, ret_payload);
> +	*value = ret_payload[1];
> +
> +	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_mmio_read);

I guess these are to secure memory?

How are these safe?

What validation is done on the secure side?

> +
> +/**
> + * zynqmp_pm_fpga_load - Perform the fpga load
> + * @address:    Address to write to
> + * @size:       pl bitstream size
> + * @flags:
> + *	BIT(0) - Bit-stream type.
> + *		 0 - Full Bit-stream.
> + *		 1 - Partial Bit-stream.
> + *	BIT(1) - Authentication.
> + *		 1 - Enable.
> + *		 0 - Disable.
> + *	BIT(2) - Encryption.
> + *		 1 - Enable.
> + *		 0 - Disable.
> + * NOTE -
> + *	The current implementation supports only Full Bit-stream.
> + *
> + * This function provides access to xilfpga library to transfer
> + * the required bitstream into PL.
> + *
> + * Return:      Returns status, either success or error+reason
> + */
> +int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
> +{
> +	return invoke_pm_fn(FPGA_LOAD, (u32)address,
> +			((u32)(address >> 32)), size, flags, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);

What space is the address in?

*which* FPGA instance is this? Surely this needs to be linked to a node
in the DT by some means?

[...]

> +static int __init zynqmp_plat_init(void)
> +{
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> +	if (!np)
> +		return 0;
> +	of_node_put(np);
> +
> +	/* We're running on a ZynqMP machine, the PM node is mandatory. */
> +	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-pm");
> +	if (!np)
> +		panic("%s: pm node not found\n", __func__);

NAK to this panic(). It breaks existing DTBs.

[...]

> +enum pm_api_id {
> +	/* Miscellaneous API functions: */
> +	GET_API_VERSION = 1,
> +	SET_CONFIGURATION,
> +	GET_NODE_STATUS,
> +	GET_OPERATING_CHARACTERISTIC,
> +	REGISTER_NOTIFIER,
> +	/* API for suspending of PUs: */
> +	REQUEST_SUSPEND,
> +	SELF_SUSPEND,
> +	FORCE_POWERDOWN,
> +	ABORT_SUSPEND,
> +	REQUEST_WAKEUP,
> +	SET_WAKEUP_SOURCE,
> +	SYSTEM_SHUTDOWN,

What are these? They sound like they overlap with PSCI.

Thanks,
Mark.
