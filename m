From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 5 Nov 2014 10:37:34 +0000
Subject: [PATCH v3 12/19] arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
In-Reply-To: <5459FB9F.2020104@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-13-git-send-email-andre.przywara@arm.com>
 <20141104193008.GO16132@cbox> <5459FB9F.2020104@arm.com>
Message-ID: <5459FDEE.1010500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/14 10:27, Andre Przywara wrote:
> Hi Christoffer,
>
> On 04/11/14 19:30, Christoffer Dall wrote:
>> On Fri, Oct 31, 2014 at 05:26:47PM +0000, Andre Przywara wrote:
>>> vgic_set_attr() and vgic_get_attr() contain both code specific for
>>> the emulated GIC as well as code for the userland facing, generic
>>> part of the GIC.
>>> Split the guest GIC facing code of from the generic part to allow
>>> easier splitting later.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>
>> It's not really clear to me which data is specific to the emulated gic
>> and which is not or why you have to do this (yet), for example, the
>> _common function is now dealing with the GRP_ADDR case which is very
>> GICv2 specific (so far).  But I assume this will make sense as I
>> progress through the series.
>
> Admittedly this is somewhat of a corner case. Actually I tried to keep
> as much code common (in vgic.c) as possible, and it was possible without
> much pain for GRP_ADDR and kvm_vgic_addr.
> Also I consider this call part of the switching and connecting
> functionality of the VGIC.
> Looking at the code again I think I had it in -emul.c before, but
> decided to move it back for some reason (probably some other code
> dependency which needed to be exposed). So unless I find some time ;-)
> and a good reason to move it I tend to keep it here.

... just found that kvm_vgic_addr() is not static, but also called from
the (now legacy) KVM_ARM_SET_DEVICE_ADDR ioctl. So it was causing more
churn to move it than it gave us clean separation.

Cheers,
Andre.

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
