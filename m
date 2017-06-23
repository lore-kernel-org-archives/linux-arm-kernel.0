From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 13:08:43 -0700
Subject: [PATCH 4/5] dt-bindings: Document MIPS Broadcom STB power
 management nodes
In-Reply-To: <20170623200229.p6pp4g2hvkei4doj@rob-hp-laptop>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
 <20170616213703.21487-5-f.fainelli@gmail.com>
 <20170623200229.p6pp4g2hvkei4doj@rob-hp-laptop>
Message-ID: <e21d2356-4096-a53c-2d55-7f3b8f09ff0a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2017 01:02 PM, Rob Herring wrote:
> On Fri, Jun 16, 2017 at 02:37:02PM -0700, Florian Fainelli wrote:
>> Document the different nodes required for supporting S2/S3/S5 suspend
>> states on MIPS-based Broadcom STB SoCs.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../devicetree/bindings/mips/brcm/soc.txt          | 77 ++++++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> index e4e1cd91fb1f..f7413168d938 100644
>> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> @@ -11,3 +11,80 @@ Required properties:
>>  
>>  The experimental -viper variants are for running Linux on the 3384's
>>  BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
>> +
>> +Power management
>> +----------------
>> +
>> +For power management (particularly, S2/S3/S5 system suspend), the following SoC
>> +components are needed:
>> +
>> += Always-On control block (AON CTRL)
>> +
>> +This hardware provides control registers for the "always-on" (even in low-power
>> +modes) hardware, such as the Power Management State Machine (PMSM).
>> +
>> +Required properties:
>> +- compatible     : should contain "brcm,brcmstb-aon-ctrl"
> 
> Exact same block on all SoCs?

Not quite exactly the same, I will put something more SoC-specific in
the binding here.

> 
>> +- reg            : the register start and length for the AON CTRL block
>> +
>> +Example:
>> +
>> +aon-ctrl at 410000 {
> 
> syscon at ...
> 
>> +	compatible = "brcm,brcmstb-aon-ctrl";
>> +	reg = <0x410000 0x400>;
>> +};
>> +
>> += Memory controllers
>> +
>> +A Broadcom STB SoC typically has a number of independent memory controllers,
>> +each of which may have several associated hardware blocks, which are versioned
>> +independently (control registers, DDR PHYs, etc.). One might consider
>> +describing these controllers as a parent "memory controllers" block, which
>> +contains N sub-nodes (one for each controller in the system), each of which is
>> +associated with a number of hardware register resources (e.g., its PHY). See
>> +the example device tree snippet below.
> 
> What example?

Whoops, that's indeed missing.

> 
>> +
>> +== MEMC (MEMory Controller)
>> +
>> +Represents a single memory controller instance.
>> +
>> +Required properties:
>> +- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"
> 
> No registers for the controller?

There are indeed registers, thanks for catching that.

> 
>> +
>> +Should contain subnodes for any of the following relevant hardware resources:
>> +
>> +== DDR PHY control
>> +
>> +Control registers for this memory controller's DDR PHY.
>> +
>> +Required properties:
>> +- compatible     : should contain one of these
>> +	"brcm,brcmstb-ddr-phy-v64.5"
>> +	"brcm,brcmstb-ddr-phy"
>> +
>> +- reg            : the DDR PHY register range
>> +
>> +== MEMC Arbiter
>> +
>> +The memory controller arbiter is responsible for memory clients allocation
>> +(bandwidth, priorities etc.) and needs to have its contents restored during
>> +deep sleep states (S3).
>> +
>> +Required properties:
>> +
>> +- compatible	: should contain one of these
>> +	"brcm,brcmstb-memc-arb-v10.0.0.0"
>> +	"brcm,brcmstb-memc-arb"
>> +
>> +- reg		: the DDR Arbiter register range
>> +
>> +== Timers
>> +
>> +The Broadcom STB chips contain a timer block with several general purpose
>> +timers that can be used.
>> +
>> +Required properties:
>> +
>> +- compatible	: should contain "brcm,brcmstb-timers"
>> +- reg		: the timers register range
>> +
>> -- 
>> 2.9.3
>>


-- 
Florian
