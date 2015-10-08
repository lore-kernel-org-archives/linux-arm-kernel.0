From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 8 Oct 2015 17:50:26 +0200
Subject: enabling libgcc for 64-bit divisions, was Re: PROBLEM: XFS on
 ARM corruption 'Structure needs cleaning'
In-Reply-To: <CA+55aFxcoXkaa1syBVxwb9-bn3rfyFam9fcNY438bkhHjHq+Vw@mail.gmail.com>
References: <5579B804.9050707@skylable.com>
 <20150612122108.GB60661@bfoster.bfoster>
 <557AD4D4.3010901@skylable.com> <20150612225209.GA20262@dastard>
 <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
 <20150812062445.GA4520@infradead.org>
 <CA+55aFxcoXkaa1syBVxwb9-bn3rfyFam9fcNY438bkhHjHq+Vw@mail.gmail.com>
Message-ID: <20151008155025.GD11776@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed 2015-08-12 08:49:45, Linus Torvalds wrote:
> On Tue, Aug 11, 2015 at 11:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Maybe it's time to rely on gcc to handle 64 bit divisions now?
> 
> Ugh. gcc still does a pretty horrible job at it. While gcc knows that
> a widening 32x32->64 multiplication can be simplified, it doesn't do
> the same thing for a 64/32->64 division, and always calls __udivdi3
> for it.
> 
> Now, __udivdi3 does avoid the general nasty case by then testing the
> upper 32 bits of the divisor against zero, so it's not entirely
> disastrous. It's just ugly.
> 
> But perhaps more importantly, I'm not at all sure libgcc is
> kernel-safe. In particular, I'm not at all sure it *remains*
> kernel-safe. Just as an example: can you guarantee that libgcc doesn't

U-Boot relies on toolchain-provided libgcc by default, and one of reasons
we do that is so that libgcc stays sane. Yes, there's occasionally some fun
with that.

But if kernel did that, at least U-Boot would not be alone with the fun.

									Pavel
