From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 15 Jan 2016 15:07:59 +0100
Subject: [PATCH v2] kernel: add kcov code coverage
In-Reply-To: <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
References: <1452689318-107172-1-git-send-email-dvyukov@google.com>
 <CAPAsAGx_0pVjtKA2RwwpStRG2-L+5X6W14QbrQaMYhdg30EeAQ@mail.gmail.com>
 <CACT4Y+bHjfkrZ4jWZf+j6FKnj2GQv1t94Y9LJm4=WFyb8C0J8w@mail.gmail.com>
 <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
Message-ID: <CACT4Y+YvL_L9a2dBfoXQ0AKpKmnypfObtt7k97j_i2Qiu=wnQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 2:05 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> 2016-01-14 17:30 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>> On Thu, Jan 14, 2016 at 11:50 AM, Andrey Ryabinin
>> <ryabinin.a.a@gmail.com> wrote:
>>> 2016-01-13 15:48 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>>>
>>>> +       /* Read number of PCs collected. */
>>>> +       n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
>>>> +       /* PCs are shorten to uint32_t, so we need to restore the upper part. */
>>>> +       for (i = 0; i < n; i++)
>>>> +               printf("0xffffffff%0lx\n", (unsigned long)cover[i + 1]);
>>
>> Thanks for the review!
>> Mailed v3 with fixes.
>> Comments inline.
>>
>>> This works only for x86-64.
>>> Probably there is no simple way to make this arch-independent with
>>> 32-bit values.
>>
>> We probably could add an ioctl that returns base of the stripped PCs.
>
> You forgot about modules. With stripped PCs you'll start mixing
> kernel's and module's PC (if distance between module and kernel > 4G).

It's just that on x86 text and modules are within 4GB.

I've checked that on arm64 it also seems to be the case:

 48  * The module space lives between the addresses given by TASK_SIZE
 49  * and PAGE_OFFSET - it must be within 128MB of the kernel text.
 50  */
 54 #define MODULES_END             (PAGE_OFFSET)
 55 #define MODULES_VADDR           (MODULES_END - SZ_64M)

Again, we can store wither u32s or u64s and expose this info in an ioctl...




>>> Note that this works only for cache-coherent architectures.
>>> For incoherent arches you'll need to flush_dcache_page() somewhere.
>>> Perhaps it could be done on exit to userspace, since flushing here is
>>> certainly an overkill.
>>
>> I can say that I understand the problem. Does it have to do with the
>> fact that the buffer is shared between kernel and user-space?
>> Current code is OK from the plain multi-threading side, as user must
>> not read buffer concurrently with writing (that would not yield
>> anything useful).
>
> It's not about SMP.
> This problem is about virtually indexed aliasing D-caches and could be
> observed on uniprocessor system.
> You have 3 virtual addresses (user-space, linear mapping and vmalloc)
> mapped to the same physical page.
> With aliasing cache it's possible to have multiple cache-lines
> representing the same physical page.
> So the kernel might not see the update made by userspace and vise
> versa because kernel/userspace use different virtual addresses.
>
> And btw, flush_dcache_page()  would be a wrong choice, since kcov_area
> is a vmalloc address, not a linear address.
> So we need something that flushes vmalloc addresses.
>
> Alternatively we could simply mlock that memory and talk to user space
> via get/put_user(). No flush will be required.
> And we will avoid another potential problem - lack of vmalloc address
> space on 32-bits.

Do you mean that user-space allocates a buffer and passes this buffer
to ioctl(KCOV_INIT); kernel locks this range and then directly writes
to it?

I afraid it becomes prohibitively expensive with put_user/get_user:
https://gist.githubusercontent.com/dvyukov/568f2e4a61afc910f880/raw/540cc071f1d561b9a3f9e50183d681be265af8c3/gistfile1.txt

Also, won't it require the same flush since the region is mmaped into
several processes (and process that reads is not the one that setups
the region)?

Size of coverage buffer that I currently use is 64K. I hope it is not
a problem for 32-bit archs.



>> We could add an ioctl that does the flush. But I would prefer if it is
>> done when we port kcov to such an arch. Does arm64 require the flush?
>>
>
> I think, it doesn't. AFAIK arm64 has non-aliasing D-cache.
>
> arm64/include/asm/cacheflush.h says:
>        Please note that the implementation assumes non-aliasing VIPT D-cache
>
> However, I wonder why it implements flush_dcache_page(). Per my
> understanding it is not need for non-aliasing caches.
> And Documentation/cachetlb.txt agrees with me:
>        void flush_dcache_page(struct page *page)
>           If D-cache aliasing is not an issue, this routine may
>           simply be defined as a nop on that architecture.
>
> Catalin, Will, could you please shed light on this?
