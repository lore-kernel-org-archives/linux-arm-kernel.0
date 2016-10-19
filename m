From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 19 Oct 2016 10:38:20 +0800
Subject: [PATCH 2/3] clk: hisilicon: add CRG driver for Hi3516CV300 SoC
In-Reply-To: <20161018155835.qyoffwznacdac46y@rob-hp-laptop>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-3-wenpan@hisilicon.com>
 <20161018155835.qyoffwznacdac46y@rob-hp-laptop>
Message-ID: <7ce2e35b-19e1-9493-90a7-15b321fee2cc@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/10/18 23:58, Rob Herring ??:
> On Mon, Oct 17, 2016 at 08:07:04PM +0800, Pan Wen wrote:
>> Add CRG driver for Hi3516CV300 SoC. CRG(Clock and Reset
>> Generator) module generates clock and reset signals used
>> by other module blocks on SoC.
>>
>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>> ---
>>  .../devicetree/bindings/clock/hisi-crg.txt         |  50 ++++
>>  drivers/clk/hisilicon/Kconfig                      |   8 +
>>  drivers/clk/hisilicon/Makefile                     |   1 +
>>  drivers/clk/hisilicon/crg-hi3516cv300.c            | 330 +++++++++++++++++++++
>>  drivers/clk/hisilicon/crg.h                        |  34 +++
>>  include/dt-bindings/clock/hi3516cv300-clock.h      |  48 +++
>>  6 files changed, 471 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hisi-crg.txt
>>  create mode 100644 drivers/clk/hisilicon/crg-hi3516cv300.c
>>  create mode 100644 drivers/clk/hisilicon/crg.h
>>  create mode 100644 include/dt-bindings/clock/hi3516cv300-clock.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>> new file mode 100644
>> index 0000000..cc60b3d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>> @@ -0,0 +1,50 @@
>> +* HiSilicon Clock and Reset Generator(CRG)
> 
> Seems kind of generic given there's already various HiSi clock bindings 
> documented.
> 
>> +
>> +The CRG module provides clock and reset signals to various
>> +modules within the SoC.
>> +
>> +This binding uses the following bindings:
>> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +    Documentation/devicetree/bindings/reset/reset.txt
>> +
>> +Required Properties:
>> +
>> +- compatible: should be one of the following.
>> +  - "hisilicon,hi3516cv300-crg"
>> +  - "hisilicon,hi3516cv300-sysctrl"
>> +  - "hisilicon,hi3519-crg"
> 
> There is already a binding for this. Please merge them.
> 
Hi Rob,

Pan Wen and I work together. There's really a same file included in the patch
https://lkml.org/lkml/2016/9/18/42 ([PATCH v2] clk: hisilicon: add CRG driver for Hi3798CV200 SoC).
But that patch has not been acked. This binding file will be merged if that
patch is accepted first. Could you give me more comments on that patch or
help me to ack it?  Thank you very much.

Regards,
Jiancheng


>> +  - "hisilicon,hi3798cv200-crg"
>> +  - "hisilicon,hi3798cv200-sysctrl"
>> +
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +
>> +- #clock-cells: should be 1.
>> +
>> +Each clock is assigned an identifier and client nodes use this identifier
>> +to specify the clock which they consume.
>> +
>> +All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
>> +
>> +- #reset-cells: should be 2.
>> +
>> +A reset signal can be controlled by writing a bit register in the CRG module.
>> +The reset specifier consists of two cells. The first cell represents the
>> +register offset relative to the base address. The second cell represents the
>> +bit index in the register.
>> +
>> +Example: CRG nodes
>> +CRG: clock-reset-controller at 12010000 {
>> +	compatible = "hisilicon,hi3519-crg";
>> +	reg = <0x12010000 0x10000>;
>> +	#clock-cells = <1>;
>> +	#reset-cells = <2>;
>> +};
>> +
>> +Example: consumer nodes
>> +i2c0: i2c at 12110000 {
>> +	compatible = "hisilicon,hi3519-i2c";
>> +	reg = <0x12110000 0x1000>;
>> +	clocks = <&CRG HI3519_I2C0_RST>;
>> +	resets = <&CRG 0xe4 0>;
>> +};
> 
> .
> 
