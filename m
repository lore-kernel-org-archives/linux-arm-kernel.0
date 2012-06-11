From: balbi@ti.com (Felipe Balbi)
Date: Mon, 11 Jun 2012 10:13:02 +0300
Subject: [PATCHv2 09/12] ARM: OMAP2+: usb_host_fs: add custom
 setup_preprogram for usb_host_fs (fsusb)
In-Reply-To: <20120611063416.GT12766@atomide.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004617.20034.21714.stgit@dusk>
 <20120611063416.GT12766@atomide.com>
Message-ID: <20120611071301.GC6845@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 11:34:17PM -0700, Tony Lindgren wrote:
> Hi,
> 
> Similar comments to the asess patch on this one below.
> 
> * Paul Walmsley <paul@pwsan.com> [120610 17:57]:
> > --- /dev/null
> > +++ b/include/linux/platform_data/fsusb.h
> 
> This would be better as include/linux/platform_data/omap-usb.h.
> 
> > +#include <plat/omap_hwmod.h>
> 
> This include should not be needed here if the hwmod function is
> a static function in the some hwmod*.c file.
> 
> > +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS register */
> > +#define HCCOMMANDSTATUS			0x0008
> > +
> > +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag */
> > +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)
> 
> I think these already have standard defines in some OHCI header?
> Felipe may be able to comment more on this?

Well, yeah... but it's defined on drivers/usb/host/ohci.h and it's
actually a structure:

| /*
|  * This is the structure of the OHCI controller's memory mapped I/O region.
|  * You must use readl() and writel() (in <asm/io.h>) to access these fields!!
|  * Layout is in section 7 (and appendix B) of the spec.
|  */
| struct ohci_regs {
| 	/* control and status registers (section 7.1) */
| 	__hc32	revision;
| 	__hc32	control;
| 	__hc32	cmdstatus;
| 	__hc32	intrstatus;
| 	__hc32	intrenable;
| 	__hc32	intrdisable;
| 
| 	/* memory pointers (section 7.2) */
| 	__hc32	hcca;
| 	__hc32	ed_periodcurrent;
| 	__hc32	ed_controlhead;
| 	__hc32	ed_controlcurrent;
| 	__hc32	ed_bulkhead;
| 	__hc32	ed_bulkcurrent;
| 	__hc32	donehead;
| 
| 	/* frame counters (section 7.3) */
| 	__hc32	fminterval;
| 	__hc32	fmremaining;
| 	__hc32	fmnumber;
| 	__hc32	periodicstart;
| 	__hc32	lsthresh;
| 
| 	/* Root hub ports (section 7.4) */
| 	struct	ohci_roothub_regs {
| 		__hc32	a;
| 		__hc32	b;
| 		__hc32	status;
| #define MAX_ROOT_PORTS	15	/* maximum OHCI root hub ports (RH_A_NDP) */
| 		__hc32	portstatus [MAX_ROOT_PORTS];
| 	} roothub;
| 
| 	/* and optional "legacy support" registers (appendix B) at 0x0100 */
| 
| } __attribute__ ((aligned(32)));

[...]

| /*
|  * HcCommandStatus (cmdstatus) register masks
|  */
| #define OHCI_HCR	(1 << 0)	/* host controller reset */
| #define OHCI_CLF	(1 << 1)	/* control list filled */
| #define OHCI_BLF	(1 << 2)	/* bulk list filled */
| #define OHCI_OCR	(1 << 3)	/* ownership change request */
| #define OHCI_SOC	(3 << 16)	/* scheduling overrun count */

> > +static int fsusb_reset_host_controller(const char *name, void __iomem *base)
> > +{
> > +	int i;
> > +
> > +	writel(HCCOMMANDSTATUS_HCR_MASK, base + HCCOMMANDSTATUS);
> > +
> > +	for (i = 0; i < MAX_FSUSB_HCR_TIME; i++) {
> > +		if (!(readl(base + HCCOMMANDSTATUS) & HCCOMMANDSTATUS_HCR_MASK))
> > +			break;
> > +		udelay(1);
> > +	}
> > +
> > +	if (i == MAX_FSUSB_HCR_TIME) {
> > +		pr_warn("%s: %s: host controller reset failed (waited %d usec)\n",
> > +			__func__, name, MAX_FSUSB_HCR_TIME);
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> This should be "static inline int fsusb_reset_host_controller" as it's
> in a header.

why is it even in a header ? Only hwmod_fsusb_preprogram() will use it
anyway.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120611/eb35b2f2/attachment.sig>
