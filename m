From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Jan 2016 15:30:55 +0000
Subject: [PATCH V12 2/7] dma: hidma: Add Device Tree support
In-Reply-To: <20160115151637.GJ3262@leverpostej>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-3-git-send-email-okaya@codeaurora.org>
 <20160115151637.GJ3262@leverpostej>
Message-ID: <20160115153054.GL3262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 03:16:38PM +0000, Mark Rutland wrote:
> On Mon, Jan 11, 2016 at 09:45:42AM -0500, Sinan Kaya wrote:
> > Add documentation for the Qualcomm Technologies HIDMA driver.
> 
> s/driver/binding/
> 
> 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > Acked-by: Rob Herring <robh@kernel.org>

Further to my reply below, I'm generally uncomfortable with some
properties (max-* need a better description if they are a HW
requirement, and probably should not be present otherwise). I'm also
concerned that information necessary for the advertised use-case of the
device (e.g. IOMMUs) is missing [1], and we're missing parts of the
story necessary to review this for correctness.

Until that's settled, I don't think this is ready yet, and I don't think
this should be picked up.

I'm sorry to say that at this stage, as I realise that may sound
obstructive. That's not my intention, and I hope we can figure out those
details quickly.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399850.html

> > ---
> >  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    | 79 ++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> > new file mode 100644
> > index 0000000..0e6ed1f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> > @@ -0,0 +1,79 @@
> > +Qualcomm Technologies HIDMA Management interface
> > +
> > +Qualcomm Technologies HIDMA is a high speed DMA device. It only supports
> > +memcpy and memset capabilities. It has been designed for virtualized
> > +environments.
> > +
> > +Each HIDMA HW instance consists of multiple DMA channels. These channels
> > +share the same bandwidth. The bandwidth utilization can be parititioned
> > +among channels based on the priority and weight assignments.
> > +
> > +There are only two priority levels and 15 weigh assignments possible.
> > +
> > +Other parameters here determine how much of the system bus this HIDMA
> > +instance can use like maximum read/write request and and number of bytes to
> > +read/write in a single burst.
> > +
> > +Main node required properties:
> > +- compatible: "qcom,hidma-mgmt-1.0";
> > +- reg: Address range for DMA device
> > +- dma-channels: Number of channels supported by this DMA controller.
> > +- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
> > +  fragmented to multiples of this amount.
> > +- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
> > +  fragmented to multiples of this amount.
> > +- max-write-transactions: Maximum write transactions to perform in a burst
> > +- max-read-transactions: Maximum read transactions to perform in a burst
> 
> Just to check, where do these max-* values come from?
> 
> Are they some correctness requirement of the bus this is attached to?
> 
> Are they tuning values?
> 
> The latter doesn't really belong in the DT. Given they're writeable from
> the driver, it seems like that's what they are...
> 
> > +- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
> 
> I'm not sure what this means. Could you elaborate on this is?
> 
> > +
> > +Sub-nodes:
> > +
> > +HIDMA has one or more DMA channels that are used to move data from one
> > +memory location to another.
> > +
> > +Each DMA channel is described as a sub-node under the management object.
> > +When a transfer channel is given to the guest operating system, only the channel
> > +object is created. The drivers have support for both flat and hierarchical
> > +configuration.
> 
> Don't mention drivers here.
> 
> All you need to state is that when the OS is not in control of the
> management interface (i.e. it's a guest), the channel nodes appear on
> their own, not under a management node.
> 
> Other than the above questions, this looks ok to me.
> 
> Thanks,
> Mark.
> 
> > +
> > +Required properties:
> > +- compatible: must contain "qcom,hidma-1.0"
> > +- reg: Addresses for the transfer and event channel
> > +- interrupts: Should contain the event interrupt
> > +- desc-count: Number of asynchronous requests this channel can handle
> > +- channel-index: The HW event channel completions will be delivered.
> > +
> > +Example:
> > +
> > +Hypervisor OS configuration:
> > +
> > +	hidma-mgmt at f9984000 = {
> > +		compatible = "qcom,hidma-mgmt-1.0";
> > +		reg = <0xf9984000 0x15000>;
> > +		dma-channels = <6>;
> > +		max-write-burst-bytes = <1024>;
> > +		max-read-burst-bytes = <1024>;
> > +		max-write-transactions = <31>;
> > +		max-read-transactions = <31>;
> > +		channel-reset-timeout-cycles = <0x500>;
> > +
> > +		hidma_24: dma-controller at 0x5c050000 {
> > +			compatible = "qcom,hidma-1.0";
> > +			reg = <0 0x5c050000 0x0 0x1000>,
> > +			      <0 0x5c0b0000 0x0 0x1000>;
> > +			interrupts = <0 389 0>;
> > +			desc-count = <10>;
> > +			channel-index = <4>;
> > +		};
> > +	};
> > +
> > +Guest OS configuration:
> > +
> > +	hidma_24: dma-controller at 0x5c050000 {
> > +		compatible = "qcom,hidma-1.0";
> > +		reg = <0 0x5c050000 0x0 0x1000>,
> > +		      <0 0x5c0b0000 0x0 0x1000>;
> > +		interrupts = <0 389 0>;
> > +		desc-count = <10>;
> > +		channel-index = <4>;
> > +	};
> > -- 
> > Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
