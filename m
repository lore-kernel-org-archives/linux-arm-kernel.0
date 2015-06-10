From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 10 Jun 2015 18:30:13 +0300
Subject: IRQFD support with GICv3 ITS (WAS: RE: [PATCH 00/13] arm64: KVM:
 GICv3 ITS emulation)
In-Reply-To: <557842A0.9070503@linaro.org>
References: <042601d0a357$d3cec4d0$7b6c4e70$@samsung.com>
 <557842A0.9070503@linaro.org>
Message-ID: <05da01d0a392$58bf5030$0a3df090$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi!

> indeed in newly added qemu kvm-all.c kvm_arch_msi_data_to_gsi we could
> call a new ioctl that translates the data + deviceid? into an LPI and
> program irqfd with that LPI. This is done once when setting irqfd up.
> This also means extending irqfd support to lpi injection, gsi being the
> LPI index if gsi >= 8192. in that case we continue using
> kvm_gsi_direct_mapping and gsi still is an IRQ index.

 This is exactly what i have done in my kernel + qemu. I have added a new KVM capability
and then in qemu i do this:
--- cut ---
    if (kvm_gsi_kernel_mapping()) {
        struct kvm_msi msi;

        msi.address_lo = (uint32_t)msg.address;
        msi.address_hi = msg.address >> 32;
        msi.data = le32_to_cpu(msg.data);
        memset(msi.pad, 0, sizeof(msi.pad));

        if (dev) {
            msi.devid = (pci_bus_num(dev->bus) << 8) | dev->devfn;
            msi.flags = KVM_MSI_VALID_DEVID;
        } else {
            msi.devid = 0;
            msi.flags = 0;
        }

        return kvm_vm_ioctl(s, KVM_TRANSLATE_MSI, &msi);
    }
--- cut ---
 KVM_TRANSLATE_MSI returns an LPI number. This seemed to be the simplest and fastest thing
to do.
 If someone is interested, i could prepare an RFC patch series for this, which would apply
on top of Andre's ITS implementation.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
