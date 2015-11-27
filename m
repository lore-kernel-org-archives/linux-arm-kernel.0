From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 22:31:26 +0100
Subject: [PATCH] null_blk: use sector_div instead of do_div
In-Reply-To: <CA+55aFy=JjwmtNysByu822S2Av0sv_KUCLfa86tAz5K5Unwsmw@mail.gmail.com>
References: <3768541.ja0r6f0Odi@wuerfel>
 <CA+55aFy=JjwmtNysByu822S2Av0sv_KUCLfa86tAz5K5Unwsmw@mail.gmail.com>
Message-ID: <4449032.oPBtpzlXyB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 November 2015 10:07:54 Linus Torvalds wrote:
> On Fri, Nov 27, 2015 at 5:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > -       do_div(size, bs); /* convert size to pages */
> > -       do_div(size, 256); /* concert size to pgs pr blk */
> > +       sector_div(size, bs); /* convert size to pages */
> > +       sector_div(size, 256); /* concert size to pgs pr blk */
> 
> Ugh.
> 
> Dividing by 256 should never be done with do_div() *or* sector-div.

You are right, I missed what should have been an obvious simplification.
FWIW, the division by 256 should now be optimized automatically when the
new asm-generic do_div() implementation is used (which in turn caused
the type mismatch warning that I'm trying to avoid). Of course that
is no excuse for writing silly code like that, and it doesn't catch the
cases where the argument is a power-of-two variable number.

The first do_div() is also questionable: 'bs' is a global variable
from a module parameter that defaults to 512 and is fixed to 4096
when the device is used for lightnvm. I would guess that we run into
bugs if this is ever set to a number that is not a power of two,
smaller than 512, or larger than PAGE_SIZE.

> Same goes for this, which is just obnoxiously idiotic:
> 
> > -       do_div(size, (1 << 16));
> > +       sector_div(size, (1 << 16));
> 
> WTF? It explicitly divides by a particular power-of-two?
> 
> Has nobody ever heard of expensive divide operations? Sure, for the
> cases where we *don't* do this with inline asm etc because it's
> already fairly cheap, the compiler will DTRT. But that "divide by (1
> << 16)" is just a sign of insanity.
> 
> Why is that not just
> 
>     size >>= 16;
> 
> instead, which is certainly not any less legible, and won't generate
> potentially crap code?

I'll wait for Matias or Jens to comment on the blocksize, but can
do a new patch unless they beat me to it.

	Arnd
