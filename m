From: agross@codeaurora.org (Andy Gross)
Date: Tue, 28 Jan 2014 13:47:29 -0600
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <52E772DF.6000604@metafoo.de>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <1390890471-14882-3-git-send-email-agross@codeaurora.org>
 <52E772DF.6000604@metafoo.de>
Message-ID: <20140128194729.GA18930@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:05:35AM +0100, Lars-Peter Clausen wrote:
> On 01/28/2014 07:27 AM, Andy Gross wrote:
> > Add device tree binding support for the QCOM BAM DMA driver.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  .../devicetree/bindings/dma/qcom_bam_dma.txt       |   52 ++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > new file mode 100644
> > index 0000000..53fd10a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> > @@ -0,0 +1,52 @@
> > +QCOM BAM DMA controller
> > +
> > +Required properties:
> > +- compatible:	Must be "qcom,bam-v1.4.0" for MSM8974 V1
> > +		Must be "qcom,bam-v1.4.1" for MSM8974 V2
> > +- reg: Address range for DMA registers
> > +- interrupts: single interrupt for this controller
> > +- #dma-cells: must be <2>
> > +- clocks: required clock
> > +- clock-names: name of clock
> > +- qcom,ee : indicates the active Execution Environment identifier (0-7)
> > +
> > +Example:
> > +
> > +	uart-bam: dma at f9984000 = {
> > +		compatible = "qcom,bam-v1.4.1";
> > +		reg = <0xf9984000 0x15000>;
> > +		interrupts = <0 94 0>;
> > +		clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> > +		clock-names = "bam_clk";
> > +		#dma-cells = <2>;
> > +		qcom,ee = <0>;
> > +	};
> > +
> > +Client:
> > +Required properties:
> > +- dmas: List of dma channel requests
> > +- dma-names: Names of aforementioned requested channels
> > +
> > +Clients must use the format described in the dma.txt file, using a three cell
> > +specifier for each channel.
> > +
> > +The three cells in order are:
> > +  1. A phandle pointing to the DMA controller
> > +  2. The channel number
> > +  3. Direction of the fixed unidirectional channel
> > +     0 - Memory to Device
> > +     1 - Device to Memory
> > +     2 - Device to Device
> > +
> 
> Why does the direction needs to be specified in specifier? I see two
> options, either the direction per is fixed in hardware. In that case the DMA
> controller node should describe which channel is which direction. Or the
> direction is not fixed in hardware and can be changed at runtime in which
> case it should be set on a per descriptor basis.
> 

It is specified because the direction is physically set by the hardware.  And
this can change depending on the attached peripheral.  It probably does make
more sense to set the direction in the controller.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
