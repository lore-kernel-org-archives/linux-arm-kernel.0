From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Sep 2014 22:19:42 +0900
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
In-Reply-To: <1971708.Jzqdj6e7RC@amdc1032>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <1965890.bT7bZyQJt8@amdc1032> <20140901015426.GC10680@verge.net.au>
 <1971708.Jzqdj6e7RC@amdc1032>
Message-ID: <20140901131942.GC32599@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 01, 2014 at 02:42:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, September 01, 2014 10:54:26 AM Simon Horman wrote:
> > On Fri, Aug 29, 2014 at 08:05:49PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Hi,
> > > 
> > > On Thursday, August 28, 2014 04:00:28 PM Geert Uytterhoeven wrote:
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Based on next-20140828
> > > > For now excluding r8a7740/armadillo, as it fails to boot on armadillo
> > > > 
> > > >  arch/arm/configs/multi_v7_defconfig | 51 +++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 49 insertions(+), 2 deletions(-)
> > > 
> > > I've been looking lately into making it possible to easily go
> > > from multi_v7_defconfig config to a single platform one (in my
> > > case Exynos one) and removing the need to keep the latter (i.e.
> > > exynos_defconfig) in the kernel tree in the long-term.
> > > 
> > > Because of this I've noticed that some config options for platform
> > > specific hardware that are selected in multi_v7_defconfig don't
> > > have proper dependencies.  This results in more complex than
> > > necessary single platform configs (obtained from a multiplatform
> > > config) and unnecessarily bigger resulting kernel images.
> > > 
> > > Your patch also adds/uncovers some such config options.
> > > 
> > > Lets first look at sizes of resulting vmlinux images for single
> > > platform Exynos config before and after your patch:
> > > 
> > >   $ size vmlinux.*
> > >      text    data     bss     dec     hex filename
> > >   7817317  517188  278992 8613497  836e79 vmlinux.before
> > >   7978325  527012  279056 8784393  860a09 vmlinux.after
> > > 
> > >   (=> the patch results in 170kB bigger vmlinux size)
> > > 
> > > and the configs diff later:
> > > 
> > > --- multi_v7_exynos_only	2014-08-29 12:29:31.881485357 +0200
> > > +++ multi_v7_exynos_only_shmobile	2014-08-29 12:36:24.361496247 +0200
> > > @@ -70,6 +70,8 @@
> > >  CONFIG_BRCMSTB_GISB_ARB=y
> > >  CONFIG_VEXPRESS_CONFIG=y
> > >  CONFIG_MTD=y
> > > +CONFIG_MTD_M25P80=y
> > > +CONFIG_MTD_SPI_NOR=y
> > >  CONFIG_BLK_DEV_LOOP=y
> > >  CONFIG_ICS932S401=y
> > >  CONFIG_APDS9802ALS=y
> > > @@ -86,11 +88,13 @@
> > >  CONFIG_MVMDIO=y
> > >  CONFIG_KS8851=y
> > >  CONFIG_R8169=y
> > > +CONFIG_SH_ETH=y
> > > 
> > > This seems to be option for Renesas specific hardware and it has
> > > a footprint of 23kB.
> > > 
> > > [ I think that this option should depend on ARCH_SHMOBILE || ARCH_SH. ]
> > > 
> > >  CONFIG_SMSC911X=y
> > >  CONFIG_STMMAC_ETH=y
> > >  CONFIG_AT803X_PHY=y
> > >  CONFIG_MARVELL_PHY=y
> > >  CONFIG_ICPLUS_PHY=y
> > > +CONFIG_MICREL_PHY=y
> > > 
> > > This gets selected by CONFIG_SH_ETH and costs us 4kB.
> > > 
> > >  CONFIG_USB_PEGASUS=y
> > >  CONFIG_USB_USBNET=y
> > >  CONFIG_USB_NET_SMSC75XX=y
> > > @@ -110,6 +114,7 @@
> > >  CONFIG_SERIAL_8250=y
> > >  CONFIG_SERIAL_8250_CONSOLE=y
> > >  CONFIG_SERIAL_8250_DW=y
> > > +CONFIG_SERIAL_8250_EM=y
> > >  CONFIG_SERIAL_AMBA_PL011=y
> > >  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> > >  CONFIG_SERIAL_SAMSUNG=y
> > > @@ -122,11 +127,13 @@
> > >  CONFIG_SERIAL_ST_ASC=y
> > >  CONFIG_SERIAL_ST_ASC_CONSOLE=y
> > >  CONFIG_I2C_CHARDEV=y
> > > +CONFIG_I2C_MUX=y
> > >  CONFIG_I2C_MUX_PCA954x=y
> > >  CONFIG_I2C_MUX_PINCTRL=y
> > >  CONFIG_I2C_DESIGNWARE_PLATFORM=y
> > >  CONFIG_I2C_NOMADIK=y
> > >  CONFIG_I2C_XILINX=y
> > > +CONFIG_SPI=y
> > >  CONFIG_SPI_CADENCE=y
> > >  CONFIG_SPI_PL022=y
> > >  CONFIG_SPI_XILINX=y
> > > @@ -135,6 +142,7 @@
> > >  CONFIG_PINCTRL_PALMAS=y
> > >  CONFIG_GPIO_SYSFS=y
> > >  CONFIG_GPIO_DWAPB=y
> > > +CONFIG_GPIO_EM=y
> > >  CONFIG_GPIO_PL061=y
> > >  CONFIG_GPIO_PCA953X=y
> > >  CONFIG_GPIO_PCA953X_IRQ=y
> > > @@ -173,6 +181,7 @@
> > >  CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> > >  CONFIG_REGULATOR_AS3722=y
> > >  CONFIG_REGULATOR_BCM590XX=y
> > > +CONFIG_REGULATOR_DA9210=y
> > >  CONFIG_REGULATOR_GPIO=y
> > >  CONFIG_REGULATOR_MAX8907=y
> > >  CONFIG_REGULATOR_PALMAS=y
> > > @@ -187,9 +196,18 @@
> > >  CONFIG_REGULATOR_VEXPRESS=y
> > >  CONFIG_MEDIA_SUPPORT=y
> > >  CONFIG_MEDIA_CAMERA_SUPPORT=y
> > > +CONFIG_MEDIA_CONTROLLER=y
> > > +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> > >  CONFIG_MEDIA_USB_SUPPORT=y
> > >  CONFIG_USB_VIDEO_CLASS=y
> > >  CONFIG_USB_GSPCA=y
> > > +CONFIG_V4L_PLATFORM_DRIVERS=y
> > > +CONFIG_SOC_CAMERA=y
> > > +CONFIG_SOC_CAMERA_PLATFORM=y
> > > +CONFIG_V4L_MEM2MEM_DRIVERS=y
> > > +CONFIG_VIDEO_RENESAS_VSP1=y
> > > 
> > > This seems to be another option for Renesas specific hardware and it has
> > > a footprint of 23kB.
> > > 
> > > [ I think that this option should depend on ARCH_SHMOBILE. ]
> > > 
> > > +# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> > > +CONFIG_VIDEO_ADV7180=y
> > >  CONFIG_DRM=y
> > >  CONFIG_FB=y
> > >  CONFIG_FB_ARMCLCD=y
> > > @@ -204,6 +222,7 @@
> > >  CONFIG_SND_SOC=y
> > >  CONFIG_SND_SOC_WM8753=y
> > >  CONFIG_SND_SOC_WM8903=y
> > > +CONFIG_SND_SIMPLE_CARD=y
> > >  CONFIG_USB=y
> > >  CONFIG_USB_XHCI_HCD=y
> > >  CONFIG_USB_EHCI_HCD=y
> > > @@ -211,6 +230,7 @@
> > >  CONFIG_USB_ISP1760_HCD=y
> > >  CONFIG_USB_OHCI_HCD=y
> > >  CONFIG_USB_OHCI_HCD_PLATFORM=y
> > > +CONFIG_USB_RENESAS_USBHS=y
> > > 
> > > It seems to be yet another option for Renesas specific hardware and it
> > > has a footprint of 18kB.
> > > 
> > > [ I think that this option should depend on ARCH_SHMOBILE || ARCH_SH. ]
> > > 
> > >  CONFIG_USB_STORAGE=y
> > >  CONFIG_USB_CHIPIDEA=y
> > >  CONFIG_USB_CHIPIDEA_HOST=y
> > > @@ -220,6 +240,8 @@
> > >  CONFIG_USB_GPIO_VBUS=y
> > >  CONFIG_USB_ISP1301=y
> > >  CONFIG_USB_ULPI=y
> > > +CONFIG_USB_GADGET=y
> > > +CONFIG_USB_RENESAS_USBHS_UDC=y
> > > 
> > > This one depends on CONFIG_USB_RENESAS_USBHS and costs us 3kB.
> > > 
> > >  CONFIG_MMC=y
> > >  CONFIG_MMC_BLOCK_MINORS=16
> > >  CONFIG_MMC_ARMMMCI=y
> > > 
> > > In total by fixing the above three options to have correct dependencies
> > > it is possible to recover 86kB out of 170kB of vmlinux size inrease for
> > > a single platform only config derived from a multiplatform one.
> > > 
> > > Simon/Magnus, is it okay to send patches fixing
> > > 
> > >   CONFIG_SH_ETH
> > >   CONFIG_VIDEO_RENESAS_VSP1
> > >   CONFIG_USB_RENESAS_USBHS
> > > 
> > > dependencies?
> > 
> > Hi Bartlomiej,
> > 
> > In general that seems reasonable to me.
> > But I would tweak the dependency slightly to:
> > 
> > ARCH_SHMOBILE || ARCH_SH || COMPILE_TEST
> 
> Ok.
>  
> > And in the case of CONFIG_VIDEO_RENESAS_VSP1 and CONFIG_USB_RENESAS_USBHS
> > I think ARCH_SH could be omitted.
> 
> I agree w.r.t. CONFIG_VIDEO_RENESAS_VSP1 but CONFIG_USB_RENESAS_USBHS
> seems to be needed by both ARCH_SHMOBILE:

Indeed it does.

> 
> $ git grep renesas_usbhs_platform_info arch/arm/mach-shmobile/
> arch/arm/mach-shmobile/board-armadillo800eva.c: struct renesas_usbhs_platform_info info;
> arch/arm/mach-shmobile/board-bockw.c:static struct renesas_usbhs_platform_info usbhs_info __initdata = {
> arch/arm/mach-shmobile/board-bockw.c:           &usbhs_info, sizeof(struct renesas_usbhs_platform_info))
> arch/arm/mach-shmobile/board-kzm9g.c:   struct renesas_usbhs_platform_info info;
> arch/arm/mach-shmobile/board-lager.c:   struct renesas_usbhs_platform_info info;
> arch/arm/mach-shmobile/board-mackerel.c:        struct renesas_usbhs_platform_info info;
> 
> and ARCH_SH:
> 
> $ git grep renesas_usbhs_platform_info arch/sh/
> arch/sh/boards/board-sh7757lcr.c:static struct renesas_usbhs_platform_info usb0_data = {
> arch/sh/boards/mach-ecovec24/setup.c:static struct renesas_usbhs_platform_info usbhs_info = {
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
