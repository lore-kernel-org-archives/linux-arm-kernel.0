From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Thu, 11 May 2017 22:42:46 +0800
Subject: [PATCH] arm64: mm: check length in sync_icache_aliases for
 performance
In-Reply-To: <20170511091644.GA14766@leverpostej>
References: <1494490772-203184-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170511091644.GA14766@leverpostej>
Message-ID: <c1666948-0eeb-e7aa-4f73-4abc3c718112@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

Thanks for your reply.

On 2017/5/11 17:16, Mark Rutland wrote:
> Hi,
> 
> On Thu, May 11, 2017 at 04:19:32PM +0800, Shaokun Zhang wrote:
>> sync_icache_aliases calls flush_icache_range if icache is non-aliasing
>> policy[see 0a28714 ("arm64: Use PoU cache instr for I/D coherency")].
>>   
>> If icache uses non-aliasing and page size is 64K, it will broadcast 1K
>> DVMs(IC IVAU) to other cpu cores per page. In multi-cores system, so many
>> DVMs would degenerate performance. Even if page size is 4K, 64 DVMs will
>> be broadcasted and executed.
> 
> Please note that this depends on the I-cache and D-cache line sizes,
> which are not necessarily 64 bytes.

Right. I am sorry that maybe i should explain I-cache line size is 64 bytes
in my case.

> 
> This is also dependent on system integration. DVMs are not an
> architectural concept, and the interconnect may optimize this (e.g. with
> snoop filters).

Hmm, SF is a good choice, However it may be not suitable for IC IVAU broadcast,
perhaps i am limited about this.

> 
>> This patch fixes this issue using invalidation icache all instread of by
>> VA when length is one or multiple PAGE_SIZE, especailly for
>> __sync_icache_dcache.
> 
> This means that we'll over-invalidate the I-caches all the time,
> potentially harming the performance of unrelated tasks. So this is not
> necessarily an improvement.

Agree its harm, therefore only under the condition that one or more pages
would be used IC IVAU, using invalidate the I-cache replaces it.

> 
> Do you have a particular workload which is affected by this?

I write self-modifying code that i want to simulate JVM, it uses mmap to
allocate large memory holding executing code. In the test procedure, i
found that __sync_icache_dcache would be called many times and lots of
DVMs occur. It is mainly used to handle page fault and memory migration.
When i add this check, it decreases number of DVMs. Because of much OOM
printing information, i couldn't give the result between the two scenes.
Maybe i need to optimize this test model.

Thanks
Shaokun

> 
> Thanks,
> Mark.
> 
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  arch/arm64/mm/flush.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
>> index 21a8d82..f71da2d 100644
>> --- a/arch/arm64/mm/flush.c
>> +++ b/arch/arm64/mm/flush.c
>> @@ -29,7 +29,7 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
>>  {
>>  	unsigned long addr = (unsigned long)kaddr;
>>  
>> -	if (icache_is_aliasing()) {
>> +	if ((len >= PAGE_SIZE) || icache_is_aliasing()) {
>>  		__clean_dcache_area_pou(kaddr, len);
>>  		__flush_icache_all();
>>  	} else {
>> -- 
>> 1.9.1
>>
> 
> .
> 
