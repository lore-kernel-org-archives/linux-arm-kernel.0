From: josh.cartwright@ni.com (Josh Cartwright)
Date: Wed, 24 Oct 2012 13:16:56 -0500
Subject: [PATCH v3 3/5] zynq: remove use of CLKDEV_LOOKUP
In-Reply-To: <20121024133231.GA28661@elliptictech.com>
References: <20121024003218.GA31625@beefymiracle.amer.corp.natinst.com>
 <20121024003442.GD31625@beefymiracle.amer.corp.natinst.com>
 <20121024133231.GA28661@elliptictech.com>
Message-ID: <20121024181656.GS20593@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 09:32:32AM -0400, Nick Bowler wrote:
> On 2012-10-23 19:34 -0500, Josh Cartwright wrote:
> > The Zynq support in mainline does not (yet) make use of any of the
> > generic clk or clk lookup functionality.  Remove what is upstream for
> > now, until the out-of-tree implementation is in suitable form for
> > merging.
> > 
> > An important side effect of this patch is that it allows the building of
> > a Zynq kernel without running into unresolved symbol problems:
> > 
> >    drivers/built-in.o: In function `amba_get_enable_pclk':
> >    clkdev.c:(.text+0x444): undefined reference to `clk_enable'
> 
> For the record, I think this was introduced by commit 56a34b03ff427
> ("ARM: versatile: Make plat-versatile clock optional") which forgot to
> select PLAT_VERSATILE_CLOCK on Zynq.  This is not all that surprising,
> because the fact that Zynq "uses" PLAT_VERSATILE is secretly hidden in
> the Makefile.

Yes, indeed.  I did try to fix my problems by having ARCH_ZYNQ select
PLAT_VERSATILE_CLOCK, but I recall running into additional build
problems...

But now that I just tried it again, it all seems to work, barring
Kconfig complaining I've selected PLAT_VERSATILE_CLOCK, but not
PLAT_VERSATILE.  (Having ARCH_ZYNQ select PLAT_VERSATILE, however, leads
to additional build problems).

> Nevertheless, the only feature from versatile that Zynq needed was the
> clock support, so this patch should *also* delete the secret use of
> plat-versatile by removing this line from arch/arm/Makefile:
> 
>   plat-$(CONFIG_ARCH_ZYNQ)	+= versatile

Yes, indeed it should.

Thanks,

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/07b24168/attachment.sig>
