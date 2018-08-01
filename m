From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 1 Aug 2018 10:40:51 +0200
Subject: [PATCH 2/2] dt-bindings: clock: Add bindings for the Clocking
 Wizard IP
In-Reply-To: <20180801103750.4f06150c@bbrezillon>
References: <20180801081950.10497-1-boris.brezillon@bootlin.com>
 <20180801081950.10497-2-boris.brezillon@bootlin.com>
 <a8620c93-cf99-719d-d2bb-7d0f0b567130@xilinx.com>
 <20180801103404.4b9135dc@bbrezillon> <20180801103750.4f06150c@bbrezillon>
Message-ID: <3a46704b-9cd8-021d-e527-7866ceb04e2f@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1.8.2018 10:37, Boris Brezillon wrote:
> On Wed, 1 Aug 2018 10:34:04 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> Hi Michal,
>>
>> On Wed, 1 Aug 2018 10:26:11 +0200
>> Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>> Hi Boris,
>>>
>>> On 1.8.2018 10:19, Boris Brezillon wrote:  
>>>> Document Xilinx Clocking Wizard bindings.
>>>>
>>>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>>> ---
>>>>  .../devicetree/bindings/clock/xlnx,clk-wizard.txt  | 28 ++++++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt b/Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt
>>>> new file mode 100644
>>>> index 000000000000..1bf7a764f4a9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt
>>>> @@ -0,0 +1,28 @@
>>>> +Device Tree Clock bindings for the "Clocking Wizard" IP provided by Xilinx
>>>> +
>>>> +This block can be used to generate up to 4 clock signals out of a single input
>>>> +clock. It embeds a PLL to generate an intermediate clock which then feeds 4
>>>> +clock dividers whose divider value can be adjusted based on the user needs.
>>>> +
>>>> +Required properties:
>>>> + - #clock-cells: must be 1. The cell is encoding the id of the output clk
>>>> +		 (from 0 to xlnx,clk-wizard-num-outputs - 1)
>>>> + - compatible: must be "xlnx,clk-wizard-5.1"
>>>> + - clocks: 2 clocks are required
>>>> + - clock-names: should contain 2 clock names: "aclk" and "clkin".
>>>> +		"aclk" is driving the register interface and "clk_in" is the
>>>> +		input clock signal that is used by the PLL block
>>>> + - xlnx,clk-wizard-num-outputs: this describe the number of output clocks
>>>> +				(chosen at synthesization time)
>>>> + - reg: registers used to configure the Clocking wizard block
>>>> +
>>>> +Example:
>>>> +
>>>> +	clkwizard: clkwizard at 43c20000 {
>>>> +		compatible = "xlnx,clk-wizard-5.1";
>>>> +		reg = <0x43c20000 0x10000>;
>>>> +		clocks = <&clkc 18>, <&clkc 18>;
>>>> +		clock-names = "aclk", "clk_in1";
>>>> +		#clock-cells = <1>;
>>>> +		xlnx,clk-wizard-num-outputs = <2>;
>>>> +	};
>>>>     
>>>
>>> First of all this should be 1/2.  
>>
>> Hm, okay. Didn't know the order was important.
>>
>>>
>>> The second is that this driver is already in staging area
>>> (drivers/staging/clocking-wizard) for a while. That's why please use
>>> this driver or send patches on the top of this.  
>>
>> Crap! I didn't look in staging. BTW, any reason this driver is in
>> staging?
> 
> Nevermind, it's described in the TODO file. Looks like I'll need to add
> clk-phase ops for my use case.

Please check https://github.com/Xilinx/linux-xlnx
and IIRC the use case which is not supported and should be is that
clocking-wizard itself can be configured to fixed configuration without
register access. But it is questionable if this can be done by current
fixed-factor-clock or not.
But maybe there was something else too.

Thanks,
Michal
