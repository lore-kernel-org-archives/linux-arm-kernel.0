From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Dec 2015 16:41:38 +0000
Subject: [PATCH V9 2/5] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
References: <1449850623-32214-1-git-send-email-okaya@codeaurora.org>
 <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20151211164137.GA23638@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 11, 2015 at 11:16:58AM -0500, Sinan Kaya wrote:
> The Qualcomm Technologies HIDMA device has been designed to support
> virtualization technology. The driver has been divided into two to follow
> the hardware design.
> 
> 1. HIDMA Management driver
> 2. HIDMA Channel driver
> 
> Each HIDMA HW consists of multiple channels. These channels share some set
> of common parameters. These parameters are initialized by the management
> driver during power up. Same management driver is used for monitoring the
> execution of the channels. Management driver can change the performance
> behavior dynamically such as bandwidth allocation and prioritization.
> 
> The management driver is executed in hypervisor context and is the main
> management entity for all channels provided by the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++++++
>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++++

Please split the binding into a separate patch, per
Documentation/devicetree/bindings/submitting-patches.txt.

> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> new file mode 100644
> index 0000000..b632635
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> @@ -0,0 +1,61 @@
> +Qualcomm Technologies HIDMA Management interface
> +
> +The Qualcomm Technologies HIDMA device has been designed
> +to support virtualization technology. The driver has been
> +divided into two to follow the hardware design. The management
> +driver is executed in hypervisor context and is the main
> +management entity for all channels provided by the device.
> +
> +Each HIDMA HW consists of multiple channels. These channels
> +share some set of common parameters. These parameters are
> +initialized by the management driver during power up.
> +Same management driver is used for monitoring the execution
> +of the channels. Management driver can change the performance
> +behavior dynamically such as bandwidth allocation and
> +prioritization.
> +
> +All channel devices get probed in the hypervisor
> +context during power up. They show up as DMA engine
> +DMA channels. Then, before starting the virtualization; each
> +channel device is unbound from the hypervisor by VFIO
> +and assign to the guest machine for control.
> +
> +This management driver will  be used by the system
> +admin to monitor/reset the execution state of the DMA
> +channels. This will be the management interface.

This is a mixture of hardware and software description (e.g. VFIO has
nothing to do wit hteh hardware). We want to capture what is necessary
to describe the hardware, not what the software stack above it will look
like.

> +Required properties:
> +- compatible: "qcom,hidma-mgmt-1.0";
> +- reg: Address range for DMA device

Does this cover just the management registers, or those for channels as
well?

> +- dma-channels: Number of channels supported by this DMA controller.

Surely this is discoverable, or can be derived from the set of channels
described in the DT?

> +- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
> +  fragmented to multiples of this amount.
> +- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
> +  fragmented to multiples of this amount.
> +- max-write-transactions: Maximum write transactions to perform in a burst
> +- max-read-transactions: Maximum read transactions to perform in a burst
> +- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
> +- channel-priority: Priority of the channel.
> +  Each dma channel share the same HW bandwidth with other dma channels.
> +  If two requests reach to the HW at the same time from a low priority and
> +  high priority channel, high priority channel will claim the bus.
> +  0=low priority, 1=high priority
> +- channel-weight: Round robin weight of the channel
> +  Since there are only two priority levels supported, scheduling among
> +  the equal priority channels is done via weights.

Per the example, these last two seem to be arrays, which wasn't clear
from the description.

Why can this information not be associated with the channel directly?

How does one choose the right priority and/or weight? These seem like
runtime details given that channels are indned to be allocated by
software.

There's no relationship to channels defined here. What happens if/when
you have a system with multiple instances?

> +
> +Example:
> +
> +	hidma-mgmt at f9984000 = {
> +		compatible = "qcom,hidma-mgmt-1.0";
> +		reg = <0xf9984000 0x15000>;
> +		dma-channels = 6;
> +		max-write-burst-bytes = 1024;
> +		max-read-burst-bytes = 1024;
> +		max-write-transactions = 31;
> +		max-read-transactions = 31;
> +		channel-reset-timeout-cycles = 0x500;

Please fix the syntax here (you're missing '<' and '>' for values.

> +		channel-priority = <1 1 0 0 0 0>;
> +		channel-weight = <1 13 10 3 4 5>;
> +	};

I don't understand why you don't have a single binding for both the
management interface and channels, e.g.

hidma {
	compatible - "qcom,hidma-1.0";

	/* OPTIONAL management interface registers */
	reg = < ... ... >;

	...

	channels {
		channel0 {
			compatible = "qcom,
			reg = < ... ... >;

			...
		};

		...
	};
};

That would be more in keeping with what we do for other componenents
with hyp control elements (e.g. the GIC) and keeps everything
associated.

Thanks,
Mark.
