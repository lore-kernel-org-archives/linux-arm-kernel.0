From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jan 2012 09:42:49 -0600
Subject: [PATCH 04/15] ARM: smp_twd: add device tree support
In-Reply-To: <4F0EEFEA.1020305@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-5-git-send-email-marc.zyngier@arm.com>
 <4F0DF9B3.3080804@gmail.com> <4F0EEFEA.1020305@arm.com>
Message-ID: <4F0EFF79.8060606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2012 08:36 AM, Marc Zyngier wrote:
> Hi Rob,
> 
> On 11/01/12 21:05, Rob Herring wrote:
>> On 01/11/2012 07:08 AM, Marc Zyngier wrote:
>>> Add bindings to support DT discovery of the ARM Timer Watchdog
>>> (aka TWD). Only the timer side is converted by this patch.
>>>
>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/twd.txt |   29 +++++++++++
>>>  arch/arm/include/asm/smp_twd.h                |    1 +
>>>  arch/arm/kernel/smp_twd.c                     |   68 ++++++++++++++++++++-----
>>>  3 files changed, 85 insertions(+), 13 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
>>> new file mode 100644
>>> index 0000000..a9d5587
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/twd.txt
>>> @@ -0,0 +1,29 @@
>>> +* ARM Timer Watchdog
>>> +
>>> +ARM 11MP, Cortex-A5 and Cortex-A9 are often associated with a per-core
>>> +Timer-Watchdog (aka TWD), which provides both a per-cpu local timer
>>> +and watchdog.
>>> +
>>> +The TWD is usually attached to a GIC to deliver its two per-processor
>>> +interrupts.
>>> +
>>> +Main node required properties:
>>> +
>>> +- compatible : Should be one of:
>>> +	"arm,cortex-a9-twd"
>>> +	"arm,cortex-a5-twd"
>>> +	"arm,arm11mp-twd"
>>> +	"arm,smp-twd"
>>> +
>>> +- interrupts : Two interrupts to each core, the first one for the
>>> +  timer, the second one for the watchdog.
>>> +
>>> +- reg : Specify the base address and the size of the TWD.
>>> +
>>> +Example:
>>> +
>>> +	twd at 2c000600 {
>>> +		compatible = "arm,arm11mp-twd", "arm,smp-twd";
>>> +		reg = <0x2c000600 0x100>;
>>> +		interrupts = <1 13 0xf01 1 14 0xf01>;
>>> +	};
>>
>> Why not split the watchdog and timer into 2 nodes? It may not matter
>> since there is no driver for the timer. If there was, we would have a
>> problem as you can't match 2 drivers to 1 node.
> 
> Don't we hit the opposite problem - two nodes with the same address?

No, because the timer is at 0x600-0x61f and the watchdog is at
0x620-0x63f. There's no DT requirement on address range start or size.

However, the current watchdog driver includes 0x20 in its register
offsets, so changing the base address would require a change to the
driver (but that shouldn't really influence the decision).

Rob
