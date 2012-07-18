From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 18 Jul 2012 07:59:35 -0500
Subject: [PATCH v4] arm: socfpga: Add initial support for Altera's SOCFPGA
 HW
In-Reply-To: <201207181242.44326.arnd@arndb.de>
References: <20120718102507.GA11993@elf.ucw.cz>
 <201207181242.44326.arnd@arndb.de>
Message-ID: <CADhT+wcz9RUgX-6SJRUSZ8A6run4QoPVsjvD2rL30iF=HVQtyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jul 18, 2012 at 7:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 18 July 2012, Pavel Machek wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> >
> > Adding core definitions for Altera's SOCFPGA ARM platform.
> >
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Reviewed-by: Pavel Machek <pavel@denx.de>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> >
> > ---
> > Changes from V3: merged into single patch (it is now small enough),
> > moved dts pieces around (thanks to Thomas Petazzoni), removed clock
> > support (not neccessary with u-boot, needs to be redone).
>
> Looks good, I'll apply it to the next/newsoc branch for 3.6
> when I get the ok from Dinh. I'm not quite sure in what way you
> work together, but the patch lists only him in the MAINTAINERS
> file, so I'm making sure I'm not sidestepping him when I take
> the patch from you instead.
>

I'll send you a fresh V4 today with yours and Thomas's recommended changes
to the clk file.


>
> There are two small details I noticed. You can either send
> a replacement patch or fixups on top of this one.
>
> > +             gmac0: stmmac at ff700000 {
> > +                     compatible = "st,spear600-gmac";
> > +                     reg = <0xff700000 0x2000>;
> > +                     interrupts = <0 115 4>;
> > +                     interrupt-names = "macirq";
> > +                     mac-address = [00 00 00 00 00 00];/* Filled in by
> U-Boot */
> > +                     phy-mode = "gmii";
> > +             };
>
> We've just discussed the stmmac driver in the spear1340 update
> series. My understanding is that there are multiple variants of this
> that we may need to distintinguish. I think it's better if you
> make the compatible string something that does not reference the
> spear600 specific variant, unless you are certain that it is in fact
> completely identical to that one.
>
> Ideally you would have the version of the stmmac macro encoded
> in there, in addition to a name identifying altera as the company
> who added this one, ordered from most specific to least specific.
>
> For instance, this could be
>
>         compatible = "altr,socfpga-stmmac", "st,stmmac-v12.3.45",
> "st,stmmac";
>
> Looking at the driver, it seems that this should actually not be called
> stmmac in the devicetree but rather dwmac, so better make it
>
>         compatible = "altr,socfpga-stmmac", "snps,dwmac-4.567",
> "snps,dwmac";
>

I'll figure out what we have. thanks for the comment.


>
> > diff --git a/arch/arm/mach-socfpga/common.h
> b/arch/arm/mach-socfpga/common.h
> > new file mode 100644
> > index 0000000..ba90e7a
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/common.h
> > @@ -0,0 +1,23 @@
> > +
> > +#ifndef __MACH_SOCFPGA_COMMON_H
> > +#define __MACH_SOCFPGA_COMMON_H
> > +
> > +extern struct sys_timer dw_apb_timer;
> > +
> > +#endif
>
> This header file is rather pointless when it is located in
> arch/arm/mach-socfpga where the driver cannot see it, so there
> is no guarantee that you actually use the same type in the
> declaration and the definition. I think it's better to also drop
> this header file and move the declaration into
> include/linux/dw_apb_timer.h
>
>         Arnd
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/cb436b56/attachment-0001.html>
