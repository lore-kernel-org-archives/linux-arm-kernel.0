From: p.paneri@samsung.com (Praveen Paneri)
Date: Tue, 21 Jun 2011 17:20:25 +0530
Subject: [RFC][PATCH 2/5] ARM: SAMSUNG: Changing the build condition of
	OTG platform device for samsung.
In-Reply-To: <0LN4003LQZBUSGU0@mailout4.samsung.com>
References: <0LN4003LQZBUSGU0@mailout4.samsung.com>
Message-ID: <BANLkTikPt=_KNpoJ4Xawz_PYMmZg3PnR9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 21, 2011 at 4:17 PM, PRAVEEN PANERI <p.paneri@samsung.com> wrote:
>
> Hi,
>
> On Tue, Jun 21, 2011 at 12:33:44PM +0530, p.paneri at samsung.com wrote:
> > From: Praveen Paneri
> >
> > Adding dwc driver name in existing platform device
> > to probe DWC OTG driver.
> > Introduced otg_set_platdata function to pass platform data
> > Added selectable config option to add DWC OTG driver for different
> > machines.
> >
> > Signed-off-by: Praveen Paneri
> > ---
> >??arch/arm/plat-samsung/Kconfig???????? |????6 ++++++
> >??arch/arm/plat-samsung/Makefile????????|????1 +
> >??arch/arm/plat-samsung/dev-usb-hsotg.c |?? 20 ++++++++++++++++++++
> >??3 files changed, 27 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> > index 4d79519..58ed8b1 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -227,6 +227,12 @@ config S3C_DEV_USB_HSOTG
> >?? help
> >?? ??Compile in platform device definition for USB high-speed OtG
> >
> > +config S3C_DEV_DWC_OTG
> > + bool
> > + help
> > + ??Compile in platform device definition for DWC OTG. This
> > + ??will make it selectable for different machines.
> > +
> >??config S3C_DEV_WDT
> >?? bool
> >?? default y if ARCH_S3C2410
> > diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> > index 53eb15b..785ca79 100644
> > --- a/arch/arm/plat-samsung/Makefile
> > +++ b/arch/arm/plat-samsung/Makefile
> > @@ -49,6 +49,7 @@ obj-$(CONFIG_S3C_DEV_FB) += dev-fb.o
> >??obj-y += dev-uart.o
> >??obj-$(CONFIG_S3C_DEV_USB_HOST) += dev-usb.o
> >??obj-$(CONFIG_S3C_DEV_USB_HSOTG) += dev-usb-hsotg.o
> > +obj-$(CONFIG_S3C_DEV_DWC_OTG) += dev-usb-hsotg.o
> >??obj-$(CONFIG_S3C_DEV_WDT) += dev-wdt.o
> >??obj-$(CONFIG_S3C_DEV_NAND) += dev-nand.o
> >??obj-$(CONFIG_S3C_DEV_ONENAND) += dev-onenand.o
> > diff --git a/arch/arm/plat-samsung/dev-usb-hsotg.c b/arch/arm/plat-samsung/dev-usb-hsotg.c
> > index 33a844a..7e6228b 100644
> > --- a/arch/arm/plat-samsung/dev-usb-hsotg.c
> > +++ b/arch/arm/plat-samsung/dev-usb-hsotg.c
> > @@ -20,6 +20,8 @@
> >??#include
> >
> >??#include
> > +#include
> > +#include
> >
> >??static struct resource s3c_usb_hsotg_resources[] = {
> >?? [0] = {
> > @@ -37,7 +39,12 @@ static struct resource s3c_usb_hsotg_resources[] = {
> >??static u64 s3c_hsotg_dmamask = DMA_BIT_MASK(32);
> >
> >??struct platform_device s3c_device_usb_hsotg = {
> > +#ifdef CONFIG_S3C_DEV_USB_HSOTG
> >?? .name = "s3c-hsotg",
> > +#endif
> > +#ifdef CONFIG_S3C_DEV_DWC_OTG
> > + .name = "dwc_otg",
> > +#endif
>
> no, don't do that. See we're going through a big re-factor on the gadget
> framework to allow multiple UDC drivers to be compiled as modules. The
> idea is to be able to have distro-like kernels for embedded too.
It can be build as a module but need to make necessary modifications in
platform code. Will modify according to the gadget framework.
Thanks for the comment.
paneri
>
> Take a look at my gadget branch [1] and see how the gadget controllers
> are modified to start allowing that.
>
> I also have patch to the Kconfig allowing all controllers to be enabled
> as modules, I just need some more time to figure out one warning on the
> renenesas controller.
>
> IOW, it's best to add both platform devices. Or move to device tree.
>
> --
> balbi
>
>
>
>
>
>
