From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 24 Jan 2017 10:04:10 +0000
Subject: [PATCH 1/2] arm64: kvm: reuse existing cache type/info related
 macros
In-Reply-To: <20170123210553.GI15850@cbox>
References: <1484909410-11673-1-git-send-email-sudeep.holla@arm.com>
 <20170123210553.GI15850@cbox>
Message-ID: <1cc3e1dd-8acc-e203-da31-474a06e747e9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/01/17 21:05, Christoffer Dall wrote:
> On Fri, Jan 20, 2017 at 10:50:09AM +0000, Sudeep Holla wrote:
>> We already have various macros related to cache type and bitfields in
>> CLIDR system register. We can replace some of the hardcoded values
>> here using those existing macros.
>>
>> This patch reuses those existing cache type/info related macros and
>> replaces the hardcorded values. It also removes some of the comments
>> that become trivial with the macro names.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/include/asm/cachetype.h |  7 +++++++
>>  arch/arm64/kernel/cacheinfo.c      |  7 -------
>>  arch/arm64/kvm/sys_regs.c          | 27 +++++++++++++--------------
>>  3 files changed, 20 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
>> index f5588692f1d4..f58b5e3df6b8 100644
>> --- a/arch/arm64/include/asm/cachetype.h
>> +++ b/arch/arm64/include/asm/cachetype.h
>> @@ -39,6 +39,13 @@
>>  
>>  extern unsigned long __icache_flags;
>>  
>> +#define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
>> +/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
>> +#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
>> +#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
>> +#define CLIDR_CTYPE(clidr, level)	\
>> +	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
>> +
>>  /*
>>   * NumSets, bits[27:13] - (Number of sets in cache) - 1
>>   * Associativity, bits[12:3] - (Associativity of cache) - 1
>> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
>> index 3f2250fc391b..a460208b08cf 100644
>> --- a/arch/arm64/kernel/cacheinfo.c
>> +++ b/arch/arm64/kernel/cacheinfo.c
>> @@ -26,13 +26,6 @@
>>  #include <asm/cachetype.h>
>>  #include <asm/processor.h>
>>  
>> -#define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
>> -/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
>> -#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
>> -#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
>> -#define CLIDR_CTYPE(clidr, level)	\
>> -	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
>> -
>>  static inline enum cache_type get_cache_type(int level)
>>  {
>>  	u64 clidr;
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 87e7e6608cd8..5dca1f10340f 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -21,11 +21,13 @@
>>   */
>>  
>>  #include <linux/bsearch.h>
>> +#include <linux/cacheinfo.h>
>>  #include <linux/kvm_host.h>
>>  #include <linux/mm.h>
>>  #include <linux/uaccess.h>
>>  
>>  #include <asm/cacheflush.h>
>> +#include <asm/cachetype.h>
>>  #include <asm/cputype.h>
>>  #include <asm/debug-monitors.h>
>>  #include <asm/esr.h>
>> @@ -59,7 +61,7 @@
>>  static u32 cache_levels;
>>  
>>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>> -#define CSSELR_MAX 12
>> +#define CSSELR_MAX 	((MAX_CACHE_LEVEL - 1) >> 1)
> 
> Did you mean '<< 1' here?
> 

Ah right, sorry for the stupid mistake.

-- 
Regards,
Sudeep
