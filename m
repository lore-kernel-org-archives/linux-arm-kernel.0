From: leoy@marvell.com (Leo Yan)
Date: Fri, 29 Jul 2011 10:25:02 +0800
Subject: [PATCH] lib/genalloc: fix gen_pool_virt_to_phys locking
In-Reply-To: <CAMk6uBmE01EpAw3e8kB9v6tEkU0rAPqt8T7+k54QDzDxtDn7PQ@mail.gmail.com>
References: <1311664741-21336-1-git-send-email-leoy@marvell.com>
	<CAMk6uBmE01EpAw3e8kB9v6tEkU0rAPqt8T7+k54QDzDxtDn7PQ@mail.gmail.com>
Message-ID: <4E3219FE.6020306@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

real mz,

You are right. :-) it's long time not see you guy.
For i am developed based on mainline, so if without this
patch, then the kernel will panic.

Best regards,
Leo Yan


On 2011?07?28? 18:39, real mz wrote:
> this fix seems already on next tree
>
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=blob;f=lib/genalloc.c;h=f352cc42f4f8a58b8e4c8304de32cb31b4e29b67;hb=HEAD
>
>
> On Tue, Jul 26, 2011 at 3:19 PM, Leo Yan<leoy@marvell.com>  wrote:
>> The func gen_pool_virt_to_phys will iterate the chunk list;
>> if find the correct chunk it should need release pool's lock.
>>
>> Signed-off-by: Leo Yan<leoy@marvell.com>
>> ---
>>   lib/genalloc.c |    4 +++-
>>   1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/lib/genalloc.c b/lib/genalloc.c
>> index 577ddf8..e625df5 100644
>> --- a/lib/genalloc.c
>> +++ b/lib/genalloc.c
>> @@ -92,8 +92,10 @@ phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long addr)
>>         list_for_each(_chunk,&pool->chunks) {
>>                 chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
>>
>> -               if (addr>= chunk->start_addr&&  addr<  chunk->end_addr)
>> +               if (addr>= chunk->start_addr&&  addr<  chunk->end_addr) {
>> +                       read_unlock(&pool->lock);
>>                         return chunk->phys_addr + addr - chunk->start_addr;
>> +               }
>>         }
>>         read_unlock(&pool->lock);
>>
>> --
>> 1.7.4.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
