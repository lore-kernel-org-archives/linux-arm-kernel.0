From: dcashman@android.com (Daniel Cashman)
Date: Mon, 7 Dec 2015 10:26:34 -0800
Subject: [PATCH v5 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1720878.JdEcLd8bhL@wuerfel>
References: <1449000658-11475-1-git-send-email-dcashman@android.com>
 <1449000658-11475-4-git-send-email-dcashman@android.com>
 <56655EC8.6030905@nvidia.com> <1720878.JdEcLd8bhL@wuerfel>
Message-ID: <5665CF5A.1090207@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2015 03:13 AM, Arnd Bergmann wrote:
> On Monday 07 December 2015 10:26:16 Jon Hunter wrote:
>>
>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>> index af461b935137..e59a75a308bc 100644
>> --- a/arch/arm64/mm/mmap.c
>> +++ b/arch/arm64/mm/mmap.c
>> @@ -51,7 +51,7 @@ unsigned long arch_mmap_rnd(void)
>>  {
>>         unsigned long rnd;
>>  
>> -ifdef CONFIG_COMPAT
>> +#ifdef CONFIG_COMPAT

Thank you Jon.  This ought to persuade me to do a final build against
the final patch, rather than the ugly porting I had been doing.  I'll
include this in v6. (how embarassing =/)

>>         if (test_thread_flag(TIF_32BIT))
>>                 rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
>>         else
>>
>> Cheers
>>
> 
> Ideally we'd remove the #ifdef around the mmap_rnd_compat_bits declaration
> and change this code to use
> 
> 	if (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))
> 
> 	Arnd

That would result in "undefined reference to mmap_rnd_compat_bits" in
the not-defined case, no?

Thank You,
Dan
