From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 09 Jun 2015 10:12:30 +0200
Subject: [PATCH 00/13] arm64: KVM: GICv3 ITS emulation
In-Reply-To: <02ae01d0a1d9$732d2ce0$598786a0$@samsung.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <01ad01d0a1b7$d4d4fe40$7e7efac0$@samsung.com> <557550F0.5070106@arm.com>
 <02ae01d0a1d9$732d2ce0$598786a0$@samsung.com>
Message-ID: <55769FEE.70607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 12:54 PM, Pavel Fedin wrote:
>  Hi!
> 
>> I'm afraid this is not enough. A write to GICR_TRANSLATER (DID+EID)
>> results in a (LPI,CPU) pair. Can you easily express the CPU part in
>> irqfd (this is a genuine question, I'm not familiar enough with that
>> part of the core)?

Currently on ARM, irqfd supports routing an host eventfd towards a
virtual SPI:
eventfd -> vSPI = gsi+32
parameters of irqfd are the eventfd and the gsi.

We do not implement KVM IRQ routing yet. This IRQ routing supports 2 modes:
1) irqchip routing: eventfd -> virtual gsi -> virtual irqchip.input pin
2) msi routing: eventfd -> virtual gsi -> virtual msi (@, data)

1) up to now we had a single virtual irqchip, vgicv2 or vgicv3 (no apic
as in x86, ...) so irqchip routing did not sound to be helpful
2) now we have virtual msi injection, we could use msi routing to inject
virtual LPI's. But is it what you need for your qemu integration?

Currently on QEMU side for VIRTIO-PCI with vhost back-end + GICv2m +
irqfd, so called kvm_gsi_direct_mapping is used:
the MSI data is extracted from the PCI virtio device MSI vector, the
virtual gsi = MSI data - 32 and eventually irqfd is programmed with the
eventfd and the gsi. That way MSI injection on guest is bypassed in
irqfd mode.

Please let us know

Best Regards

Eric
> 
>  But... As far as i could understand, LPI is added to a collection as a part of setup. And
> collection actually represents a destination CPU, doesn't it? And we can't have multiple
> LPIs sharing the same number and going to different CPUs. Or am i wrong? Unfortunately i
> don't have GICv3 arch reference manual.
> 
>> Another concern
>> would be the support of GICv4, which relies on the command queue
>> handling to be handled in the kernel
> 
>  Wow, i didn't know about GICv4.
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
