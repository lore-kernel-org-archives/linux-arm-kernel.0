From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Tue, 25 Jul 2017 18:27:05 +0800
Subject: [PATCH V2 02/10] dt-bindings: Add Spreadtrum clock binding
 documentation
In-Reply-To: <20170721225729.GB2146@codeaurora.org>
References: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
 <20170711105627.20526-3-chunyan.zhang@spreadtrum.com>
 <20170721225729.GB2146@codeaurora.org>
Message-ID: <CAAfSe-v9sv90WZLJsBUB_S3pLXsjM4z31YBs=xxY1Ak0bXkMDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 22 July 2017 at 06:57, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/11, Chunyan Zhang wrote:
>> Introduce a new binding with its documentation for Spreadtrum clock
>> sub-framework.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  Documentation/devicetree/bindings/clock/sprd.txt | 36 ++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd.txt
>> new file mode 100644
>> index 0000000..c6f3abf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sprd.txt
>> @@ -0,0 +1,36 @@
>> +Spreadtrum Clock Binding
>> +------------------------
>> +
>> +Required properties:
>> +- compatible: must contain the following compatible:
>> +     - "sprd,sc9860-clk" (only support SC9860 for the time being)
>> +
>> +- reg:       Must contain the registers base address and length.
>> +     Clocks on most of Spreadtrum's SoCs were designed to locate in a few
>> +     different address areas, so there would be more than one items under
>> +     this property.
>> +
>> +- #clock-cells: must be 1
>> +
>> +Example:
>> +
>> +clk: clk {
>
> clock-controller for the node name?

Ah, sorry I forgot to address this.

>
>> +     compatible = "sprd,sc9860-clk";
>> +     #clock-cells = <1>;
>> +     reg = <0 0x20000000 0 0x400>,
>> +           <0 0x20210000 0 0x3000>,
>> +           <0 0x402b0000 0 0x4000>,
>> +           <0 0x402d0000 0 0x400>,
>> +           <0 0x402e0000 0 0x4000>,
>> +           <0 0x40400000 0 0x400>,
>> +           <0 0x40880000 0 0x400>,
>> +           <0 0x415e0000 0 0x400>,
>> +           <0 0x60200000 0 0x400>,
>> +           <0 0x61000000 0 0x400>,
>> +           <0 0x61100000 0 0x3000>,
>> +           <0 0x62000000 0 0x4000>,
>> +           <0 0x62100000 0 0x4000>,
>> +           <0 0x63000000 0 0x400>,
>> +           <0 0x63100000 0 0x3000>,
>> +           <0 0x70b00000 0 0x3000>;
>
> I'm still suspecting that we need multiple nodes, for each device
> the clocks are embedded in. Mediatek SoCs have a similar design,
> and they have many nodes. Does it happen to always be in some
> fixed offset inside the different devices that use the clks?

Unfortunately clock design on SC9860 is not the case.

>From the device tree file [1] which we're using internally, we can see
there're 9 ranges of clocks are located on the same address area with
syscons, they respectively are:
        <0 0x20210000 0 0x3000>,
        <0 0x402b0000 0 0x4000>,
        <0 0x402e0000 0 0x4000>,
        <0 0x40400000 0 0x400>,
        <0 0x415e0000 0 0x400>,
        <0 0x61100000 0 0x3000>,
        <0 0x62100000 0 0x4000>,
        <0 0x63100000 0 0x3000>,
        <0 0x70b00000 0 0x3000>;

others ranges (listed below) are only for clocks, neither same with
any devices nor syscons:

        <0 0x20000000 0 0x400>,  is for AP (application processor) clocks
        <0 0x402d0000 0 0x400>,  is for AON prediv clocks
        <0 0x40880000 0 0x400>,
        <0 0x60200000 0 0x400>,  is for GPU clocks
        <0 0x61000000 0 0x400>,  is for VSP clocks
        <0 0x62000000 0 0x4000>,is for camera clocks
        <0 0x63000000 0 0x400>,  is for display clocks

Let's see dcam as an example.
The dcam device is on 0x6220 0000 [2], while dcam clocks are on 0x6200
0000, and also some dcam clocks are on 0x6210 0000 which is the same
address area with a syscon called 'cam_ahb_controller' [3].

I can separate them into multiple nodes, and then there will be 16
clock nodes in dt, isn't it too much?

Which solution do you think is better for our case?


Thanks,
Chunyan


[1] https://github.com/sprdlinux/kernel/blob/sp9860g-1h10/arch/arm64/boot/dts/sprd/whale.dtsi#L29
[2] https://github.com/sprdlinux/kernel/blob/sp9860g-1h10/arch/arm64/boot/dts/sprd/sc9850s.dtsi#L372
[3] https://github.com/sprdlinux/kernel/blob/sp9860g-1h10/arch/arm64/boot/dts/sprd/whale.dtsi#L71

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
