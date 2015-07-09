From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 09 Jul 2015 19:11:25 +0200
Subject: [PATCH v2 0/7] KVM: arm/arm64: gsi routing support
In-Reply-To: <026801d0ba5f$43a79520$caf6bf60$@samsung.com>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <023601d0ba54$c4d6e020$4e84a060$@samsung.com> <559E927E.8040403@arm.com>
 <026801d0ba5f$43a79520$caf6bf60$@samsung.com>
Message-ID: <559EAB3D.2080205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel, Andre,
On 07/09/2015 05:52 PM, Pavel Fedin wrote:
>  Hi!
> 
>>> 3. KVM_SET_GSI_ROUTING - we use KVM_IRQ_ROUTING_EXTENDED_MSI plus devid
>>
>> Here we already have a type field with some users, so lets piggy-back on
>> this.
> 
>  We already have 'flags' there too.
> 
>> Both ioctl extensions are coupled with a per-VM capability to let
>> userland know that it needs to provide a device ID.
> 
>> Using flags on its own (without an explicit capability) is what I
>> opposed against, not flags in general.
> 
>  Ok, and in your next respin you'll add the capability, correct? So that we will finally have all
> pieces in place.
> 
>> In case of KVM_SET_GSI_ROUTING it just seems awkward
>> to me to use a flag when a different type would do as well.
> 
>  Well, MSI vs "Extended MSI" are even not different types really. It's just MSI which has devid. And
> we *ALREADY* have VALID_DEVID flag.
> 
>> But after all, I don't have a strong opinion on that matter, so if
>> others prefer using a flag I am also fine with that.
> 
>  So, ok, to be short... My vote is for flag, because it's already there and it keeps up with the
> style we already have. Eric, this is my final statement about it. It's up to you to accept or
> ignore. In qemu code flag is a little bit nicer because it's just stored in a variable and helps to
> avoid several if-else's (however small ones). Compare:
Well personally I prefer the type thing and I don't see much difference
at userspace level anyway. But I am not this kind of hyperspace
architect guy. So, since there is no consensus here, I would say let's
wait for formal reviews of our maintainers and I will align.

The v2 update is not the outcome of a consensus so I made arbitrary
decisions to progress & fix bugs and I hope this eventually works with
ITS ;-)

Best Regards

Eric
> --- cut ---
>     kroute.gsi = virq;
>     kroute.type = KVM_IRQ_ROUTING_MSI;
>     kroute.u.msi.address_lo = (uint32_t)msg.address;
>     kroute.u.msi.address_hi = msg.address >> 32;
>     kroute.u.msi.data = le32_to_cpu(msg.data);
>     kroute.flags = kvm_msi_flags;
>     if (kroute.flags & KVM_MSI_VALID_DEVID) {
>         kroute.u.msi.devid = (pci_bus_num(dev->bus) << 8) | dev->devfn;
>     }
> --- cut ---
> and:
> --- cut ---
>     kroute.gsi = virq;
>     if (use_extended_msi) {
>         kroute.u.msi.devid = (pci_bus_num(dev->bus) << 8) | dev->devfn;
>         kroute.type = KVM_IRQ_ROUTING_EXTENDED_MSI;
>     } else {
>         kroute.type = KVM_IRQ_ROUTING_MSI;
>     }
>     kroute.u.msi.address_lo = (uint32_t)msg.address;
>     kroute.u.msi.address_hi = msg.address >> 32;
>     kroute.u.msi.data = le32_to_cpu(msg.data);
>     kroute.flags = kvm_msi_flags;
> --- cut ---
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
