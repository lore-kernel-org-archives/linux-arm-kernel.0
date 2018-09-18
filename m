From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 18 Sep 2018 19:36:35 +0200
Subject: [PATCH v6 13/18] khwasan: add bug reporting routines
In-Reply-To: <CACT4Y+aNhNeR==XKQ9gHxt1p-9JS0EkjMSyWtgYi886oumh9rA@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <f39cdef4fde40b6d2ef356db3e0126bda0e1e8c7.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aNhNeR==XKQ9gHxt1p-9JS0EkjMSyWtgYi886oumh9rA@mail.gmail.com>
Message-ID: <CAAeHK+xFV0x3g0_HUp_TtACR1dsjXCGdzFyw0BHEmrwqdXi-Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 7:50 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +#ifdef CONFIG_KASAN_HW
>
> We already have #ifdef CONFIG_KASAN_HW section below with additional
> functions for KASAN_HW and empty stubs otherwise. I would add this one
> there as well.

Will do in v7.

>
>> +void print_tags(u8 addr_tag, const void *addr);
>> +#else
>> +static inline void print_tags(u8 addr_tag, const void *addr) { }
>> +#endif

>> +void *find_first_bad_addr(void *addr, size_t size)
>> +{
>> +       u8 tag = get_tag(addr);
>> +       void *untagged_addr = reset_tag(addr);
>> +       u8 *shadow = (u8 *)kasan_mem_to_shadow(untagged_addr);
>> +       void *first_bad_addr = untagged_addr;
>> +
>> +       while (*shadow == tag && first_bad_addr < untagged_addr + size) {
>
> I think it's better to check that are within bounds before accessing
> shadow. Otherwise it's kinda potential out-of-bounds access ;)
> I know that we _should_ not do an oob here, but still.
> Also feels that this function can be shortened to something like:
>
> u8 tag = get_tag(addr);
> void *p = reset_tag(addr);
> void *end = p + size;
>
> while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
>         p += KASAN_SHADOW_SCALE_SIZE;
> return p;

Will do in v7.
