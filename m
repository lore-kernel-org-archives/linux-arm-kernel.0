From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 12 May 2014 10:58:58 +0400
Subject: [PATCH] arm: memset: zero out upper bytes in r1
In-Reply-To: <loom.20140508T103032-725@post.gmane.org>
References: <1399273875-8403-1-git-send-email-a.ryabinin@samsung.com>
 <loom.20140508T095105-952@post.gmane.org>
 <loom.20140508T103032-725@post.gmane.org>
Message-ID: <53707132.9070806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/14 12:38, Vladimir Murzin wrote:
> Vladimir Murzin <murzin.v <at> gmail.com> writes:
> 
>>
>> Andrey Ryabinin <a.ryabinin <at> samsung.com> writes:
>>
>>>
>>> memset doesn't work right for following example:
>>>
>>> 	signed char c = 0xF0;
>>> 	memset(addr, c, size);
>>>
>>> Variable c is signed, so after typcasting to int the value will be
> 0xFFFFFFF0.
>>> This value will be passed through r1 regitster to memset function.
>>> memset doesn't zero out upper bytes in r1, so memory will be filled
>>> with 0xFFFFFFF0 instead of expected 0xF0F0F0F0.
>>
>> It behaves the same as a generic implementation in lib/string.c, moreover
>> gcc built-in behaves the same. So it looks like expected behavior and POSIX
>> Programmer's Manual (man 3posix memset) explicitly says that "c" is
>> converted to unsigned char.
>>
>> Cheers
>> Vladimir
>>
>>
> 

Hi Vladimir.
Please, use reply to all next time, otherwise I might miss your mails.

> Sorry, had a bad coffee when posted it ;) It behaves /different/, but it is
> here for many years... 

Your are right, it's here for many years and wasn't noticed, probably because, there are no
such users, that call memset with not zero upper bytes in second argument. Though, I can't tell this
for sure, there are might be a few of such calls.
So this fix probably doesn't change anything for current kernel, however it might help to avoid problems in future.
Also, I think would be good to have the same behavior on different architectures (arm64/x86 works correctly
for example above).

> doesn't this change break something? iow, it possible
> that some user rely on this behavior...
> 

I don't think that such user exist, cause such user must know implementation details of memset
on ARM and rely on them.
If such user exist that's insane user and should be fixed.


> Vladimir
> 
