From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 May 2017 18:35:03 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <20170519172934.GI3559@e103592.cambridge.arm.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
 <20170519172934.GI3559@e103592.cambridge.arm.com>
Message-ID: <20170519173503.GX22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:29:34PM +0100, Dave Martin wrote:
> On Fri, May 19, 2017 at 05:59:47PM +0100, Ard Biesheuvel wrote:
> > On 19 May 2017 at 17:46, Dave Martin <Dave.Martin@arm.com> wrote:
> 
> [...]
> 
> > > Spelling it out might be more readable:
> > >
> > >    ARM(                 mov     r0, r0          )
> > >    ARM(                 mov     r0, r0          )
> > >
> > >  THUMB( AR_CLASS(       sub     pc, pc, #3      ))
> > >  THUMB( M_CLASS(        nop.w                   ))
> > >  THUMB(                 .thumb                  )
> > >  THUMB(                 b.w     1f              )
> > >
> > > But I guess it works either way.
> > >
> > 
> > Indeed. Apart from the error in the second line, this sequence should
> > be equivalent, but the nested macro invocations don't make it clearer
> > imo.
> 
> Err, yes.  Actually I means to write
> 
> 	b	1f
> 	mov	r0, r0
> 
> (since executing that nop before branching is presumably pointless).

That "nop" is part of the 8 nops at the start of the image, since the
entry point (due to historical reasons) is at 0x20 into the image.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
