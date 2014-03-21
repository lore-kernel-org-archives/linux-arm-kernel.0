From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Mar 2014 15:32:24 +0100
Subject: [PATCH 10/62] ARM: efm32: select AUTO_ZRELADDR
In-Reply-To: <6295310.bvZ6PIzM4N@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-11-git-send-email-arnd@arndb.de>
 <20140320204847.GD23076@pengutronix.de>
 <6295310.bvZ6PIzM4N@wuerfel>
Message-ID: <20140321143224.GF23076@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Thu, Mar 20, 2014 at 11:16:20PM +0100, Arnd Bergmann wrote:
> On Thursday 20 March 2014 21:48:47 Uwe Kleine-K?nig wrote:
> > 
> > On Wed, Mar 19, 2014 at 08:29:07PM +0100, Arnd Bergmann wrote:
> > > The efm32 platform does not provide a zreladdr-y line its Makefile.boot,
> > > so we always have to use CONFIG_AUTO_ZRELADDR in order to successfully
> > > build and link a zImage.
> > I wonder why you need to AUTO_ZRELADDR (which is there to guess
> > zreladdr) while efm32 doesn't have an MMU and so there is nothing to
> > guess. So I think this patch fixes a build problem, but it's not a good
> > change.
> 
> It is required in order to build a compressed zImage file. You mentioned
> before that your system does not have enough RAM to support this, but
> the compile-time option exists, and there is no dependency on MMU support
> for it, nor should there be.
My objection isn't about having only little RAM. AUTO_ZRELADDR is about
guessing the physical address corresponding to PAGE_OFFSET. But without
an MMU there is nothing to guess. So I wonder if the better change would
be to do:

	#ifdef CONFIG_MMU
	#ifdef CONFIG_AUTO_ZRELADDR
		... guess zreladdress based on instruction pointer
	#else
		... use zreladdr from Makefile.boot
	#endif
	#else
		... use zreladdr = PAGE_OFFSET
	#endif

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
