From: dcashman@android.com (Daniel Cashman)
Date: Mon, 14 Dec 2015 12:51:51 -0800
Subject: [PATCH v6 4/4] x86: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <566F1154.7030703@zytor.com>
References: <1449856338-30984-1-git-send-email-dcashman@android.com>
 <1449856338-30984-2-git-send-email-dcashman@android.com>
 <1449856338-30984-3-git-send-email-dcashman@android.com>
 <1449856338-30984-4-git-send-email-dcashman@android.com>
 <1449856338-30984-5-git-send-email-dcashman@android.com>
 <566F1154.7030703@zytor.com>
Message-ID: <566F2BE7.4090904@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2015 10:58 AM, H. Peter Anvin wrote:
> On 12/11/15 09:52, Daniel Cashman wrote:
>> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
>> index 844b06d..647fecf 100644
>> --- a/arch/x86/mm/mmap.c
>> +++ b/arch/x86/mm/mmap.c
>> @@ -69,14 +69,14 @@ unsigned long arch_mmap_rnd(void)
>>  {
>>  	unsigned long rnd;
>>  
>> -	/*
>> -	 *  8 bits of randomness in 32bit mmaps, 20 address space bits
>> -	 * 28 bits of randomness in 64bit mmaps, 40 address space bits
>> -	 */
>>  	if (mmap_is_ia32())
>> -		rnd = (unsigned long)get_random_int() % (1<<8);
>> +#ifdef CONFIG_COMPAT
>> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
>> +#else
>> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
>> +#endif
>>  	else
>> -		rnd = (unsigned long)get_random_int() % (1<<28);
>> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
>>  
>>  	return rnd << PAGE_SHIFT;
>>  }
>>
> 
> Now, you and I know that both variants can be implemented with a simple
> AND, but I have a strong suspicion that once this is turned into a
> variable, this will in fact be changed from an AND to a divide.
> 
> So I'd prefer to use the
> "get_random_int() & ((1UL << mmap_rnd_bits) - 1)" construct instead.

Good point.  Will change in v7 across patch-set.

Thank You,
Dan
