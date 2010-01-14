From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 14 Jan 2010 09:29:52 +0100
Subject: [PATCH] ARM: Fix uncompress code compile for different
	definesof static(void)
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089C39@mi8nycmail19.Mi8.com>
References: <20100113021939.GE2986@atomide.com>
	<20100113084937.GA19352@pengutronix.de>
	<BD79186B4FD85F4B8E60E381CAEE190902089C39@mi8nycmail19.Mi8.com>
Message-ID: <20100114082952.GA657@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hartley,

On Wed, Jan 13, 2010 at 01:11:49PM -0500, H Hartley Sweeten wrote:
> On Wednesday, January 13, 2010 1:50 AM, Uwe Kleine-K?nig wrote:
> >> Also use a static inline function instead of define
> >> for mach-mxc and mach-gemini to avoid similar bug
> >> for those platforms.
> > As arch/arm/boot/compressed/misc.c is compiled with -Dstatic= and this
> > is AFAIK the only user of uncompress.h I'd skip "static" and/or add a
> > comment telling that static is redundant here.
> 
> So that's what causes the sparse warning!
> 
> Compiling misc.c produces a bunch of sparse warnings to the type:
> 
> arch/arm/boot/compressed/misc.c:19:14: warning: symbol '__machine_arch_type' was not declared. Should it be static?
> arch/arm/mach-ep93xx/include/mach/uncompress.h:75:13: warning: symbol 'ethernet_reset' was not declared. Should it be static?
> arch/arm/mach-ep93xx/include/mach/uncompress.h:109:13: warning: symbol 'enable_early_uart' was not declared. Should it be static?
> arch/arm/mach-ep93xx/include/mach/uncompress.h:152:13: warning: symbol 'arch_decomp_setup' was not declared. Should it be static?
> arch/arm/boot/compressed/misc.c:201:12: warning: symbol 'inbuf' was not declared. Should it be static?
> arch/arm/boot/compressed/misc.c:202:12: warning: symbol 'window' was not declared. Should it be static?
> arch/arm/boot/compressed/misc.c:204:17: warning: symbol 'insize' was not declared. Should it be static?
> arch/arm/boot/compressed/misc.c:205:17: warning: symbol 'inptr' was not declared. Should it be static?
> arch/arm/boot/compressed/misc.c:206:17: warning: symbol 'outcnt' was not declared. Should it be static?
> 
> Etc..
> 
> Any ideas on how to suppress the warnings?
I think the cleanest solution would be to remove -Dstatic=.  I don't
know the exact reason for it being there.  The best reference I found is

	http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg97485.html

Russell, maybe these toolchain problems are gone in the meantime?  Some
time ago I tried removing that and the decompressor was still
functional---which doesn't mean it's save in all situations with all
toolchains.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
