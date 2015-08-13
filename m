From: linux@horizon.com (George Spelvin)
Date: 13 Aug 2015 14:18:41 -0400
Subject: enabling libgcc for 64-bit divisions,
 was Re: PROBLEM: XFS on ARM corruption 'Structure needs cl
In-Reply-To: <CA+55aFwgaq3KkeXGQWxmVHsNVwJUWK3WssJ5_ADpQG4zTXjWPQ@mail.gmail.com>
Message-ID: <20150813181841.10342.qmail@ns.horizon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not convinced that "64/32->32" is all that generic, though.  If
> the dividend in 64-bit, there's no fundamental type-based guarantee
> that things will fit.

I agree that it's impossible to decide based on the types, but having
that knowledge is extremely common.  Which is why it would be nice
to have a way for the programmer to communicate that knowledge.

> So your case is rather special, and depends (intimately) on knowing
> the actual ranges and how they interact.

Actually, it's the most common case.  Going through "git grep -w do_div",
by far the *majority* of all calls to do_div immediately convert the
result to 32 bits (or unsigned long), with no overflow checking.

Partially that's because I'm cointing static code frequency and there
are a ridiculous number of different PLL drivers, but still.

On x86, the case that msword >= divsor causes a divide exception
(divide ba generalization of divide by zero), so it's tempting
to do the same sort of "assume no trap and fix up in the handler"
trick as <asm/uaccess.h>.


There are only 854 references to do_div in the kernel, so
doing a sweep over all of them is quite practical.

One function that would cover a significant number of use cases
(but not all, damn it) would be

rem = do_mul_div(x, mul,_div)

Which returns x * mul / div, with a 64-bit intermediate.
