From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jul 2016 13:25:21 -0400
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <20160707053710.GH2118@tarshish>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
 <20160707053710.GH2118@tarshish>
Message-ID: <CAGXu5jJV4ZQp4VQ44SPQ49RxXpFXzx6d233A3+_Ka7txYHmuMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2016 at 1:37 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Kees,
>
> On Wed, Jul 06, 2016 at 03:25:20PM -0700, Kees Cook wrote:
>> +#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
>
> Should be CONFIG_HARDENED_USERCOPY to match the slab/slub implementation
> condition.
>
>> +const char *__check_heap_object(const void *ptr, unsigned long n,
>> +                             struct page *page);
>> +#else
>> +static inline const char *__check_heap_object(const void *ptr,
>> +                                           unsigned long n,
>> +                                           struct page *page)
>> +{
>> +     return NULL;
>> +}
>> +#endif

Hmm, I think what I have is correct: if the allocator supports the
heap object checking, it defines __check_heap_object as existing via
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR. If usercopy checking is done
at all is controlled by CONFIG_HARDENED_USERCOPY.

I.e. you can have the other usercopy checks even if your allocator
doesn't support object size checking.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
