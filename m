From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 10:24:58 +0000
Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	withCONFIG_THUMB2_KERNEL
In-Reply-To: <alpine.LFD.2.00.1012071412260.10437@xanadu.home>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
	<AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
	<AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
	<AANLkTi=7MXKUwjyPgDBO9XV-CZw7RNOmWKj0JP_kB9aC@mail.gmail.com>
	<AANLkTin4oiDGqMJqjYO+5pCM4MffiGiTEKW5WxXx9gfg@mail.gmail.com>
	<alpine.LFD.2.00.1012071412260.10437@xanadu.home>
Message-ID: <AANLkTikVHOgujYh+28TFJDQbHx=AXT_5354bTy9+FLVR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 7, 2010 at 7:15 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 7 Dec 2010, Dave Martin wrote:
>
>> On Tue, Dec 7, 2010 at 2:53 PM, Dave Martin <dave.martin@linaro.org> wrote:
>> [...]
>> > Note that converting to C doesn't mean that code which attempts to
>> > copy function bodies will work: you still need to handle the fact that
>> > if f() is a C function symbol, then the value of the symbol f is
>> > actually the function's base address + 1. ?See my changes in sram.c,
>>
>> To clarify, this applies *if* f is a Thumb symbol.
>
> To make it generic, a new macro could be used:
>
> #define SYM_ADDR(x) ((void *)((long)(x) & ~1L))

Could do ... I wasn't sure if it was useful for just this one case,
but I guess we may encounter others.  And it would make the code a lot
less messy...

if so, a macro for exracting just the Thumb bit, and a macro for
rebasing a symbol while preserving the Thumb bit could also be useful.

#define SYM_STATE(x) ((long)(x) & 1)
#define SYM_REBASE(new_addr, sym) ((void *)((long)SYM_ADDR(new_addr) |
SYM_STATE(sym)))

The relationship could be a bit clearer if we use the name SYM_BASE
instead of SYM_ADDR.

With these, the affected code becomes something like:

memcpy(buffer, SYM_BASE(f), size_of_f);
new_f = SYM_REBASE(f, buffer);

What do you think?

Is there a recommended type for a pointer-sized integer?  I notice
linux/types.h defines uintptr_t (as unsigned long).

Cheers
---Dave
