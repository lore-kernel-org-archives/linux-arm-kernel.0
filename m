From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Tue, 7 Nov 2017 15:01:09 +0800
Subject: [PATCH V3 02/11] dt-bindings: Add Spreadtrum clock binding
 documentation
In-Reply-To: <20171106171519.xomnca72adqtzm2n@rob-hp-laptop>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
 <20171102065626.21835-3-chunyan.zhang@spreadtrum.com>
 <20171106171519.xomnca72adqtzm2n@rob-hp-laptop>
Message-ID: <CAAfSe-s=uF6j2T2cePbAT3q4BxY6RcvktwZVs+PjnkQYozvrWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 7 November 2017 at 01:15, Rob Herring <robh@kernel.org> wrote:
> On Thu, Nov 02, 2017 at 02:56:17PM +0800, Chunyan Zhang wrote:
>> Introduce a new binding with its documentation for Spreadtrum clock
>> sub-framework.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  Documentation/devicetree/bindings/clock/sprd.txt | 55 ++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd.txt
>> new file mode 100644
>> index 0000000..5c09529
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sprd.txt
>> @@ -0,0 +1,55 @@
>> +Spreadtrum Clock Binding
>> +------------------------
>> +
>> +Required properties:
>> +- compatible: should contain the following compatible strings:
>> +     - "sprd,sc9860-pmu-gate"
>> +     - "sprd,sc9860-pll"
>> +     - "sprd,sc9860-ap-clk"
>> +     - "sprd,sc9860-aon-prediv"
>> +     - "sprd,sc9860-apahb-gate"
>> +     - "sprd,sc9860-aon-gate"
>> +     - "sprd,sc9860-aonsecure-clk"
>> +     - "sprd,sc9860-agcp-gate"
>> +     - "sprd,sc9860-gpu-clk"
>> +     - "sprd,sc9860-vsp-clk"
>> +     - "sprd,sc9860-vsp-gate"
>> +     - "sprd,sc9860-cam-clk"
>> +     - "sprd,sc9860-cam-gate"
>> +     - "sprd,sc9860-disp-clk"
>> +     - "sprd,sc9860-disp-gate"
>> +     - "sprd,sc9860-apapb-gate"
>> +
>> +- #clock-cells: must be 1
>> +
>> +- clocks : shall be the input parent clock(s) phandle for the clock.
>
> You need to document how many clocks for each block.

It depends, "clocks" property here just simply shows which clock group
the clock's parents are in.
The detailed dependency relationship (i.e. how many parents and which
are the parents) are implemented in driver code.

Ok, I should address more, will do in the next version.

>
>> +
>> +Optional properties:
>> +
>> +- reg:       Contain the registers base address and length. It must be configured only if no 'sprd,syscon' under the node.
>> +
>> +- sprd,syscon: phandle to the syscon which is in the same address area with the clock.
>> +
>> +Example:
>> +
>> +     pmu_gate: pmu-gate {
>> +             compatible = "sprd,sc9860-pmu-gate";
>> +             sprd,syscon = <&pmu_apb>;
>
> Ideally, the pmu-gate node would be a child of pmu_apb and use the reg
> property if clock registers are a contiguous range. Then you don't need
> this phandle.

The pmu-gate is actually a clock independent from the 'pmu_apb' syscon
device, using a reference to syscon node instead of a reg property is
just to avoid mapping the same address areas repeatedly.  Spreadtrum's
clock h/w design is a little complicated, after discussing with Arnd
and Stephen, I then chose to implement in this way.

I guess the name of 'pmu_apb' might be confused, it's actually not a
bus, but a global address area stored a lot of registers shared by a
few devices including some clocks.  I think I'd better use another
name instead of pmu_apb :)

Please let me know if I'm missing something here.

Thanks,
Chunyan

>
>> +             clocks = <&ext_26m>;
>> +             #clock-cells = <1>;
>> +     };
>> +
>> +     pll: pll {
>> +             compatible = "sprd,sc9860-pll";
>> +             sprd,syscon = <&ana_apb>;
>
> Same here.
>
>> +             clocks = <&pmu_gate 0>;
>> +             #clock-cells = <1>;
>> +     };
>> +
>> +     ap_clk: clock-controller at 20000000 {
>> +             compatible = "sprd,sc9860-ap-clk";
>> +             reg = <0 0x20000000 0 0x400>;
>> +             clocks = <&ext_26m>, <&pll 0>,
>> +                      <&pmu_gate 0>;
>> +             #clock-cells = <1>;
>> +     };
>> --
>> 2.7.4
>>
