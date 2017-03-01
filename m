From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 28 Feb 2017 16:00:52 -0800
Subject: [PATCH v4 01/36] [media] dt-bindings: Add bindings for i.MX media
 driver
In-Reply-To: <20170227143823.25oxk72jul3ldvpb@rob-hp-laptop>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-2-git-send-email-steve_longerbeam@mentor.com>
 <20170227143823.25oxk72jul3ldvpb@rob-hp-laptop>
Message-ID: <22ce523a-9553-d353-e271-fe47728bd650@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


On 02/27/2017 06:38 AM, Rob Herring wrote:
> On Wed, Feb 15, 2017 at 06:19:03PM -0800, Steve Longerbeam wrote:
>> Add bindings documentation for the i.MX media driver.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> ---
>>   Documentation/devicetree/bindings/media/imx.txt | 66 +++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/imx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/imx.txt b/Documentation/devicetree/bindings/media/imx.txt
>> new file mode 100644
>> index 0000000..fd5af50
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/imx.txt
>> @@ -0,0 +1,66 @@
>> +Freescale i.MX Media Video Device
>> +=================================
>> +
>> +Video Media Controller node
>> +---------------------------
>> +
>> +This is the media controller node for video capture support. It is a
>> +virtual device that lists the camera serial interface nodes that the
>> +media device will control.
>> +
>> +Required properties:
>> +- compatible : "fsl,imx-capture-subsystem";
>> +- ports      : Should contain a list of phandles pointing to camera
>> +		sensor interface ports of IPU devices
>> +
>> +example:
>> +
>> +capture-subsystem {
>> +	compatible = "fsl,capture-subsystem";
>> +	ports = <&ipu1_csi0>, <&ipu1_csi1>;
>> +};
>> +
>> +fim child node
>> +--------------
>> +
>> +This is an optional child node of the ipu_csi port nodes. If present and
>> +available, it enables the Frame Interval Monitor. Its properties can be
>> +used to modify the method in which the FIM measures frame intervals.
>> +Refer to Documentation/media/v4l-drivers/imx.rst for more info on the
>> +Frame Interval Monitor.
> This should have a compatible string.

I don't think so. The fim child node does not represent a device. The
CSI supports monitoring frame intervals (reporting via a v4l2 event
when a measured frame interval falls outside the nominal interval
by some tolerance value). The fim child node is only to group properties
for the FIM under a common child node.

>> +
>> +Optional properties:
>> +- fsl,input-capture-channel: an input capture channel and channel flags,
>> +			     specified as <chan flags>. The channel number
>> +			     must be 0 or 1. The flags can be
>> +			     IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING, or
>> +			     IRQ_TYPE_EDGE_BOTH, and specify which input
>> +			     capture signal edge will trigger the input
>> +			     capture event. If an input capture channel is
>> +			     specified, the FIM will use this method to
>> +			     measure frame intervals instead of via the EOF
>> +			     interrupt. The input capture method is much
>> +			     preferred over EOF as it is not subject to
>> +			     interrupt latency errors. However it requires
>> +			     routing the VSYNC or FIELD output signals of
>> +			     the camera sensor to one of the i.MX input
>> +			     capture pads (SD1_DAT0, SD1_DAT1), which also
>> +			     gives up support for SD1.
>> +
>> +
>> +mipi_csi2 node
>> +--------------
>> +
>> +This is the device node for the MIPI CSI-2 Receiver, required for MIPI
>> +CSI-2 sensors.
>> +
>> +Required properties:
>> +- compatible	: "fsl,imx6-mipi-csi2", "snps,dw-mipi-csi2";
>> +- reg           : physical base address and length of the register set;
>> +- clocks	: the MIPI CSI-2 receiver requires three clocks: hsi_tx
>> +                  (the DPHY clock), video_27m, and eim_podf;
>> +- clock-names	: must contain "dphy", "cfg", "pix";
> Don't you need ports to describe the sensor and IPU connections?

Done.

Steve
