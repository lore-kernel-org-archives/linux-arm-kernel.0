From: vkale@apm.com (Vinayak Kale)
Date: Thu, 30 Jan 2014 11:34:43 +0530
Subject: [PATCH V2] arm64: add DSB after icache flush in
 __flush_icache_all()
In-Reply-To: <20140128161402.GI2885@mudshark.cambridge.arm.com>
References: <1390892813-30407-1-git-send-email-vkale@apm.com>
 <20140128161402.GI2885@mudshark.cambridge.arm.com>
Message-ID: <CAPrCYkfpGJD+GQBmxqNZ8NM+9LhRvf5HiJrpMxHQzjrmPRhonA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Jan 28, 2014 at 9:44 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 28, 2014 at 07:06:53AM +0000, Vinayak Kale wrote:
>> Add DSB after icache flush. It's needed to complete the cache maintenance
>> operation. The function __flush_icache_all() is used only for user space
>> mappings and an ISB is not required because of an exception return before
>> executing user instructions. An exception return would behave like an ISB.
>>
>> This patch also uses 'memory' clobber for flush operation instruction to
>> prevent instruction re-ordering by compiler.
>>
>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>> ---
>>
>> V2: - Add more desciption in the commit message as suggested by Catalin & Will
>>     - Use 'memory' clobber for flush instruction as suggested by Will
>
> Please can you check and fix other occurrences of this bug too, as I asked
> in v1? For example, a 2 second grep shows problems with data-cache
> maintenance in kvm. I can also see the same problem for system register
> writes followed up with isb.
Can you please elaborate whether you are referring to lack of memory
clobber or missing barriers?
>
> I also don't buy you not being able to test AArch32 kernels. Does KVM not
> work for you?
Let me see what I can do to address this.
>
> Will
>
>>
>>  arch/arm64/include/asm/cacheflush.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>> index fea9ee3..bd30f42 100644
>> --- a/arch/arm64/include/asm/cacheflush.h
>> +++ b/arch/arm64/include/asm/cacheflush.h
>> @@ -115,7 +115,8 @@ extern void flush_dcache_page(struct page *);
>>
>>  static inline void __flush_icache_all(void)
>>  {
>> -     asm("ic ialluis");
>> +     asm volatile("ic ialluis" : : : "memory");
>> +     dsb();
>>  }
>>
>>  #define flush_dcache_mmap_lock(mapping) \
>> --
>> 1.8.2.1
>>
>>
