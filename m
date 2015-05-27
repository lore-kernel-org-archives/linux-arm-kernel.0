From: sophian.yoma@gmail.com (yoma sophian)
Date: Wed, 27 May 2015 20:09:39 +0800
Subject: some question about arm64 smp_spin_table.c
In-Reply-To: <2349133.7jIxnW0uLz@wuerfel>
References: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
 <2349133.7jIxnW0uLz@wuerfel>
Message-ID: <CADUS3o=c6SXULSguCN57gNLMzxmLh2ZHZEpLhe9i2Ks=JA1NUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Arnd:

2015-05-27 18:06 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 27 May 2015 17:47:09 yoma sophian wrote:
>> And in Arm64, once other platform use different area, such as register
>> or device memory, to put cpu_release_addr[cpu], shall we use ioremap
>> to get the va like below patch?
>>
>> @@ -47,10 +48,9 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
>>         if (!cpu_release_addr[cpu])
>>                 return -ENODEV;
>>
>> -       release_addr = __va(cpu_release_addr[cpu]);
>> +       release_addr = ioremap(cpu_release_addr[cpu], SZ_4K);
>>         release_addr[0] = (void *)__pa(secondary_holding_pen);
>> -       __flush_dcache_area(release_addr, sizeof(release_addr[0]));
>> -
>> +       iounmap(release_addr);
>>         /*
>>
>
> I believe that won't work: The other CPU is spinning on its L1 cache,
> and with ioremap, you would be bypassing the cache.
I am not quite understand "The other CPU is spinning on its L1 cache,"
As far as I know,
1. cpu_release_addr[cpu] is where other core spin to
2. Before other cores jump to their kernel entry,
secondary_holding_pen, shouldn't they follow the booting.txt
mentioned:
- Caches, MMUs
  The MMU must be off.
  Instruction cache may be on or off.
  The address range corresponding to the loaded kernel image must be
  cleaned to the PoC. In the presence of a system cache or other
  coherent masters with caches enabled, this will typically require
  cache maintenance by VA rather than set/way operations.

Why you say The other CPU is spinning on its L1 cache?
And even it is it is spinning on its L1 cache,
"The address range corresponding to the loaded kernel image must be
  cleaned to the PoC."

And the other cpu will make sure before polling the spin address
before invalidate it, right?

Appreciate your kind help,
