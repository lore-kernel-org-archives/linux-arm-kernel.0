From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 31 Oct 2012 11:01:44 +0100
Subject: [PATCH] slab : allow SLAB_RED_ZONE and SLAB_STORE_USER to work
 on arm
In-Reply-To: <CAOJsxLHQy7pshnskn+wMp=1D9+9wGQZBhFD+kjtbCSJvoW7q2Q@mail.gmail.com>
References: <1350386231-770-1-git-send-email-matthieu.castet@parrot.com>
 <CAOJsxLHQy7pshnskn+wMp=1D9+9wGQZBhFD+kjtbCSJvoW7q2Q@mail.gmail.com>
Message-ID: <5090F708.3010104@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pekka Enberg a ?crit :
> Hi,
> 
> (Adding more people to CC.)
> 
> On Tue, Oct 16, 2012 at 2:17 PM, Matthieu CASTET
> <matthieu.castet@parrot.com> wrote:
>> From: Matthieu CASTET <castet.matthieu@free.fr>
>>
>> on cortexA8 (omap3) ralign is 64 and __alignof__(unsigned long long) is 8.
>> So we always disable debug.
>>
>> This patch is based on 5c5e3b33b7cb959a401f823707bee006caadd76e, but fix
>> case were align < sizeof(unsigned long long).
>>
>> Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
>> CC: Russell King <rmk@arm.linux.org.uk>
>> CC: Pekka Enberg <penberg@cs.helsinki.fi>
>> ---
>>  mm/slab.c |    8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/slab.c b/mm/slab.c
>> index c685475..8427901 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -2462,9 +2462,6 @@ __kmem_cache_create (const char *name, size_t size, size_t align,
>>         if (ralign < align) {
>>                 ralign = align;
>>         }
>> -       /* disable debug if necessary */
>> -       if (ralign > __alignof__(unsigned long long))
>> -               flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
>>         /*
>>          * 4) Store it.
>>          */
>> @@ -2491,8 +2488,9 @@ __kmem_cache_create (const char *name, size_t size, size_t align,
>>          */
>>         if (flags & SLAB_RED_ZONE) {
>>                 /* add space for red zone words */
>> -               cachep->obj_offset += sizeof(unsigned long long);
>> -               size += 2 * sizeof(unsigned long long);
>> +               int offset = max(align, sizeof(unsigned long long));
>> +               cachep->obj_offset += offset;
>> +               size += offset + sizeof(unsigned long long);
>>         }
>>         if (flags & SLAB_STORE_USER) {
>>                 /* user store requires one word storage behind the end of
> 
> This piece of code tends to break in peculiar ways every time someone
> touches it. I could use some more convincing in the changelog this
> time it won't...
> 
Ok, is the following changelog is ok ?

The current slab code only allow to put redzone( and user store) info if "buffer
alignment(ralign) <= __alignof__(unsigned long long)". This was done because we
want to keep the buffer aligned for user even after adding redzone@the
beginning of the buffer (the user store is stored after user buffer) [1]

But instead of disabling this feature when "ralign > __alignof__(unsigned long
long)", we can force the alignment by allocating ralign before user buffer.

This is done by setting ralign in obj_offset when "ralign > __alignof__(unsigned
long long)" and keeping the old behavior when  "ralign <= __alignof__(unsigned
long long)" (we set sizeof(unsigned long long)).

The 5c5e3b33b7cb959a401f823707bee006caadd76e commit wasn't handling "ralign <=
__alignof__(unsigned long long)", that's why it broked some configuration.

This was tested on omap3 (ralign is 64 and __alignof__(unsigned long long) is 8)


[1]
/*
 * memory layout of objects:
 * 0        : objp
 * 0 .. cachep->obj_offset - BYTES_PER_WORD - 1: padding. This ensures that
 *      the end of an object is aligned with the end of the real
 *      allocation. Catches writes behind the end of the allocation.
 * cachep->obj_offset - BYTES_PER_WORD .. cachep->obj_offset - 1:
 *      redzone word.
 * cachep->obj_offset: The real object.
 * cachep->buffer_size - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
 * cachep->buffer_size - 1* BYTES_PER_WORD: last caller address
 *                  [BYTES_PER_WORD long]
 */
