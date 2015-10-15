From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 09:57:00 +0100
Subject: [PATCH] ARM: SWP emulation: Restore original *data when failed
In-Reply-To: <20151015083629.GA32630@shlinux2>
References: <1444791077-26020-1-git-send-email-shengjiu.wang@freescale.com>
 <20151015082417.GX32532@n2100.arm.linux.org.uk>
 <20151015083629.GA32630@shlinux2>
Message-ID: <20151015085700.GY32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 04:36:31PM +0800, Shengjiu Wang wrote:
> On Thu, Oct 15, 2015 at 09:24:17AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Oct 14, 2015 at 10:51:17AM +0800, Shengjiu Wang wrote:
> > > __user_swpX_asm maybe failed in first STREX operation, emulate_swpX
> > > will try again, but the *data has been changed in first time. which
> > > cause the result is wrong. So need to recover the *data when failed.
> > > 
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > > ---
> > >  arch/arm/kernel/swp_emulate.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> > > index 5b26e7e..c61fbf92 100644
> > > --- a/arch/arm/kernel/swp_emulate.c
> > > +++ b/arch/arm/kernel/swp_emulate.c
> > > @@ -41,6 +41,7 @@
> > >  	"1:	strex"B"	%0, %2, [%3]\n"			\
> > >  	"	cmp		%0, #0\n"			\
> > >  	"	movne		%0, %4\n"			\
> > > +	"	movne		%1, %2\n"			\
> > >  	"2:\n"							\
> > >  	"	.section	 .text.fixup,\"ax\"\n"		\
> > >  	"	.align		2\n"				\
> > 
> > I think I'd prefer this to be:
> > 
> > 	__asm__ __volatile__(					\
> > 	"0:	ldrex"B"	%2, [%3]\n"			\
> > 	"1:	strex"B"	%0, %1, [%3]\n" 		\
> > 	"	cmp		%0, #0\n"			\
> > 	"	moveq		%1, %2\n"			\
> > 	"	movne		%0, %4\n"			\
> > 
> > so that we're not loading into %1 (an in-out non-temporary) but rather
> > loading it into a temporary - and only overwriting the saved register
> > value if the swap succeeds.
> > 
> > Thanks.
> 
> I am ok with your change. Need I send another patch for this change? or will
> you send it by yourself?

Please send a new patch, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
