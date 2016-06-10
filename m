From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 10 Jun 2016 09:50:08 -0700
Subject: [PATCH v3 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <20160610082324.2a0967b0@arm.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
 <5759B143.9070503@caviumnetworks.com> <5759DA3A.4070905@gmail.com>
 <20160610082324.2a0967b0@arm.com>
Message-ID: <575AEFC0.1070304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2016 12:23 AM, Marc Zyngier wrote:
> On Thu, 09 Jun 2016 14:06:02 -0700
> David Daney <ddaney.cavm@gmail.com> wrote:
>
>> I spoke too soon...
>>
>> On 06/09/2016 11:11 AM, David Daney wrote:
>>> On 06/06/2016 10:56 AM, Marc Zyngier wrote:
>>>> The ARM architected timer specification mandates that the interrupt
>>>> associated with each timer is level triggered (which corresponds to
>>>> the "counter >= comparator" condition).
>>>>
>>>> A number of DTs are being remarkably creative, declaring the interrupt
>>>> to be edge triggered. A quick look at the TRM for the corresponding ARM
>>>> CPUs clearly shows that this is wrong, and I've corrected those.
>>>> For non-ARM designs (and in the absence of a publicly available TRM),
>>>> I've made them active low as well, which can't be completely wrong
>>>> as the GIC cannot disinguish between level low and level high.
>>>>
>>>> The respective maintainers are of course welcome to prove me wrong.
>>>>
>>>> While I was at it, I took the liberty to fix a couple of related issue,
>>>> such as some spurious affinity bits on ThunderX, and their complete
>>>> absence on ls1043a (both of which seem to be related to copy-pasting
>>>> from other DTs).
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 8 ++++----
>>>>    arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 8 ++++----
>>>>    arch/arm64/boot/dts/apm/apm-storm.dtsi               | 8 ++++----
>>>>    arch/arm64/boot/dts/broadcom/ns2.dtsi                | 8 ++++----
>>>>    arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 8 ++++----
>>>>    arch/arm64/boot/dts/exynos/exynos7.dtsi              | 8 ++++----
>>>>    arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 8 ++++----
>>>>    arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 8 ++++----
>>>>    arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----
>>>>    arch/arm64/boot/dts/xilinx/zynqmp.dtsi               | 8 ++++----
>>>>    10 files changed, 40 insertions(+), 40 deletions(-)
>>>>
>>> [...]
>>>> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>>>> b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>>>> index 2eb9b22..382d86f 100644
>>>> --- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>>>> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
>>>> @@ -354,10 +354,10 @@
>>>>
>>>>        timer {
>>>>            compatible = "arm,armv8-timer";
>>>> -        interrupts = <1 13 0xff01>,
>>>> -                     <1 14 0xff01>,
>>>> -                     <1 11 0xff01>,
>>>> -                     <1 10 0xff01>;
>>>> +        interrupts = <1 13 8>,
>>>> +                     <1 14 8>,
>>>> +                     <1 11 8>,
>>>> +                     <1 10 8>;
>>
>>
>> NAK!
>>
>> According to arm,gic-v3.txt the trigger value must be either 1 or 4:
>>
>>     The 3rd cell is the flags, encoded as follows:
>>           bits[3:0] trigger type and level flags.
>>                   1 = edge triggered
>>                   4 = level triggered
>
> Which is a bug in the binding description. PPIs can be any trigger
> (just look at the TRM for CPUs that have devices connected to a PPI to
> be convinced - most of them are level low).
>
> This doesn't mean that you can distinguish level-high from level-low
> in a programmatic way. But the HW definitely can handle it.
>
> I'll update the GICv3 binding to reflect this.
>
> Now, coming back to your NAK: is level-low the right or wrong trigger
> for your implementation of the architected timers?
>

For the Cavium Thunder implementation of GIC-v3, there is no concept of 
high and low.  All we have is asserted and not-asserted, we have chosen 
to map the concept of an asserted level-triggered source to 
IRQ_TYPE_LEVEL_HIGH, and the transition from not-asserted to asserted on 
an edge triggered source to IRQ_TYPE_EDGE_RISING.

Looking and the code and specifications, I don't see in irq-gic-v3.c or 
PRD03-GENC-010745-35 any indication that the concepts of "high" and 
"low" exist either, although I certainly could have missed something.

David Daney
