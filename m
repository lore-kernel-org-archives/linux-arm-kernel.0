From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 18 Sep 2018 19:09:22 +0200
Subject: [PATCH v6 06/18] khwasan, arm64: untag virt address in
 __kimg_to_phys and _virt_addr_is_linear
In-Reply-To: <CACT4Y+aJ36LGLG=TVOGQoJ+fB4Xc9CjdxAs8KZpUm3AsNEoHFw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <19d757c2cafc277f0143a8ac34e179061f3487f5.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aJ36LGLG=TVOGQoJ+fB4Xc9CjdxAs8KZpUm3AsNEoHFw@mail.gmail.com>
Message-ID: <CAAeHK+xBX4X0oxhjOrjJfwdqcvU80VPhUsi38mEczzHRb01Wew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 6:33 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +#ifdef CONFIG_KASAN_HW
>> +#define KASAN_TAG_SHIFTED(tag)         ((unsigned long)(tag) << 56)
>> +#define KASAN_SET_TAG(addr, tag)       (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
>> +                                               KASAN_TAG_SHIFTED(tag))
>> +#define KASAN_RESET_TAG(addr)          KASAN_SET_TAG(addr, 0xff)
>> +#endif
>> +
>
>
> Wouldn't it be better to
> #define KASAN_RESET_TAG(addr) addr
> when CONFIG_KASAN_HW is not enabled, and then not duplicate the macros
> below? That's what we do in kasan.h for all hooks.
> I see that a subsequent patch duplicates yet another macro in this
> file. While we could use:
>
> #define __kimg_to_phys(addr)   (KASAN_RESET_TAG(addr) - kimage_voffset)
>
> with and without kasan. Duplicating them increases risk that somebody
> will change only the non-kasan version but forget kasan version.

Will do in v7.
