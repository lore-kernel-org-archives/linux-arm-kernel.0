From: james.morse@arm.com (James Morse)
Date: Mon, 16 Nov 2015 12:27:07 +0000
Subject: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
In-Reply-To: <20151114202623.GC20429@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
 <20151114202623.GC20429@amd>
Message-ID: <5649CB9B.30102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/15 20:26, Pavel Machek wrote:
> On Tue 2015-10-27 17:29:19, James Morse wrote:
>> Some architectures require code written to memory as if it were data to be
>> 'cleaned' from any data caches so that the processor can fetch them as new
>> instructions.
>>
>> During resume from hibernate, the snapshot code copies some pages directly,
>> meaning these architectures do not get a chance to perform their cache
>> maintenance. Add a call to flush_icache_range(), which is provided by
>> architectures that require it, to perform the maintenance.
>>
>> This mirrors the kernel's behaviour when loading kernel modules and when
>> mapping executable pages to user space.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Looks reasonable.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!

> 
>> ---
>>  kernel/power/snapshot.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index 5235dd4e1e2f..139fc449ad75 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
>>  static inline void do_copy_page(long *dst, long *src)
>>  {
>>  	int n;
>> +	unsigned long __maybe_unused start = (unsigned long)dst;
> 
> Why the "maybe unused"?

To avoid a build warning on x86_64, and any other architectures that don't
use the arguments in their flush_icache_range() implementation.

Without __maybe_unused, gcc 4.9.2, building for x86_64:
> ../kernel/power/snapshot.c: In function ?do_copy_page?:
> ../kernel/power/snapshot.c:1200:16: warning: unused variable ?start?
> [-Wunused-variable]
>  unsigned long start = (unsigned long)dst;


>>  	for (n = PAGE_SIZE / sizeof(long); n; n--)
>>  		*dst++ = *src++;
>> +
>> +	flush_icache_range(start, start+PAGE_SIZE);
>>  }


Thanks,

James
