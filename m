From: rafael.tinoco@linaro.org (Rafael David Tinoco)
Date: Thu, 25 Oct 2018 09:37:59 -0300
Subject: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
In-Reply-To: <20181025120006.GY30658@n2100.armlinux.org.uk>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
 <20181025120006.GY30658@n2100.armlinux.org.uk>
Message-ID: <CABdQkv_cC4ixEFr91zyg-S21O5_7U8FV7=g7ZMRqGcQyhrwzaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> MAX_PHYSMEM_BITS is a definition for sparsemem, and is only visible
> when sparsemem is enabled.  When sparsemem is disabled, asm/sparsemem.h
> is not included (and should not be included) which means there is no
> MAX_PHYSMEM_BITS definition.

Missed that part :\, tks.

> I don't think zsmalloc.c should be (ab)using MAX_PHYSMEM_BITS, and
> your description above makes it sound like you expect it to always be
> defined.
>
> If we want to have a definition for this, we shouldn't be playing
> fragile games like:
>
> #ifndef MAX_POSSIBLE_PHYSMEM_BITS
> #ifdef MAX_PHYSMEM_BITS
> #define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
> #else
> /*
>  * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
>  * be PAGE_SHIFT
>  */
> #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
> #endif
> #endif
>
> but instead insist that MAX_PHYSMEM_BITS is defined _everywhere_.

Is it okay to propose using only MAX_PHYSMEM_BITS for zsmalloc (like
it was before commit 02390b87) instead, and make sure *at least* ARM
32/64 and x86/x64, for now, have it defined outside sparsemem headers
as well ? This way I can WARN_ONCE(), instead of BUG(), when specific
arch does not define it - enforcing behavior - showing BITS_PER_LONG
is being used instead of MAX_PHYSMEM_BITS (warning, at least once, for
the possibility of an overflow, like the issue showed in here).
