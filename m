From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Dec 2015 10:44:18 +0000
Subject: [PATCH V2] ARM: SWP emulation: Restore original *data when failed
In-Reply-To: <5666AF7D.5000703@arm.com>
References: <726a7ce88982fba5df84e4d22b083e39b57a6bc6.1444900732.git.shengjiu.wang@freescale.com>
 <5666AF7D.5000703@arm.com>
Message-ID: <20151208104418.GB8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 10:22:53AM +0000, Vladimir Murzin wrote:
> On 15/10/15 10:30, Shengjiu Wang wrote:
> > __user_swpX_asm maybe failed in first STREX operation, emulate_swpX
> > will try again, but the *data has been changed in first time. which
> > causes the result is wrong.
> > This patch is to fix this issue. When STREX succeed, change the *data.
> > if it fail, *data is not changed.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > ---
> >  arch/arm/kernel/swp_emulate.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> > index 5b26e7e..c3fe769d 100644
> > --- a/arch/arm/kernel/swp_emulate.c
> > +++ b/arch/arm/kernel/swp_emulate.c
> > @@ -36,10 +36,10 @@
> >   */
> >  #define __user_swpX_asm(data, addr, res, temp, B)		\
> >  	__asm__ __volatile__(					\
> > -	"	mov		%2, %1\n"			\
> > -	"0:	ldrex"B"	%1, [%3]\n"			\
> > -	"1:	strex"B"	%0, %2, [%3]\n"			\
> > +	"0:	ldrex"B"	%2, [%3]\n"			\
> > +	"1:	strex"B"	%0, %1, [%3]\n"			\
> >  	"	cmp		%0, #0\n"			\
> > +	"	moveq		%1, %2\n"			\
> >  	"	movne		%0, %4\n"			\
> >  	"2:\n"							\
> >  	"	.section	 .text.fixup,\"ax\"\n"		\
> > 
> 
> I wonder what is status of this patch? I see that arm64 counterpart has
> landed in mainline, but I didn't manage to track down this one - is it
> because it never been submitted to patch system?

Most probably.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
