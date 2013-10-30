From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Oct 2013 17:11:28 +0000
Subject: [PATCH v2] arm/arm64: KVM: MMIO support for BE guest
In-Reply-To: <CAAhSdy0UdzKz8sKBgbZFQFWAAiC59PWcvc+-w8o=3Hsx+4UkaQ@mail.gmail.com>
References: <1383072593-28916-1-git-send-email-marc.zyngier@arm.com>
 <CAAhSdy3SUiF8k-WokdsBEM5WLx2ifzDL__ta_sLrHge3Lp34JA@mail.gmail.com>
 <b7620ddbce4278713635321bd9a708f4@www.loen.fr>
 <CAAhSdy0UdzKz8sKBgbZFQFWAAiC59PWcvc+-w8o=3Hsx+4UkaQ@mail.gmail.com>
Message-ID: <52713DC0.8040703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/13 17:06, Anup Patel wrote:
> On Wed, Oct 30, 2013 at 1:58 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 2013-10-30 01:10, Anup Patel wrote:
>>>
>>> On Wed, Oct 30, 2013 at 12:19 AM, Marc Zyngier <marc.zyngier@arm.com>
>>> wrote:
>>>>
>>>> Do the necessary byteswap when host and guest have different
>>>> views of the universe. Actually, the only case we need to take
>>>> care of is when the guest is BE. All the other cases are naturally
>>>> handled.
>>>
>>>
>>> You might want to handle the case where we have LE guest on BE host
>>> because for ARM64 kernel we might have lot of people interested in
>>> running host kernel in BE mode with KVM enabled.
>>
>>
>> What makes you think it is not handled already?
> 
> What I understood here is that you are trying to ensure that MMIO data
> passed to/from user space (i.e. QEMU or KVMTOOL) is host endian
> using vcpu_data_guest_to_host() and vcpu_data_host_to_guest(). This
> makes lot of sense for having all combinations of host and guest endianness.
> 
> If the above is correct then I see an issue in vcpu_data_guest_to_host() and
> vcpu_data_host_to_guest() for LE guest on BE host because this patch does
> endianness conversion for BE VCPUs only in vcpu_data_guest_to_host() and
> vcpu_data_host_to_guest(). If we have LE guest on BE host then these
> functions won't do any endianness conversion.

And no conversion is exactly what we want. MMIO is always LE.

	M.
-- 
Jazz is not dead. It just smells funny...
