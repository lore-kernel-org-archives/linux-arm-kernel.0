From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 14:09:08 +0100
Subject: [PATCH] mmc: card: modify mmc_getgeo function
In-Reply-To: <m2k48vtr12.fsf@bob.laptop.org>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2ty8520fb.fsf@bob.laptop.org>
	<20110926082814.GA28149@pengutronix.de>
	<m2k48vtr12.fsf@bob.laptop.org>
Message-ID: <20110926130908.GH22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 08:41:13AM -0400, Chris Ball wrote:
> Hi,
> 
> On Mon, Sep 26 2011, Uwe Kleine-K?nig wrote:
> >> Thanks, pushed to mmc-next for 3.2 with a reworded commit message:
> > This (i.e. ee9e0e0 (mmc: card: Remove duplicated constants) in next)
> > makes gcc emit a reference to __aeabi_uldivmod in one of my nightly
> > builds which isn't defined.
> >
> > The final linking stage fails with:
> >
> > 	  LD      .tmp_vmlinux1
> > 	drivers/built-in.o: In function `mmc_blk_getgeo':
> > 	clkdev.c:(.text+0xd1528): undefined reference to `__aeabi_uldivmod'
> > 	make[2]: *** [.tmp_vmlinux1] Error 1
> > 	make[1]: *** [sub-make] Error 2
> > 	make: *** [all] Error 2
> 
> Interesting, thanks.  It builds fine here on my (gcc-4.6) ARM toolchains.
> Looking online, I think you're hitting an old gcc-4.3 bug?

Check your setting of CONFIG_LBDAF - the return type from get_capacity
depends on this (which may be either unsigned long or u64).

Now, the thing about a constant division by (16*4) is that its relatively
easy for gcc to spot that this is the same as a shift - and use a shift
instead of a divide for both the unsigned long and u64 cases.

However, the change may result in gcc no longer realizing that it's a
constant division by a power-of-2, and that optimization can be applied.

If you want to eliminate these constants, I'd suggest two definitions

	MMC_GEO_SECTORS
	MMC_GEO_HEADS

and just subsituting the '4' and '16' in the function with the appropriate
symbolic constants.  That'd avoid causing this regression.
