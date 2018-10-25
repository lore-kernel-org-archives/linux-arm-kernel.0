From: rafael.tinoco@linaro.org (Rafael David Tinoco)
Date: Thu, 25 Oct 2018 08:03:47 -0300
Subject: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
In-Reply-To: <20181025052901.GA17799@jagdpanzerIV>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
 <20181025052901.GA17799@jagdpanzerIV>
Message-ID: <CABdQkv-wPbgXh-QCJHChguvYsEhgom8M195G+H3GRgButSqMww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 2:29 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (10/24/18 22:27), Rafael David Tinoco wrote:
>>  static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
>>  {
>> -     unsigned long obj;
>> +     unsigned long obj, pfn;
>> +
>> +     pfn = page_to_pfn(page);
>> +
>> +     if (unlikely(OBJ_OVERFLOW(pfn)))
>> +             BUG();
>
> The trend these days is to have less BUG/BUG_ON-s in the kernel.
>
>         -ss

For this case, IMHO, it is worth.

It will avoid a investigation like:
https://bugs.linaro.org/show_bug.cgi?id=3765#c7 and and #c8, where I
had to poison slab allocation - to force both zs_handle and zspage
slabs not to be merged - and to make sure the zspage slab had a good
magic number AND to identify why the bad paging request happened.

If this happens again, for any other arch supporting PAE that does not
declare MAX_POSSIBLE_PHYSMEM_BITS or MAX_PHYSMEM_BITS appropriately,
the kernel will panic, no matter what, by the time it reaches
obj_to_location(). Things can be more complicated about declarations
for PAE if we consider ARM can declare MAX_PHYSMEM_BITS differently in
arch/arm/mach-XXX and/or, for this case, when having, or not SPARSEMEM
set (if I had SPARSEMEM set I would not face this, for example).

If this occurs, the kernel will panic, no matter what, by the time it
reaches obj_to_location()... so why not to BUG() here and let user to
know exactly where it panic-ed and why ? Other option would be to
WARN() here and let it panic naturally because of bad paging request
in a very near future... please advise.

Thanks,
Best Rgds
-Rafael
