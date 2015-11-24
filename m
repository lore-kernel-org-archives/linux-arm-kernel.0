From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Nov 2015 14:45:16 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <yw1xoaejr3u6.fsf@unicorn.mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <3811106.btnGdZynet@wuerfel> <yw1xoaejr3u6.fsf@unicorn.mansr.com>
Message-ID: <2604538.XjBEKvm9od@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 November 2015 12:15:13 M?ns Rullg?rd wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Monday 23 November 2015 15:13:52 Stephen Boyd wrote:
> >> On 11/23, Arnd Bergmann wrote:
> >> > On Monday 23 November 2015 13:32:06 Stephen Boyd wrote:
> >> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >> > index b251013eef0a..bad6343c34d5 100644
> >> Do you have the information on these custom opcodes? I can work
> >> that into the patches assuming the MIDR is different.
> >
> > Thomas Petazzoni said this in a private mail:
> >
> > | According to the datasheet, the PJ4B has integer signed and unsigned
> > | divide, similar to the sdiv and udiv ARM instructions. But the way to
> > | access it is by doing a MRC instruction.
> > |
> > |    MRC<cond> p6, 1, Rd , CRn , CRm, 4
> > |
> > |for PJ4B is the same as:
> > |
> > |    SDIV Rd , Rn, Rm
> > |
> > | on ARM cores.
> > |
> > |And:
> > |
> > |    MRC<cond> p6, 1, Rd , CRn , CRm, 0
> > |
> > |for PJ4B is the same as:
> > |
> > |    UDIV Rd , Rn, Rm
> > |
> > |on ARM cores.
> > |
> > |This is documented in the "Extended instructions" section of the
> > |PJ4B datasheet.
> >
> > I assume what he meant was that this is true for both PJ4 and PJ4B
> > but not for PJ4B-MP, which has the normal udiv/sdiv instructions.
> >
> > IOW, anything with CPU implementer 0x56 part 0x581 should use those,
> > while part 0x584 can use the sdiv/udiv that it reports correctly.
> 
> Or we could simply ignore those and they'd be no worse off than they are
> now.

Well, if we add all the infrastructure to do dynamic patching, we
might as well use it here, that is a very little extra effort.

I'm not convinced that the dynamic patching for idiv is actually needed
but I'm not objecting either, and Stephen has done the work already.

	Arnd
