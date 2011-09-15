From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 15 Sep 2011 14:28:06 +0200
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <20110915102915.GJ6267@n2100.arm.linux.org.uk>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com>
	<20110915102915.GJ6267@n2100.arm.linux.org.uk>
Message-ID: <4E71EF56.3050503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/15/2011 12:29 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 15, 2011 at 12:07:25PM +0200, Cousson, Benoit wrote:
>> On OMAP4 the SoC interrupts external to the MPU (SPI) have an offset of
>> 32. Only the internal PPI are between 0 and 31.
>
> SGIs are 0 to 15, PPIs are 16 to 31, and SPIs are 32+ - that's the
> numbering given to us by the GIC.
>
>> The real HW physical number start at 0, and thus this is that value that
>> should be in the irq binding of the device.
>
> That depends whether you're counting SPI number or whether you're counting
> IRQ number in the GIC interfaces.  SPI0 will be reported to us from the
> GIC as 32, not 0, so to start numbering from 0 (which is already frowned
> upon for many reasons) we'd have to subtract 32 after checking that the
> IRQ is not a SGI nor PPI in the assembly code instead.

The HW specs is obviously counting the IRQ number at the GIC interface.
That offset is not known outside the MPUSS. Please have a look at the 
OMAP4430 TRM p4761 (NDA vM version).
FWIW, the same numbering scheme is used on tegra2.

My proposal is just to handle the addition within the irq_domain_to_irq, 
so I'm not sure to understand your concern.

Regards,
Benoit
