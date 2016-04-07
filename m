From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 7 Apr 2016 14:58:13 +0100
Subject: [PATCH v4 04/12] KVM: arm64: handle ITS related GICv3
 redistributor registers
In-Reply-To: <57066682.5040404@arm.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <1458958450-19662-5-git-send-email-andre.przywara@arm.com>
 <57066682.5040404@arm.com>
Message-ID: <57066775.10102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/16 14:54, Marc Zyngier wrote:
> On 26/03/16 02:14, Andre Przywara wrote:
>> In the GICv3 redistributor there are the PENDBASER and PROPBASER
>> registers which we did not emulate so far, as they only make sense
>> when having an ITS. In preparation for that emulate those MMIO
>> accesses by storing the 64-bit data written into it into a variable
>> which we later read in the ITS emulation.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  include/kvm/vgic/vgic.h       |  8 ++++++++
>>  virt/kvm/arm/vgic/vgic_mmio.c | 26 ++++++++++++++++++++++----
>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/kvm/vgic/vgic.h b/include/kvm/vgic/vgic.h
>> index 11344e6..8ea5dd7 100644
>> --- a/include/kvm/vgic/vgic.h
>> +++ b/include/kvm/vgic/vgic.h
>> @@ -145,6 +145,14 @@ struct vgic_dist {
>>  
>>  	struct vgic_io_device	*dist_iodevs;
>>  	struct vgic_io_device	*redist_iodevs;
>> +
>> +	/* Address of LPI configuration table shared by all redistributors */
>> +	u64			propbaser;
>> +
>> +	/* Addresses of LPI pending tables per redistributor */
>> +	u64			*pendbaser;
> 
> All these should probably either be phys_addr_t or gpa_t.

Also: these registers are per redistributor. They really should appear
as such, and not be shoved in vgic_dist.

As for GICR_PROPBASER being shared: this is an implementation choice.
All the architecture mandates is that the same value is programmed in
all the redistributors.

Yes, you can share the storage, but I'd really want to see a field per
redist.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
