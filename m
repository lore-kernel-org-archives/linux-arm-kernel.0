From: stefan@agner.ch (Stefan Agner)
Date: Tue, 11 Feb 2014 22:21:15 +0100
Subject: [PATCH] ARM: tegra: dalmore: fix irq trigger type
In-Reply-To: <20140211204737.GA1895@mithrandir>
References: <4fcfcfdbc86c37c6d47ec32cdbd987f3b406e9b5.1392147256.git.stefan@agner.ch>
 <20140211204737.GA1895@mithrandir>
Message-ID: <30f0db808e7543d9ab6b077aa5e239f2@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-02-11 21:47, schrieb Thierry Reding:
> On Tue, Feb 11, 2014 at 09:11:32PM +0100, Stefan Agner wrote:
>> Trigger type needs to be IRQ_TYPE_LEVEL_HIGH since the interrupt
>> signal gets inverted by the PMC (configured by the invert-interrupt
>> property).
> 
> Isn't the reason the other way around? The PMIC generates a low-level
> interrupt, but the GIC can only be configured to accept high-level (or
> rising edge) and therefore the nvidia,invert-interrupt property needs to
> be set in the PMC node?
Hm yes agreed. I should also write the whole story here, maybe this:

The GIC only support high-active interrupts. When using a PMIC with
low-active interrupt, the PMC has to be configured by using the
nvidia,invert-interrupt property in its node.

This fix sets the GIC back to high-active and reverts commit
eca8f98e404934027f84f72882c5e92ffbd9e5f5.

> One nitpick below.
> 
>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> [...]
>> @@ -888,8 +888,9 @@
>>  		palmas: tps65913 at 58 {
>>  			compatible = "ti,palmas";
>>  			reg = <0x58>;
>> -			interrupts = <0 86 IRQ_TYPE_LEVEL_LOW>;
>>
>> +			/* active-low configured by PMC invert-interrupt */
>> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> 
> I'd prefer to keep the properties grouped as before. interrupts is a
> "client" property, whereas #interrupt-cells and interrupt-controller
> are "provider" properties.
> 
> And I think the comment would be more appropriate in the pmc node, for
> the same reason that I think the commit description isn't entirely
> accurate.
Well, its kind a question where you are coming from. I read the data
sheet/schemata, and saw that its low-active. Then I went to the PMIC
node and checked how that interrupt is configured, and what you see is
HIGH_ACTIVE. You then think you've found the bug and fix it by setting
it to IRQ_TYPE_LEVEL_LOW. What you don't know is that PMC is in between
and alters the polarity...
