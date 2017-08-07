From: keescook@chromium.org (Kees Cook)
Date: Mon, 7 Aug 2017 14:44:22 -0700
Subject: [kernel-hardening] [PATCH] lkdtm: Test VMAP_STACK allocates
 leading/trailing guard pages
In-Reply-To: <CAKv+Gu-DUk9xqzpWt_FNBzpbLhdi9Cc5vU5J-tZZ4b8wD87UTQ@mail.gmail.com>
References: <20170807203948.GA22298@beast>
 <CAKv+Gu-DUk9xqzpWt_FNBzpbLhdi9Cc5vU5J-tZZ4b8wD87UTQ@mail.gmail.com>
Message-ID: <CAGXu5jL27FsZLi_L-mJnySe3H_3LiyFr2Odav+Xm=xhOHc25uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 2:27 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 7 August 2017 at 21:39, Kees Cook <keescook@chromium.org> wrote:
>> Two new tests STACK_GUARD_PAGE_LEADING and STACK_GUARD_PAGE_TRAILING
>> attempt to read the byte before and after, respectively, of the current
>> stack frame, which should fault under VMAP_STACK.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Do these tests both trip with the new arm64 VMAP_STACK code?
>
> Probably not. On arm64, the registers are stacked by software at
> exception entry,  and so we decrement the sp first by the size of the
> register file, and if the resulting value overflows the stack, the
> situation is handled as if the exception was caused by a faulting
> stack access while it may be caused by something else in reality.
> Since the act of handling the exception is guaranteed to overflow the
> stack anyway, this does not really make a huge difference, and it
> prevents the recursive fault from wiping the context that we need to
> produce the diagnostics.
>
> This means an illegal access right above the stack will go undetected.

I thought vmap entries provided guard pages around allocations?
Shouldn't that catch it?

-- 
Kees Cook
Pixel Security
