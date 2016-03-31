From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 31 Mar 2016 11:30:24 +0100
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: <56FCD815.7000503@rdamicro.com>
References: <1459138743-10477-1-git-send-email-chengang.beijing@gmail.com>
 <3792990.eCI4tPEEyD@wuerfel>
 <20160329102605.GC3701@e103592.cambridge.arm.com>
 <20160329103418.GX19428@n2100.arm.linux.org.uk>
 <20160329105637.GD3701@e103592.cambridge.arm.com>
 <56FB4784.1060105@rdamicro.com>
 <20160330140718.GG3701@e103592.cambridge.arm.com>
 <56FCD815.7000503@rdamicro.com>
Message-ID: <20160331103020.GH3701@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 07:56:05AM +0000, ??(Gangchen) wrote:
> On 03/30/2016 10:07 PM, Dave Martin wrote:
> > On Wed, Mar 30, 2016 at 03:27:01AM +0000, ??(Gangchen) wrote:
> >> On 03/29/2016 06:56 PM, Dave Martin wrote:

[...]

> >>> I wonder whether the following would be cleaner than having these
> >>> aliased arguments:
> >>>
> >>> 	asm(	/* ... */
> >>> 		"bl	__do_div64"
> >>> 		: "+r" (__n), "=r" (__res)
> >>> 		: "r" (__base)
> >>> 		: "ip", "lr", "cc");
> >>> 	*n = __res;
> >>> 	return __n >> 32;
> >>>
> >>> (providing that GCC doesn't make a mess of the "easy" shift).
> >> I tried your proposal. It didn't make any difference: this is inline
> >> function and gcc just ignores your trick.
> > What doesn't work for you when using this method?
> >
> > Why does the fact that this is an inline function make a difference?
> With the help of other colleagues, I understand your proposal now.
> I create a patch and I can verify that it works!

Ah, OK.  I was wondering whether I made a mistake somewhere.

> Should I submit it, as it seems better than this one I sent?

It's up to you -- I think my approach is a bit cleaner, but your
approach worked too and is not vulnerable to compilers that generate
silly code for (uint64_t) >> 32.

Note that I only tested my code for little endian -- it should do the
right thing for BE, but I recommend that you try it and examine the
generated code, to make sure.

Cheers
---Date
