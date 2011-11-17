From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 Nov 2011 16:20:15 -0800
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
Message-ID: <CAOesGMg79XKq6tSsuGekAU3jHAOZSHnViQkpm9PG2zpaxF=w+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 4:16 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Nov 16, 2011 at 3:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Nov 16, 2011 at 01:23:02PM -0800, Olof Johansson wrote:
>>> Agreed. Russell, please consider picking this up -- the bug is very
>>> real and it sounds like the objection is vague.
>>
>> No, it isn't. ?It's creating an unsafe situation. ?If we're going to do
>> this, we might as well give up on architecture correctness because we're
>> throwing out locking correctness.
>>
>> 1. We look up the VMA.
>> 2. We pass the VMA to the cache operation.
>> 3. The cache operation dereferences the VMA to obtain the VMA flags.
>
> The current implementation doesn't use the flush_cache_user_range
> per-cpu function, it uses the coherent_user_page:
>
> from arch/arm/include/asm/cacheflush.h:
>
> #define flush_cache_user_range(vma,start,end) \
> ? ?__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
>
> Which doesn't take flags. So the vma isn't used at all at the flushing
> step (which is also why this patch removes the flags being passed in).

I wonder if I am getting dyslexic.

s/the coherent_user_page/coherent_user_range/ above, and s/removes the
flags/removes the vma from/.


-Olof
