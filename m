From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 26 Feb 2016 11:26:01 -0800
Subject: [PATCH v12 5/5] arm64, mm, numa: Add NUMA balancing support for
 arm64.
In-Reply-To: <20160226185356.GO29125@arm.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-6-git-send-email-ddaney.cavm@gmail.com>
 <20160226185356.GO29125@arm.com>
Message-ID: <56D0A6C9.40907@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 10:53 AM, Will Deacon wrote:
> On Mon, Feb 22, 2016 at 05:58:23PM -0800, David Daney wrote:
>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>
>> Enable NUMA balancing for arm64 platforms.
>> Add pte, pmd protnone helpers for use by automatic NUMA balancing.
>>
>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/arm64/Kconfig               |  1 +
>>   arch/arm64/include/asm/pgtable.h | 15 +++++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9f0972a..6e22503 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -11,6 +11,7 @@ config ARM64
>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>   	select ARCH_USE_CMPXCHG_LOCKREF
>>   	select ARCH_SUPPORTS_ATOMIC_RMW
>> +	select ARCH_SUPPORTS_NUMA_BALANCING
>>   	select ARCH_WANT_OPTIONAL_GPIOLIB
>>   	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>>   	select ARCH_WANT_FRAME_POINTERS
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index bf464de..5af9db2 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -346,6 +346,21 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
>>   	return __pgprot(pgprot_val(prot) & ~PTE_TABLE_BIT);
>>   }
>>
>> +#ifdef CONFIG_NUMA_BALANCING
>> +/*
>> + * See the comment in include/asm-generic/pgtable.h
>> + */
>> +static inline int pte_protnone(pte_t pte)
>> +{
>> +	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
>> +}
>> +
>> +static inline int pmd_protnone(pmd_t pmd)
>> +{
>> +	return pte_protnone(pmd_pte(pmd));
>> +}
>> +#endif
>
> Can these not be macros, like our other pte_* and pmd_* predicates in
> this header file?

They probably could be.  However there is precedence for the static 
inline form:

$ git grep pte_protnone | grep '\.h' | grep -v return
arch/arm64/include/asm/pgtable.h:static inline int pte_protnone(pte_t pte)
arch/powerpc/include/asm/book3s/64/hash.h:static inline int 
pte_protnone(pte_t pte)
arch/powerpc/include/asm/nohash/pgtable.h:static inline int 
pte_protnone(pte_t pte)
arch/s390/include/asm/pgtable.h:static inline int pte_protnone(pte_t pte)
arch/x86/include/asm/pgtable.h:static inline int pte_protnone(pte_t pte)
include/asm-generic/pgtable.h:static inline int pte_protnone(pte_t pte)


Actually I am a little surprised that all the arm64 pte_* and pmd_* 
things are not written as static inline to achieve added type safety. 
The generated code should be identical.


>
> Will
>
