From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 02 Dec 2012 10:02:03 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gQVJNOiBpeHA0eHg6IEFkZCAiYXNrIiBoYW5kbGVy?=
 =?UTF-8?B?IGZvciB0aW1lciBpbnRlcnJ1cHRz?=
In-Reply-To: <201212020011.42105.arnd@arndb.de>
References: <1354347213-22237-1-git-send-email-shc_work@mail.ru>
 <20121201214525.GI12509@titan.lakedaemon.net>
 <201212020011.42105.arnd@arndb.de>
Message-ID: <1354428123.119115041@f313.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Saturday 01 December 2012, Jason Cooper wrote:
> > On Sat, Dec 01, 2012 at 09:25:51PM +0000, Arnd Bergmann wrote:
> > > On Saturday 01 December 2012, Alexander Shiyan wrote:
> > > > +       switch (d->irq) {
> > > > +       case IRQ_IXP4XX_TIMER1:
> > > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
> > > > +               break;
> > > > +       case IRQ_IXP4XX_TIMER2:
> > > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
> > > > +               break;
> > > > +       case IRQ_IXP4XX_TIMESTAMP:
> > > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_TS_PEND;
> > > > +               break;
> > > > +       case IRQ_IXP4XX_WDOG:
> > > > +               *IXP4XX_OSST = IXP4XX_OSST_TIMER_WDOG_PEND;
> > > > +               break;
> > > 
> > > Since you are touching these lines, it probably makes sense to convert them
> > > to use writel_relaxed() in the process. Dereferencing a volatile pointer
> > > in order to do MMIO is strongly discouraged, see
> > > Documentation/volatile-considered-harmful.txt
> > 
> > Arnd,
> > 
> > I took a quick look at the ixp4xx code when I saw this.  It appears the
> > entire sub-arch is written this way :-(  Perhaps it would be better to
> > do a cleanup patch before this one?  I didn't mention it in my initial
> > comment because it looks like quite a bit of work.
> > 
> > In either case, it's all cleanup, so it shouldn't cause a dependency
> > headache.
> > 
> > Alexander, if you're so inclined, a cleanup series would be much
> > appreciated.  If you don't have the time, no problem, just make the
> > changes suggested by Arnd and I and we'll get to the cleanup eventually.
> 
> I got curious to how hard this would be and ended up with a patch.
> 
> 	Arnd
> 
> 8<--------
> [PATCH] ARM: ixp4xx: use proper __iomem annotations consistently
> 
> The ixp4xx platform on ARM is one of the remaining locations still using
> direct pointer dereferences for MMIO access. This patch should convert
> all known instances to use readl_relaxed/writel_relaxed.
> 
> I could not find a nice solution for mach/hardware.h, which is included
> by mach/io.h indirectly but actually requires MMIO accesses as defined
> in asm/io.h. Using a macro as a workaround helps, but the better solution
> in the long run would be to have a proper gpiolib driver rather than
> using a private API to do GPIO.
> 
> I did not touch the definitions used in drivers/usb/gadget/pxa25x_udc.c,
> they are shared with the pxa platform and ever more screwed up than the
> other ones in ixp4xx that I fixed.
> 
> In the process of doing this patch, I noticed that indirect PCI access
> on ixp4xx is broken since the PCIBIOS_MIN_MEM consolidateion, and this
> does not get fixed here.

Nice work! I changed my patch and maybe do another one for this modified
version of common.c. Only one comment about this patch is below.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
...
> diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> index eb68b61..2522ab0 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> @@ -92,7 +92,7 @@
>  /*
>   * Expansion Bus Controller registers.
>   */
> -#define IXP4XX_EXP_REG(x) ((volatile u32 __iomem *)(IXP4XX_EXP_CFG_BASE_VIRT+(x)))
> +#define IXP4XX_EXP_REG(x) (IXP4XX_EXP_CFG_BASE_VIRT+(x))
Modify this to:
#define IXP4XX_EXP_REG(x) IOMEM(IXP4XX_EXP_CFG_BASE_VIRT+(x))
to avoid compiler warnings.

---
