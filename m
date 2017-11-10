From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 10 Nov 2017 20:03:48 +0800
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <5A049B20.6000501@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com>
Message-ID: <07913a3b-fa58-d089-6f84-d6671e2dab97@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/11/10 2:14, James Morse wrote:
> Hi guys,
> 
> On 19/10/17 15:57, James Morse wrote:
>> Known issues:
> [...]
>>  * KVM-Migration: VDISR_EL2 is exposed to userspace as DISR_EL1, but how should
>>    HCR_EL2.VSE or VSESR_EL2 be migrated when the guest has an SError pending but
>>    hasn't taken it yet...?
> 
> I've been trying to work out how this pending-SError-migration could work.


Hi James,
  I have finished the Qemu part development about RAS and sent the patches out, I think the solution followed your suggestion and other people's suggestion in the mail discussion.
For example, not pass KVM exception information to Qemu, according to the SIGBUS type(BUS_MCEERR_AR or BUS_MCEERR_A0)
to use different notification type,  create guest APEI table and record CPER in rumtime for guest, etc

how about you have a look at these implementation and then we discuss this migration again? thanks.



> 
> If HCR_EL2.VSE is set then the guest will take a virtual SError when it next
> unmasks SError. Today this doesn't get migrated, but only KVM sets this bit as
> an attempt to kill the guest.
> 
> This will be more of a problem with GengDongjiu's SError CAP for triggering
> guest SError from user-space, which will also allow the VSESR_EL2 to be
> specified. (this register becomes the guest ESR_EL1 when the virtual SError is
> taken and is used to emulate firmware-first's NOTIFY_SEI and eventually
> kernel-first RAS). These errors are likely to be handled by the guest.
> 
> 
> We don't want to expose VSESR_EL2 to user-space, and for migration it isn't
> enough as a value of '0' doesn't tell us if HCR_EL2.VSE is set.
> 
> To get out of this corner: why not declare pending-SError-migration an invalid
> thing to do?
> 
> We can give Qemu a way to query if a virtual SError is (still) pending. Qemu
> would need to check this on each vcpu after migration, just before it throws the
> switch and the guest runs on the new host. This way the VSESR_EL2 value doesn't
> need migrating at all.
> 
> In the ideal world, Qemu could re-inject the last SError it triggered if there
> is still one pending when it migrates... but because KVM injects errors too, it
> would need to block migration until this flag is cleared.
> KVM can promise this doesn't change unless you run the vcpu, so provided the
> vcpu actually takes the SError at some point this thing can still be migrated.
> 
> This does make the VSE machinery hidden unmigratable state in KVM, which is nasty.
> 
> Can anyone suggest a better way?
> 
> 
> Thanks,
> 
> James
> 
> .
> 
