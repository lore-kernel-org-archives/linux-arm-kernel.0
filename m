From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Sep 2018 13:53:03 +0100
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
In-Reply-To: <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
 <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
 <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
Message-ID: <20180910125303.dlysg3jba4wv7bhg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 12:33:22PM +0100, Mark Rutland wrote:
> On Fri, Sep 07, 2018 at 06:48:10PM +0300, Andrey Ryabinin wrote:
> > On 09/07/2018 05:56 PM, Will Deacon wrote:
> > > I don't understand this bit: efistub uses the __pi_ prefixed
> > > versions of the routines, so why do we need to declare them as weak?
> > 
> > Weak needed because we can't have two non-weak functions with the same
> > name.
> > 
> > Alternative approach would be to never use e.g. "strlen" name for asm
> > implementation of strlen() under CONFIG_KASAN=y.  But that would
> > require adding some special ENDPIPROC_KASAN() macro since we want
> > __pi_strlen() to point to the asm_strlen().
> 
> Somehow, what we have today works with CONFIG_FORTIFY_SOURCE, which
> AFAICT would suffer from texactly the same problem with things like
> memcpy.
> 
> So either we're getting away with that by chance already (and should fix
> that regardless of this patch), or this is not actually a problem.

I now see those functions are marked weak in the assembly
implementation; sorry for the noise.

Regardless, I still think it's preferable to avoid weak wherever
possible.

I have a couple of local patches to do that for KASAN, though it's not
clear to me how that should interact with FORTIFY_SOURCE.

Thanks,
Mark.
