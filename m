From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 14 Jul 2016 11:00:04 +0100
Subject: [PATCH v9 14/17] KVM: arm64: allow updates of LPI configuration
 table
In-Reply-To: <57875F8A.2070009@arm.com>
References: <20160713015909.28793-1-andre.przywara@arm.com>
 <20160713015909.28793-15-andre.przywara@arm.com> <57875F8A.2070009@arm.com>
Message-ID: <478c84bd-46e8-5f73-45d1-82d8c6bf38c1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/07/16 10:46, Marc Zyngier wrote:
> On 13/07/16 02:59, Andre Przywara wrote:
>> The (system-wide) LPI configuration table is held in a table in
>> (guest) memory. To achieve reasonable performance, we cache this data
>> in our struct vgic_irq. If the guest updates the configuration data
>> (which consists of the enable bit and the priority value), it issues
>> an INV or INVALL command to allow us to update our information.
>> Provide functions that update that information for one LPI or all LPIs
>> mapped to a specific collection.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-its.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index f400ef1..60108f8 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -64,6 +64,45 @@ struct its_itte {
>>  
>>  #define CBASER_ADDRESS(x)	((x) & GENMASK_ULL(51, 12))
>>  #define PENDBASER_ADDRESS(x)	((x) & GENMASK_ULL(51, 16))
>> +#define PROPBASER_ADDRESS(x)	((x) & GENMASK_ULL(51, 12))
> 
> Again, these masks are wrong as we limit the ITS to 48 bits PA.

Those masks match the architecture description of the register. We limit
to 48 bits of PA when the guest writes to those registers. I'd like to
keep this limitation in one place only.

Cheers,
Andre.
