From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Sep 2011 16:50:25 +0800
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level debug
	uart
In-Reply-To: <3922347.lxZAT2yslI@wuerfel>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<3922347.lxZAT2yslI@wuerfel>
Message-ID: <20110907085023.GH8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 08:39:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 06 September 2011 17:58:36 Shawn Guo wrote:
> > --- /dev/null
> > +++ b/arch/arm/plat-mxc/include/mach/mx6q.h
> > @@ -0,0 +1,29 @@
> > +#ifndef __MACH_MX6Q_H__
> > +#define __MACH_MX6Q_H__
> > +
> > +/* static mappings */
> > +#define IMX6Q_VA(x)            (0xf4000000 + (x))
> 
> This should return a 'void __iomem *' pointer, not an integer.
> 
To pair the virtual address and physical address which is an integer,
I chose to define the virtual address as integer too, and cast it to
pointer when using it using helper macro IOMEM() defined in
arch/arm/plat-mxc/include/mach/hardware.h.

> > +#define MX6Q_SCU_BASE_ADDR     0x00a00000
> > +#define MX6Q_CCM_BASE_ADDR     0x020c4000
> > +#define MX6Q_ANATOP_BASE_ADDR  0x020c8000
> > +#define MX6Q_UART4_BASE_ADDR   0x021f0000
> > +
> > +#define MX6Q_SCU_BASE_VADDR    IMX6Q_VA(MX6Q_SCU_BASE_ADDR)
> > +#define MX6Q_CCM_BASE_VADDR    IMX6Q_VA(MX6Q_CCM_BASE_ADDR)
> > +#define MX6Q_ANATOP_BASE_VADDR IMX6Q_VA(MX6Q_ANATOP_BASE_ADDR)
> > +#define MX6Q_UART4_BASE_VADDR  IMX6Q_VA(MX6Q_UART4_BASE_ADDR)
> 
> The list is reasonably short, but I think you can still try harder to remove
> some of the remaining elements. I can understand the need for UART4
> (for ll_debug), but I don't really understand what the others are and
> why you cannot get the values from the device tree and ioremap them.
> 
For SCU_BASE, the definition is actually unused, since physical base
of SCU can be retrieved from coprocessor.  I put them here for
documentation purpose telling it's a static mapping.

For CCM and ANATOP, the static mappings are used by clock code, because
"struct clk" is statically defined and initialized.  They can become
dynamic mapping when we migrate the clock to common framework and
device tree.

> Maybe you can add a few comments to explain these if they are indeed
> necessary.
> 
Ok, will do.

-- 
Regards,
Shawn
