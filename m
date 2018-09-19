From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Sep 2018 11:03:11 +0100
Subject: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
In-Reply-To: <CAFEAcA_tphfZ_BKfAYuefStTipta0notyAR=NCnWFJ6nRfERpg@mail.gmail.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com>
 <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
 <218b64d5-741d-97ef-8aae-bc0a2ac3e56c@arm.com>
 <CAFEAcA8qjJJ0FkQj4yBMKFrwNFiJj3Q4FBi4GbnK2PN3B3J-mg@mail.gmail.com>
 <fec1a2e0-a45a-eb51-6ffe-2ac9b35acc45@arm.com>
 <CAFEAcA_tphfZ_BKfAYuefStTipta0notyAR=NCnWFJ6nRfERpg@mail.gmail.com>
Message-ID: <e818aa74-a34e-91fa-ad5a-344816105840@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2018 06:15 PM, Peter Maydell wrote:
> On 18 September 2018 at 17:27, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> ---
>>
>> "On arm64, the physical address size for a VM (IPA Size limit) is limited
>> to 40bits by default. The limit can be configured if the host supports the
>> extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
>> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
>> identifier, where IPA_Bits is the maximum width of any physical
>> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
>> machine type identifier.
>>
>> e.g, to configure a guest to use 48bit physical address size :
>>
>>          vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
>>
>> The requested size (IPA_Bits) must be :
>>    0 - Implies default 40bits (for backward compatibility)
>>
>>    or
>>
>>    N - Implies N bits, where N is a positive integer such that 32 <= N <=
>> Host_IPA_Limit
>>
>> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host and
>> is dependent on the CPU capability and the kernel configuration. The limit
>> can
>> be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the KVM_CHECK_EXTENSION
>> ioctl() at run-time.
>>
>> Please note that configuring the IPA size does not affect the capability
>> exposed by the guest CPUs in ID_AA64MMFR0_EL1[PARange]. It only affects
>> the guest to host physical address (stage2) translations setup by the host.
>> "
> 
> Thanks, this is much clearer. The only bit I'm not sure about is that
> last paragraph -- if I ask for a VM with a 48 bit address space why
> don't we tell the guest that that's what it has ?

The point is the IPA Size is not a limit on the CPU's PA size. e.g, if
this guest was a nested hypervisor with 48bit IPA, it could still
support a 52bit IPA nested guest within by simply looking up the CPU
PARange. The IPA size configuration here is simply a hint to the
hypervisor on where the memory banks would be kept. And this certainly
true on real platforms (e.g, my Juno has 42bit PARange on A57, while
A53 reports 40bit, with PA max at 40bits).

Suzuki
