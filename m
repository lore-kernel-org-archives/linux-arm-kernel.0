From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Apr 2017 14:34:47 +0100
Subject: [PATCH] arm64: prefetch: Change assembly to be compatible with
 gcc and clang
In-Reply-To: <20170420084206.GB31436@leverpostej>
References: <20170419212211.95803-1-mka@chromium.org>
 <20170420084206.GB31436@leverpostej>
Message-ID: <20170424133447.GA12323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 09:42:07AM +0100, Mark Rutland wrote:
> On Wed, Apr 19, 2017 at 02:22:11PM -0700, Matthias Kaehlcke wrote:
> > clang fails to build with the current code:
> > 
> > arch/arm64/include/asm/processor.h:172:15: error: invalid operand in
> > inline asm: 'prfm pldl1keep, ${0:a}'
> > 
> > Apparently clang does not support the 'a' modifier. Change the
> > constraint from 'p' ('An operand that is a valid memory address is
> > allowed') to 'Q' ('A memory address which uses a single base register
> > with no offset'), which works for both gcc and clang.
> 
> It looks like the current %a0 template and p constraint were inherited
> from arch/arm, as they've been there from day one on arm64.
> 
> Looking at the arch/arm history, the "a" operand modifier and "p"
> constraint were introduced in commit:
> 
>   16f719de62809e22 ("[ARM] 5196/1: fix inline asm constraints for preload")
> 
> ... so as to avoid GCC assuming prefetch of a pointer implied it was not
> NULL. Until that point, we'd used no operand modifier and "o"
> constraint.
> 
> It's not clear to me whether "o", "p", and "Q" constraints differ in
> this regard on AArch64, or if the issue regarding NULL is still
> relevant. The GCC docs say the "p" constraint is used for "a valid
> memory address", which does sound like it shouldn't be NULL.
> 
> Otherwise, this does look consistent with what we do elsewhere.

I really don't like using 'Q' here, for two reasons:

1. It means we likely allocate a register where we don't need to, because
   we're going to need to use [Xn] as the addressing mode, which means
   adding any immediate offsets.

2. As you mention, 16f719de62809e22 says that GCC will use this as an
   indication that the address is non-NULL.

We also can't just remove the 'a', because that will result in assembly
failures. I haven't dug into exactly why, but I suspect it's because "p"
can generate a label, which then won't assemble if surrounded by '[]'.

Will
