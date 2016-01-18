From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Mon, 18 Jan 2016 16:34:33 +0300
Subject: [PATCH v2] kernel: add kcov code coverage
In-Reply-To: <CACT4Y+YvL_L9a2dBfoXQ0AKpKmnypfObtt7k97j_i2Qiu=wnQg@mail.gmail.com>
References: <1452689318-107172-1-git-send-email-dvyukov@google.com>
 <CAPAsAGx_0pVjtKA2RwwpStRG2-L+5X6W14QbrQaMYhdg30EeAQ@mail.gmail.com>
 <CACT4Y+bHjfkrZ4jWZf+j6FKnj2GQv1t94Y9LJm4=WFyb8C0J8w@mail.gmail.com>
 <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
 <CACT4Y+YvL_L9a2dBfoXQ0AKpKmnypfObtt7k97j_i2Qiu=wnQg@mail.gmail.com>
Message-ID: <CAPAsAGxpntZ-H+SEc3BNfOdS5Ciqn+esXmypD0e3h4oucxdoJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-15 17:07 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>>>> Note that this works only for cache-coherent architectures.
>>>> For incoherent arches you'll need to flush_dcache_page() somewhere.
>>>> Perhaps it could be done on exit to userspace, since flushing here is
>>>> certainly an overkill.
>>>
>>> I can say that I understand the problem. Does it have to do with the
>>> fact that the buffer is shared between kernel and user-space?
>>> Current code is OK from the plain multi-threading side, as user must
>>> not read buffer concurrently with writing (that would not yield
>>> anything useful).
>>
>> It's not about SMP.
>> This problem is about virtually indexed aliasing D-caches and could be
>> observed on uniprocessor system.
>> You have 3 virtual addresses (user-space, linear mapping and vmalloc)
>> mapped to the same physical page.
>> With aliasing cache it's possible to have multiple cache-lines
>> representing the same physical page.
>> So the kernel might not see the update made by userspace and vise
>> versa because kernel/userspace use different virtual addresses.
>>
>> And btw, flush_dcache_page()  would be a wrong choice, since kcov_area
>> is a vmalloc address, not a linear address.
>> So we need something that flushes vmalloc addresses.
>>
>> Alternatively we could simply mlock that memory and talk to user space
>> via get/put_user(). No flush will be required.
>> And we will avoid another potential problem - lack of vmalloc address
>> space on 32-bits.
>
> Do you mean that user-space allocates a buffer and passes this buffer
> to ioctl(KCOV_INIT); kernel locks this range and then directly writes
> to it?
>

It's one of the ways of doing this. Another possible way is to
allocate, mmap and pin pages in kcov_mmap().

> I afraid it becomes prohibitively expensive with put_user/get_user:
> https://gist.githubusercontent.com/dvyukov/568f2e4a61afc910f880/raw/540cc071f1d561b9a3f9e50183d681be265af8c3/gistfile1.txt
>

Right, but it should be better with __get_user/__put_user.

> Also, won't it require the same flush since the region is mmaped into
> several processes (and process that reads is not the one that setups
> the region)?

But it's only child process that could inherit kcov mapping from
parent, so it's be the same physical->virtual mapping as in parent.

> Size of coverage buffer that I currently use is 64K. I hope it is not
> a problem for 32-bit archs.
>

64K - per process. It's hard to whether this is a real problem or not,
since it depends
on how many processes collect coverage, size of vmalloc and vmalloc's
utilization by the rest of the kernel.
