From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Wed, 17 Feb 2016 19:46:41 +0800
Subject: [PATCH v4 01/11] drm/hisilicon: Add device tree binding for
 hi6220 display subsystem
In-Reply-To: <56B87156.1040506@codeaurora.org>
References: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
 <1454729098-79807-2-git-send-email-xinliang.liu@linaro.org>
 <56B87156.1040506@codeaurora.org>
Message-ID: <CAGd==07PtSm6RHHUH-i7O8vL4+OQiuhLMvq7GMrAy+V3SfrgGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2016 at 18:43, Archit Taneja <architt@codeaurora.org> wrote:
> Hi,
>
>
> On 02/06/2016 08:54 AM, Xinliang Liu wrote:
>>
>> Add ADE display controller binding doc.
>> Add DesignWare DSI Host Controller v1.20a binding doc.
>>
>> v4:
>> - Describe more specific of clocks and ports.
>> - Fix indentation.
>> v3:
>> - Make ade as the drm master node.
>> - Use assigned-clocks to set clock rate.
>> - Use ports to connect display relavant nodes.
>> v2:
>> - Move dt binding docs to bindings/display/hisilicon directory.
>>
>> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>> ---
>>   .../bindings/display/hisilicon/dw-dsi.txt          | 77
>> ++++++++++++++++++++++
>>   .../bindings/display/hisilicon/hisi-ade.txt        | 69
>> +++++++++++++++++++
>>   2 files changed, 146 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
>>   create mode 100644
>> Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
>> b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
>> new file mode 100644
>> index 000000000000..af6d702f3282
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
>> @@ -0,0 +1,77 @@
>> +Device-Tree bindings for DesignWare DSI Host Controller v1.20a driver
>> +
>> +A DSI Host Controller resides in the middle of display controller and
>> external
>> +HDMI converter.
>> +
>> +Required properties:
>> +- compatible: value should be "hisilicon,hi6220-dsi".
>> +- reg: physical base address and length of dsi controller's registers.
>> +- clocks: the clocks needed.
>> +- clock-names: the name of the clocks.
>> +- ports: contains DSI controller input and output sub port.
>> +  The input port connects to ADE output port with the reg value "0".
>> +  The output port with the reg value "1", it could connect to panel or
>> +  any other bridge endpoints. And the reg value for bridge endpoint is
>> "0",
>> +  other values for panel endpoint.
>> +  See Documentation/devicetree/bindings/graph.txt for more device graph
>> info.
>> +
>> +A example of HiKey board hi6220 SoC and board specific DT entry:
>> +Example:
>> +
>> +SoC specific:
>> +       dsi: dsi at f4107800 {
>> +               compatible = "hisilicon,hi6220-dsi";
>> +               reg = <0x0 0xf4107800 0x0 0x100>;
>> +               clocks = <&media_ctrl  HI6220_DSI_PCLK>;
>> +               clock-names = "pclk_dsi";
>> +               status = "disabled";
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       /* 0 for input port */
>> +                       port at 0 {
>> +                               reg = <0>;
>> +                               dsi_in: endpoint {
>> +                                       remote-endpoint = <&ade_out>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +
>> +Board specific:
>> +       &dsi {
>> +               status = "ok";
>> +
>> +               ports {
>> +                       /* 1 for output port */
>> +                       port at 1 {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               reg = <1>;
>> +
>> +                               /* 0 for bridge, other value for panel */
>> +                               dsi_out0: endpoint at 0 {
>> +                                       reg = <0>;
>> +                                       remote-endpoint = <&adv7533_in>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       &i2c2 {
>> +               ...
>> +
>> +               adv7533: adv7533 at 39 {
>> +                       ...
>> +
>> +                       port {
>> +                               adv7533_in: endpoint {
>> +                                       remote-endpoint = <&dsi_out0>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> diff --git
>> a/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
>> b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
>> new file mode 100644
>> index 000000000000..1eff5a41b98d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
>> @@ -0,0 +1,69 @@
>> +Device-Tree bindings for hisilicon ADE display controller driver
>> +
>> +ADE (Advanced Display Engine) is the display controller which grab image
>> +data from memory, do composition, do post image processing, generate RGB
>> +timing stream and transfer to DSI.
>> +
>> +Required properties:
>> +- compatible: value should be "hisilicon,hi6220-ade".
>> +- reg: physical base address and length of the controller's registers.
>> +  Three reg ranges are used in ADE driver:
>> +  ADE reg range, value should be "<0x0 0xf4100000 0x0 0x7800>";
>> +  media subsystem reg range, value should be "<0x0 0xf4410000 0x0
>> 0x1000>";
>> +  media subsystem NOC QoS reg range, value should be "<0x0 0xf4520000 0x0
>> +  0x1000>".
>> +- reg-names: name of physical base.Valuse should be "ade_base",
>> "media_base"
>> +  and "media_noc_base".
>
>
> The "media_base" and "media_noc_base" don't really look like a part of the
> ADE subsytem's MMIO region. If we need to configure these registers,
> and currently don't have a driver/api to achieve this, I think it would
> be better off to use syscon, because that'll at least ensure that the
> registers are consistent among multiple drivers that have ioremapped
> these regions. The other possibility would be to keep this out of mainline
> linux until we get drivers that support this in a proper way.
>
> Otherwise, this looks good to me.

yes, The "media_base" and "media_noc_base" is not a part of the
ADE subsytem's MMIO region. Actually belong to media controller MMIO region.
Will use syscon and reset framework to do the same work in v5.
Thanks for pointing out this.

Thanks,
-xinliang


>
> Archit
>
>
>> +- interrupt: the ldi vblank interrupt number used.
>> +- clocks: the clocks needed. Three clocks are used in ADE driver:
>> +  ADE core clock, value should be "<&media_ctrl HI6220_ADE_CORE>";
>> +  ADE pixel clok, value should be "<&media_ctrl HI6220_ADE_PIX_SRC>";
>> +  media NOC QoS clock, value should be "<&media_ctrl HI6220_CODEC_JPEG>".
>> +- clock-names: the name of the clocks. Values should be "clk_ade_core",
>> +  "clk_codec_jpeg" and "clk_ade_pix".
>> +- assigned-clocks: clocks to be assigned rate.
>> +- assigned-clock-rates: clock rates which are assigned to
>> assigned-clocks.
>> +  The rate of <&media_ctrl HI6220_ADE_CORE> could be "360000000" or
>> +  "180000000";
>> +  The rate of <&media_ctrl HI6220_CODEC_JPEG> could be less than
>> "1440000000".
>> +- port: the output port. This contains one endpoint subnode, with its
>> +  remote-endpoint set to the phandle of the connected DSI input endpoint.
>> +  See Documentation/devicetree/bindings/graph.txt for more device graph
>> info.
>> +
>> +Optional properties:
>> +- dma-coherent: Present if dma operations are coherent.
>> +
>> +
>> +A example of HiKey board hi6220 SoC specific DT entry:
>> +Example:
>> +
>> +       ade: ade at f4100000 {
>> +               compatible = "hisilicon,hi6220-ade";
>> +               reg = <0x0 0xf4100000 0x0 0x7800>,
>> +                     <0x0 0xf4410000 0x0 0x1000>,
>> +                     <0x0 0xf4520000 0x0 0x1000>;
>> +               reg-names = "ade_base",
>> +                           "media_base",
>> +                           "media_noc_base";
>> +
>> +               interrupts = <0 115 4>; /* ldi interrupt */
>> +
>> +               clocks = <&media_ctrl HI6220_ADE_CORE>,
>> +                        <&media_ctrl HI6220_CODEC_JPEG>,
>> +                        <&media_ctrl HI6220_ADE_PIX_SRC>;
>> +               /*clock name*/
>> +               clock-names  = "clk_ade_core",
>> +                              "clk_codec_jpeg",
>> +                              "clk_ade_pix";
>> +
>> +               assigned-clocks = <&media_ctrl HI6220_ADE_CORE>,
>> +                       <&media_ctrl HI6220_CODEC_JPEG>;
>> +               assigned-clock-rates = <360000000>, <288000000>;
>> +               dma-coherent;
>> +
>> +               port {
>> +                       ade_out: endpoint {
>> +                               remote-endpoint = <&dsi_in>;
>> +                       };
>> +               };
>> +       };
>>
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
