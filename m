From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 18 Sep 2012 15:18:12 -0400
Subject: [PATCH 01/15] ARM: add mem_type prot_pte accessor
In-Reply-To: <20120918122308.GJ32204@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153436.21241.95691.stgit@ubuntu>
 <20120918122308.GJ32204@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJnEe6jJpJhvR6MrS_Wc9o4XSTTbnuCg6LO56M2oobAPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 8:23 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Sep 15, 2012 at 04:34:36PM +0100, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> The KVM hypervisor mmu code requires access to the mem_type prot_pte
>> field when setting up page tables pointing to a device. Unfortunately,
>> the mem_type structure is opaque.
>>
>> Add an accessor (get_mem_type_prot_pte()) to retrieve the prot_pte
>> value.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  arch/arm/include/asm/mach/map.h |    1 +
>>  arch/arm/mm/mmu.c               |    6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
>> index a6efcdd..3787c9f 100644
>> --- a/arch/arm/include/asm/mach/map.h
>> +++ b/arch/arm/include/asm/mach/map.h
>> @@ -37,6 +37,7 @@ extern void iotable_init(struct map_desc *, int);
>>
>>  struct mem_type;
>>  extern const struct mem_type *get_mem_type(unsigned int type);
>> +extern pteval_t get_mem_type_prot_pte(unsigned int type);
>>  /*
>>   * external interface to remap single page with appropriate type
>>   */
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 4c2d045..76bf4f5 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -301,6 +301,12 @@ const struct mem_type *get_mem_type(unsigned int type)
>>  }
>>  EXPORT_SYMBOL(get_mem_type);
>>
>> +pteval_t get_mem_type_prot_pte(unsigned int type)
>> +{
>> +     return get_mem_type(type)->prot_pte;
>> +}
>> +EXPORT_SYMBOL(get_mem_type_prot_pte);
>> +
>
> get_mem_type can return NULL, so you should probably pass the error through
> rather than dereferencing it.
>
right, I guess callers can check against 0, since L_PTE_PRESENT should
always be there.

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a153fd4..f2b6287 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -305,7 +305,9 @@ EXPORT_SYMBOL(get_mem_type);

 pteval_t get_mem_type_prot_pte(unsigned int type)
 {
-       return get_mem_type(type)->prot_pte;
+       if (get_mem_type(type))
+               return get_mem_type(type)->prot_pte;
+       return 0;
 }
 EXPORT_SYMBOL(get_mem_type_prot_pte);
