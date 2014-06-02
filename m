From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 2 Jun 2014 12:10:15 +0200
Subject: [PATCH] ARM: i.MX: Compile FIQ code for AVIC & TZIC only
In-Reply-To: <1401702163.832576877@f354.i.mail.ru>
References: <1400604231-2672-1-git-send-email-shc_work@mail.ru>
 <1400604231-2672-2-git-send-email-shc_work@mail.ru>
 <20140602113327.2568c198@ipc1.ka-ro>
 <1401702163.832576877@f354.i.mail.ru>
Message-ID: <20140602121015.12f35788@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexander Shiyan wrote:
> Mon, 2 Jun 2014 11:33:27 +0200 ?? Lothar Wa?mann <LW@KARO-electronics.de>:
> > Hi,
> > 
> > Alexander Shiyan wrote:
> > > There are no reason to compile FIQ specific code for GIC IRQ
> > > controller (i.MX6). This patch restrict compilation for FIQ
> > > specific code for AVIC and TZIC only.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/mach-imx/Makefile | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > > index bbe93bb..620a760 100644
> > > --- a/arch/arm/mach-imx/Makefile
> > > +++ b/arch/arm/mach-imx/Makefile
> > > @@ -1,4 +1,4 @@
> > > -obj-y := time.o cpu.o system.o irq-common.o
> > > +obj-y := time.o cpu.o system.o
> > >  
> > >  obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
> > >  obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
> > > @@ -21,8 +21,8 @@ obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
> > >  obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
> > >  obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
> > >  
> > > -obj-$(CONFIG_MXC_TZIC) += tzic.o
> > > -obj-$(CONFIG_MXC_AVIC) += avic.o
> > > +obj-$(CONFIG_MXC_TZIC) += tzic.o irq-common.o
> > > +obj-$(CONFIG_MXC_AVIC) += avic.o irq-common.o
> > >  
> > >  obj-$(CONFIG_MXC_USE_EPIT) += epit.o
> > >  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> > >
> > This patch introduces a build error in sound/soc/fsl/imx-pcm-fiq.c:
> > sound/built-in.o: In function `imx_pcm_fiq_free':
> > last.c:(.text+0x2aca8): undefined reference to `mxc_set_irq_fiq'
> > sound/built-in.o: In function `imx_pcm_fiq_init':
> > last.c:(.text+0x2b1a4): undefined reference to `mxc_set_irq_fiq'
> > last.c:(.text+0x2b200): undefined reference to `mxc_set_irq_fiq'
> > make[1]: *** [vmlinux] Error 1
> > make: *** [sub-make] Error 2
> > 
> > This could be fixed with the following patch:
> > --- mxc-fiq.orig/sound/soc/fsl/Kconfig  2014-06-02 11:25:38.315960451 +0200
> > +++ mxc-fiq/sound/soc/fsl/Kconfig       2014-06-02 11:25:38.411960595 +0200
> > @@ -15,7 +15,7 @@
> >  config SND_SOC_FSL_SSI
> > 	tristate "Synchronous Serial Interface module support"
> > 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
> > -	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && ARCH_MXC
> > +	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_AVIC || MXC_TZIC)
> ...
> 
> No. This will break building fsl-ssi for PPC and i.MX6, so let's just drop original patch for a while.
> 
Why and how?
MXC_AVIC or MXC_TZIC are just more specific than ARCH_MXC and will be
set only on ARCH_MXC when there is either a TZIC or AVIC controller
selected.
The PPC driver won't have ARCH_MXC defined anyway. Thus there will be
no change for that one

I've successfully build the driver on i.MX6.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
