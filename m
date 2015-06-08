From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 08 Jun 2015 09:53:30 +0300
Subject: [PATCH 00/13] arm64: KVM: GICv3 ITS emulation
In-Reply-To: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
Message-ID: <01ad01d0a1b7$d4d4fe40$7e7efac0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello everybody!

> The GICv3 ITS (Interrupt Translation Service) is a part of the
> ARM GICv3 interrupt controller used for implementing MSIs.
> It specifies a new kind of interrupts (LPIs), which are mapped to
> establish a connection between a device, its MSI payload value and
> the target processor the IRQ is eventually delivered to.
> In order to allow using MSIs in an ARM64 KVM guest, we emulate this
> ITS widget in the kernel.

 I have tested the patch and got some more ideas for future extension...

 First of all, it would be nice to have a possibility to directly inject LPIs by number.
This will be useful for irqfd support in qemu.
 Next, irqfd support currently poses a problem. We need to somehow know IRQ number from
MSI-X data (device ID plus event ID). ITS has all this information, so it would be nice to
be able to query for the translation from within userspace. The question is - how to do
it? Should we add some ioctl for this purpose? Currently i am experimenting with extra
KVM_TRANSLATE_MSI ioctl which, given MSI data, would return LPI number.
 Actually before your patch came out i have almost done the same thing. But instead i
decided to implement ITS in qemu while leaving LPI handling to kernel. In this case my
qemu would have everything needed.
 By the way, why did you decide to put everything into kernel? Yes, in-kernel emulation is
faster, but ITS is not accessed frequently.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
