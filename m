From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 27 Nov 2015 10:07:54 -0800
Subject: [PATCH] null_blk: use sector_div instead of do_div
In-Reply-To: <3768541.ja0r6f0Odi@wuerfel>
References: <3768541.ja0r6f0Odi@wuerfel>
Message-ID: <CA+55aFy=JjwmtNysByu822S2Av0sv_KUCLfa86tAz5K5Unwsmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 5:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> -       do_div(size, bs); /* convert size to pages */
> -       do_div(size, 256); /* concert size to pgs pr blk */
> +       sector_div(size, bs); /* convert size to pages */
> +       sector_div(size, 256); /* concert size to pgs pr blk */

Ugh.

Dividing by 256 should never be done with do_div() *or* sector-div.

Same goes for this, which is just obnoxiously idiotic:

> -       do_div(size, (1 << 16));
> +       sector_div(size, (1 << 16));

WTF? It explicitly divides by a particular power-of-two?

Has nobody ever heard of expensive divide operations? Sure, for the
cases where we *don't* do this with inline asm etc because it's
already fairly cheap, the compiler will DTRT. But that "divide by (1
<< 16)" is just a sign of insanity.

Why is that not just

    size >>= 16;

instead, which is certainly not any less legible, and won't generate
potentially crap code?

                  Linus
