From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Oct 2014 21:50:23 +0200
Subject: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <vnkwoatjn1zm.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
 <2434048.k6JtGScJfe@wuerfel> <vnkwoatjn1zm.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <1922221.DKAGMVXrIn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 October 2014 12:44:45 Mitchel Humpherys wrote:
> >> Regarding the division, for the overwhelmingly common case where the
> >> user of the API passes in a constant for sleep_us the compiler optimizes
> >> out this calculation altogether and just sticks the final result in (I
> >> verified this with gcc 4.9 and the kernel build system's built-in
> >> support for generating .s files).  Conveying semantic meaning by using
> >> `DIV_ROUND_UP' is nice but if you feel strongly about it we can make
> >> this a shift instead.
> >
> > The more important question is probably if you want to keep the _ROUND_UP
> > part. If that's not significant, I think a shift would be better.
> 
> If we drop the _ROUND_UP then passing a sleep_us <= 4 would result in a
> minimum sleep time of 0, so we'd be polling a lot faster than the user
> had expected.

How about changing the semantics to sleep at least the sleep_us time,
and at most four times that? This would turn the expensive division into
a multiplication and avoid the need for rounding.

If there are important reasons to keep doing the division, you could
instead use '(sleep_us >> 4) + 1', which is also very cheap to compute
and avoids the problem you mention.

	Arnd
