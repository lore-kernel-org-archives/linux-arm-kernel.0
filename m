From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Feb 2014 10:34:15 +0000
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <20140130131247.GG11329@bivouac.eciton.net>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
 <20140122112055.GF1621@mudshark.cambridge.arm.com>
 <20140129182805.GF11329@bivouac.eciton.net>
 <1391029124.2488.50.camel@deneb.redhat.com>
 <20140130131247.GG11329@bivouac.eciton.net>
Message-ID: <20140203103415.GA12187@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 01:12:47PM +0000, Leif Lindholm wrote:
> Oh, that's neat - thanks!
> 
> Well, given that, I can think of two less horrible options:
> 1)
> 	.macro  update_sctlr, tmp:req, set=, clear=
>         mrc	p15, 0, \tmp, c1, c0, 0
> 	.ifnc	\set,
>         orr	\tmp, \set
> 	.endif
> 	.ifnc	\clear,
> 	mvn	\clear, \clear
> 	and	\tmp, \tmp, \clear

Can't you use bic here?

> 	.endif
>         mcr	p15, 0, \tmp, c1, c0, 0
> 	.endm
> 
> With the two call sites in uefi_phys.S as:
> 
> 	ldr	r5, =(CR_M)
> 	update_sctlr	r12, , r5
> and
> 	ldr	r4, =(CR_I | CR_C | CR_M)
> 	update_sctlr	r12, r4

These ldr= could be movs, right?

If so, I definitely prefer this to putting an ldr = into the macro itself
(option 2).

Cheers,

Will
