From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 20 Jul 2011 11:03:56 +0000
Subject: [PATCH 1/7] consolidate definitions and structures to share
	among platforms
In-Reply-To: <20110720105933.GJ764@legolas.emea.dhcp.ti.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-2-git-send-email-tony.lin@freescale.com>
	<20110720105933.GJ764@legolas.emea.dhcp.ti.com>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5161640@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi at ti.com]
> Sent: Wednesday, July 20, 2011 7:00 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> balbi at ti.com; koen.beel.barco at gmail.com
> Subject: Re: [PATCH 1/7] consolidate definitions and structures to share
> among platforms
> 
> Hi,
> 
> On Wed, Jul 20, 2011 at 07:08:20PM +0800, Tony Lin wrote:
> > move common definitions and data structures used for mxs and mxc
> > platforms to fsl_device.h from mxc_ehci.h so that these definitions
> > and structures could be shared without duplicated copies.
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> >
> > ---
> >  arch/arm/plat-mxc/include/mach/mxc_ehci.h |   19 -------------------
> >  include/linux/fsl_devices.h               |   21 +++++++++++++++++++++
> >  2 files changed, 21 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> > b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> > index 2c159dc..8775807 100644
> > --- a/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> > +++ b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> > @@ -1,17 +1,6 @@
> >  #ifndef __INCLUDE_ASM_ARCH_MXC_EHCI_H  #define
> > __INCLUDE_ASM_ARCH_MXC_EHCI_H
> >
> > -/* values for portsc field */
> > -#define MXC_EHCI_PHY_LOW_POWER_SUSPEND	(1 << 23)
> > -#define MXC_EHCI_FORCE_FS		(1 << 24)
> > -#define MXC_EHCI_UTMI_8BIT		(0 << 28)
> > -#define MXC_EHCI_UTMI_16BIT		(1 << 28)
> > -#define MXC_EHCI_SERIAL			(1 << 29)
> > -#define MXC_EHCI_MODE_UTMI		(0 << 30)
> > -#define MXC_EHCI_MODE_PHILIPS		(1 << 30)
> > -#define MXC_EHCI_MODE_ULPI		(2 << 30)
> > -#define MXC_EHCI_MODE_SERIAL		(3 << 30)
> > -
> >  /* values for flags field */
> >  #define MXC_EHCI_INTERFACE_DIFF_UNI	(0 << 0)
> >  #define MXC_EHCI_INTERFACE_DIFF_BI	(1 << 0)
> > @@ -39,14 +28,6 @@
> >  #define MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK		0x3
> >  #define MX5_USB_UTMI_PHYCTRL1_PLLDIV_SHIFT		0
> >
> > -struct mxc_usbh_platform_data {
> > -	int (*init)(struct platform_device *pdev);
> > -	int (*exit)(struct platform_device *pdev);
> > -
> > -	unsigned int		 portsc;
> > -	struct otg_transceiver	*otg;
> > -};
> > -
> >  int mx51_initialize_usb_hw(int port, unsigned int flags);  int
> > mx25_initialize_usb_hw(int port, unsigned int flags);  int
> > mx31_initialize_usb_hw(int port, unsigned int flags); diff --git
> > a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h index
> > fffdf00..c138988 100644
> > --- a/include/linux/fsl_devices.h
> > +++ b/include/linux/fsl_devices.h
> > @@ -103,6 +103,27 @@ struct fsl_usb2_platform_data {
> >
> >  #define FLS_USB2_WORKAROUND_ENGCM09152	(1 << 0)
> >
> > +/* values for portsc field */
> > +#define MXC_EHCI_PHY_LOW_POWER_SUSPEND	(1 << 23)
> > +#define MXC_EHCI_FORCE_FS		(1 << 24)
> > +#define MXC_EHCI_UTMI_8BIT		(0 << 28)
> > +#define MXC_EHCI_UTMI_16BIT		(1 << 28)
> > +#define MXC_EHCI_SERIAL			(1 << 29)
> > +#define MXC_EHCI_MODE_UTMI		(0 << 30)
> > +#define MXC_EHCI_MODE_PHILIPS		(1 << 30)
> > +#define MXC_EHCI_MODE_ULPI		(2 << 30)
> > +#define MXC_EHCI_MODE_SERIAL		(3 << 30)
> > +
> > +struct mxc_usbh_platform_data {
> > +	int (*init)(struct platform_device *pdev);
> > +	int (*exit)(struct platform_device *pdev);
> > +
> > +	unsigned int		 portsc;
> > +	struct otg_transceiver	*otg;
> > +	int (*plt_get_usb_connect_status)(void);
> > +	void (*plt_usb_disconnect_detect)(int enable); };
> > +
> >  struct spi_device;
> >
> >  struct fsl_spi_platform_data {
> 
> I believe this patch will cause build breakage since ehci-mxc.c doesn't
> include <linux/fsl_devices.h> ??
Ehci-mxc.c does include <linux/fsl_devices.h>, please check patch 5/7. Thanks

BR
Tony
