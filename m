From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Feb 2014 16:00:51 +0000
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <20140203155542.GI11329@bivouac.eciton.net>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
 <20140122112055.GF1621@mudshark.cambridge.arm.com>
 <20140129182805.GF11329@bivouac.eciton.net>
 <1391029124.2488.50.camel@deneb.redhat.com>
 <20140130131247.GG11329@bivouac.eciton.net>
 <20140203103415.GA12187@mudshark.cambridge.arm.com>
 <20140203155542.GI11329@bivouac.eciton.net>
Message-ID: <20140203160051.GG14112@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 03:55:42PM +0000, Leif Lindholm wrote:
> On Mon, Feb 03, 2014 at 10:34:15AM +0000, Will Deacon wrote:
> > On Thu, Jan 30, 2014 at 01:12:47PM +0000, Leif Lindholm wrote:
> > > Oh, that's neat - thanks!
> > > 
> > > Well, given that, I can think of two less horrible options:
> > > 1)
> > > 	.macro  update_sctlr, tmp:req, set=, clear=
> > >         mrc	p15, 0, \tmp, c1, c0, 0
> > > 	.ifnc	\set,
> > >         orr	\tmp, \set
> > > 	.endif
> > > 	.ifnc	\clear,
> > > 	mvn	\clear, \clear
> > > 	and	\tmp, \tmp, \clear
> > 
> > Can't you use bic here?
> 
> Yeah.
> 
> > > 	.endif
> > >         mcr	p15, 0, \tmp, c1, c0, 0
> > > 	.endm
> > > 
> > > With the two call sites in uefi_phys.S as:
> > > 
> > > 	ldr	r5, =(CR_M)
> > > 	update_sctlr	r12, , r5
> > > and
> > > 	ldr	r4, =(CR_I | CR_C | CR_M)
> > > 	update_sctlr	r12, r4
> > 
> > These ldr= could be movs, right?
> 
> The first one could.
> The second one could be movw on armv7+.
> 
> > If so, I definitely prefer this to putting an ldr = into the macro itself
> > (option 2).
> 
> And your preference between 1) and 2) is?

(1), using bic and mov[tw] where possible.

Will
