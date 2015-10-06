From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Oct 2015 12:22:03 +0100
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <5340366.WTVksOGb0G@wuerfel>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <5022096.8QRzW0l3EJ@wuerfel>
 <20151006103128.GN6281@e103592.cambridge.arm.com>
 <5340366.WTVksOGb0G@wuerfel>
Message-ID: <20151006112203.GO6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 12:51:24PM +0200, Arnd Bergmann wrote:
> On Tuesday 06 October 2015 11:31:34 Dave Martin wrote:
> > On Tue, Oct 06, 2015 at 09:49:29AM +0200, Arnd Bergmann wrote:
> 
> > > * Can you explain in the changelog how the numbers were decided?
> > >   I don't see any other architecture using 5kb and cannot see why
> > >   it has to be this value rather than something else.
> > 
> > glibc quietly "fixed" this earlier this year, by inventing these numbers
> > and putting them in the glibc headers. [1]
> 
> I saw the commit, but the changelog is not really useful.
> 
> > Except for a moribund architecture that will never be extended I
> > think that the idea of MINSIGSTKSZ is badly flawed -- a #define
> > for not-necessarily-quite-enough-stack-to-realistically-take-a-signal
> > is a pretty useless concept even if the signal frame never grows, and
> > it looks like it is little used in practice.
> 
> Right, even if we modified the constants in the kernel/glibc
> headers at that point, it would remain broken for new kernels
> and old user space.
> 
> > Since this bug hasn't been reported until now, I suspect that
> > MINSIGSTKSZ is used very rarely or not at all by real userspace
> > software.  I wonder whether we can get away with simply raising
> > MINSIGSTKSZ to match SIGSTKSZ, since it's clear that any software
> > using MINSIGSTKSZ was already broken.
> 
> I think it makes sense to stick with the traditional definition
> of MINSIGSTKSZ == "the minimum amount that you will always need,
> add whatever you require yourself" and SIGSTKSZ == "Should be
> enough for a couple of function calls". If we want to be conservative
> in the kernel, using 8192 and 32768, to stay with the x4 ratio

That "x4" only makes sense if you expect to put copies of the signal
frame on the stack during handling -- otherwise the extra overhead
won't scale proportional to MINSIGSTKSZ at all.  OTOH there's no
better answer I can think of...

> that everyone else uses would be my first pick, though I'm not
> particularly attached to those values.

Maybe we could do something like that as a stopgap solution, while
coming up with a runtime discovery mechanism independently of this
patch.  The latter would require some buy-in from glibc, so I guess
it couldn't happen overnight.

Cheers
---Dave
