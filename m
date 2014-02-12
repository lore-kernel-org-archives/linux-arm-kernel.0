From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 12:39:41 -0700
Subject: [PATCH] ARM: tegra: dalmore: fix irq trigger type
In-Reply-To: <30f0db808e7543d9ab6b077aa5e239f2@agner.ch>
References: <4fcfcfdbc86c37c6d47ec32cdbd987f3b406e9b5.1392147256.git.stefan@agner.ch>
 <20140211204737.GA1895@mithrandir>
 <30f0db808e7543d9ab6b077aa5e239f2@agner.ch>
Message-ID: <52FBCDFD.1040902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 02:21 PM, Stefan Agner wrote:
> Am 2014-02-11 21:47, schrieb Thierry Reding:
>> On Tue, Feb 11, 2014 at 09:11:32PM +0100, Stefan Agner wrote:
>>> Trigger type needs to be IRQ_TYPE_LEVEL_HIGH since the interrupt
>>> signal gets inverted by the PMC (configured by the invert-interrupt
>>> property).
>>
>> Isn't the reason the other way around? The PMIC generates a low-level
>> interrupt, but the GIC can only be configured to accept high-level (or
>> rising edge) and therefore the nvidia,invert-interrupt property needs to
>> be set in the PMC node?
> Hm yes agreed. I should also write the whole story here, maybe this:
> 
> The GIC only support high-active interrupts. When using a PMIC with
> low-active interrupt, the PMC has to be configured by using the
> nvidia,invert-interrupt property in its node.
> 
> This fix sets the GIC back to high-active and reverts commit
> eca8f98e404934027f84f72882c5e92ffbd9e5f5.

(Trimming CC lists)

Stefan,

It'd be best to include the commit subject rather than just the commit
hash, i.e.:

... and reverts commit eca8f98e4049 "ARM: tegra: dalmore: fix the irq
trigger type of Palmas MFD device".

It may also be helpful for the commit description to quote the kernel
boot message which this patch solves:

> [    0.215178] genirq: Setting trigger mode 8 for irq 118 failed (gic_set_type+0x0/0xf4)

For me, applying this patch actually *causes* an interrupt storm, rather
than preventing one. Yet without it, no interrupts occur at all. I
wonder if the driver has a bug where it's not correctly clearing all
interrupt status (e.g. something pre-existing before boot), so once the
polarity is set up correctly, the interrupt is stuck?

Joseph,

As the author of the patch that's being reverted, can you please comment
here?
