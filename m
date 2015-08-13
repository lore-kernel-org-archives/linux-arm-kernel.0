From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 12 Aug 2015 20:28:08 -0700
Subject: enabling libgcc for 64-bit divisions, was Re: PROBLEM: XFS on
 ARM corruption 'Structure needs cleaning'
In-Reply-To: <55CBC6C6.3090306@kernel.org>
References: <5579B804.9050707@skylable.com>
 <20150612122108.GB60661@bfoster.bfoster>
 <557AD4D4.3010901@skylable.com> <20150612225209.GA20262@dastard>
 <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
 <20150812062445.GA4520@infradead.org>
 <CA+55aFxcoXkaa1syBVxwb9-bn3rfyFam9fcNY438bkhHjHq+Vw@mail.gmail.com>
 <55CBC6C6.3090306@kernel.org>
Message-ID: <20150812202808.abe0c080.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Aug 2015 15:20:54 -0700 Andy Lutomirski <luto@kernel.org> wrote:

> On 08/12/2015 08:49 AM, Linus Torvalds wrote:
> > On Tue, Aug 11, 2015 at 11:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> Maybe it's time to rely on gcc to handle 64 bit divisions now?
> >
> > Ugh. gcc still does a pretty horrible job at it. While gcc knows that
> > a widening 32x32->64 multiplication can be simplified, it doesn't do
> > the same thing for a 64/32->64 division, and always calls __udivdi3
> > for it.
> >
> > Now, __udivdi3 does avoid the general nasty case by then testing the
> > upper 32 bits of the divisor against zero, so it's not entirely
> > disastrous. It's just ugly.
> >
> > But perhaps more importantly, I'm not at all sure libgcc is
> > kernel-safe. In particular, I'm not at all sure it *remains*
> > kernel-safe. Just as an example: can you guarantee that libgcc doesn't
> > implement integer division on some architecture by using the FP
> > hardware?
> >
> > There's been a few cases where not having libgcc saved us headaches. I
> > forget the exact details, but it was something like several years ago
> > that we had gcc start to generate some insane crap exception handling
> > for C code generation, and the fact that we didn't include libgcc was
> > what made us catch it because of the resulting link error.
> >
> > libgcc just isn't reliable in kernel space. I'm not opposed to some
> > random architecture using it (arch/tile does include "-lgcc" for
> > example), but I _do_ object to the notion that we say "let's use
> > libgcc in general".
> >
> > So no. I do not believe that the occasional pain of a few people who
> > do 64-bit divides incorrectly is a good enough argument to start using
> > libgcc.
> >
> 
> Does your objection still apply if we supplied our own implementations 
> of a handful of libgcc helpers?

It's not just a matter of "how fast is the divide".  The 32-bit build
error is supposed to prompt people to ask "did I really need to use 64
bits".

That *used* to work.  A bit.  But nowadays the errors are detected so
late that the fix (often by someone other than the original developer)
is to just slap a do_div() in there.

And as the build error no longer appears to be having the desired
effect, I too have been wondering if it's time to just give up and
implement __udivdi and friends.

Or maybe there's a way of breaking 64-bit builds instead ;)
