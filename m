From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 4 Sep 2018 19:24:33 +0300
Subject: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
In-Reply-To: <6954711c-6441-04df-62a9-a83c867e06ad@virtuozzo.com>
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
 <ad334e64-28d1-4b91-aeba-8352934a9c46@lge.com>
 <6954711c-6441-04df-62a9-a83c867e06ad@virtuozzo.com>
Message-ID: <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/04/2018 01:10 PM, Andrey Ryabinin wrote:
> 
> 
> On 09/04/2018 09:59 AM, Kyeongdon Kim wrote:
> 
>>>> +#undef strncmp
>>>> +int strncmp(const char *cs, const char *ct, size_t len)
>>>> +{
>>>> + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
>>>> + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>>>
>>> This will cause false positives. Both 'cs', and 'ct' could be less than len bytes.
>>>
>>> There is no need in these interceptors, just use the C implementations from lib/string.c
>>> like you did in your first patch.
>>> The only thing that was wrong in the first patch is that assembly implementations
>>> were compiled out instead of being declared week.
>>>
>> Well, at first I thought so..
>> I would remove diff code in /mm/kasan/kasan.c then use C implementations in lib/string.c
>> w/ assem implementations as weak :
>>
>> diff --git a/lib/string.c b/lib/string.c
>> index 2c0900a..a18b18f 100644
>> --- a/lib/string.c
>> +++ b/lib/string.c
>> @@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
>> ?EXPORT_SYMBOL(strlcat);
>> ?#endif
>>
>> -#ifndef __HAVE_ARCH_STRCMP
>> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || !defined(__HAVE_ARCH_STRCMP)
> 
> No. What part of "like you did in your first patch" is unclear to you?

Just to be absolutely clear, I meant #ifdef out __HAVE_ARCH_* defines like it has been done in this patch
http://lkml.kernel.org/r/<1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
