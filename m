From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Apr 2016 10:25:24 +0100
Subject: [RFC PATCH] arm64: KVM: Allow userspace to configure guest
 MPIDR_EL1
In-Reply-To: <20160421070447.nwuqlxvpq7fj6h7m@hawk.localdomain>
References: <1461161319-38835-1-git-send-email-ashoks@broadcom.com>
 <20160420183354.31f1bfbd@arm.com>
 <20160421070447.nwuqlxvpq7fj6h7m@hawk.localdomain>
Message-ID: <57189C84.8080206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Andrew,

On 21/04/16 08:04, Andrew Jones wrote:
> On Wed, Apr 20, 2016 at 06:33:54PM +0100, Marc Zyngier wrote:
>> On Wed, 20 Apr 2016 07:08:39 -0700
>> Ashok Kumar <ashoks@broadcom.com> wrote:
>>
>>> For guests with NUMA configuration, Node ID needs to
>>> be recorded in the respective affinity byte of MPIDR_EL1.
>>
>> As others have said before, the mapping between the NUMA hierarchy and
>> MPIDR_EL1 are completely arbitrary, and only the firmware description
>> can help the kernel in interpreting the affinity levels.
>>
>> If you want any patch like this one to be considered, I'd like to see
>> the corresponding userspace that:
>>
>> - programs the affinity into the vcpus,
> 
> I have a start on this for QEMU that I can dust off and send as an RFC
> soon.
> 
>> - pins the vcpus to specific physical CPUs,
> 
> This wouldn't be part of the userspace directly interacting with KVM,
> but rather a higher level (even higher than libvirt, e.g.
> openstack/ovirt). I also don't think we should need to worry about
> which/how the phyiscal cpus get chosen. Let's assume that entity
> knows how to best map the guest's virtual topology to a physical one.

Surely the platform emulation userspace has to implement the pinning
itself, because I can't see high level tools being involved in the
creation of the vcpu threads themselves.

Also, I'd like to have a "simple" tool to test this without having to
deploy openstack (the day this becomes mandatory for kernel development,
I'll move my carrier to something more... agricultural).

So something in QEMU would be really good...

> 
>> - exposes the corresponding firmware description (either DT or ACPI) to
>>   the kernel.
> 
> The QEMU patches I've started on already generate the DT (the cpu-map
> node). I started looking into how to do it for ACPI too, but there
> were some questions about whether or not the topology description
> tables added to the 6.1 spec were sufficient. I can send the DT part
> soon, and continue to look into the ACPI part later though.

That'd be great. Can you please sync with Ashok so that we have
something consistent between the two of you?

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
