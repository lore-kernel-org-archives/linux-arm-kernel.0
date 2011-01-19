From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Jan 2011 19:54:44 +0100
Subject: [PATCH] usb: gadget/fsl_mxc_udc: Detect the CPU type in run-time
In-Reply-To: <4D371ABB.7000608@freescale.com>
References: <1295451164-3363-1-git-send-email-fabio.estevam@freescale.com>
	<4D37050E.6010009@eukrea.com> <4D371ABB.7000608@freescale.com>
Message-ID: <20110119185444.GA7228@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 03:09:15PM -0200, Fabio Estevam wrote:
> On 1/19/2011 1:36 PM, Eric B?nard wrote:
> > Hi Fabio,
> > 
> > On 19/01/2011 16:32, Fabio Estevam wrote:
> >> Instead of checking the CPU type in build-time, do it in run-time.
> >>
> >> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
> >> ---
> >>   drivers/usb/gadget/fsl_mxc_udc.c |   23 ++++++++++++-----------
> >>   1 files changed, 12 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
> >> index 77b1eb5..167abe0 100644
> >> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> >> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> >> @@ -88,17 +88,18 @@ eenahb:
> >>   void fsl_udc_clk_finalize(struct platform_device *pdev)
> >>   {
> >>       struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
> >> -#if defined(CONFIG_ARCH_MX35)
> >> -    unsigned int v;
> >> -
> >> -    /* workaround ENGcm09152 for i.MX35 */
> >> -    if (pdata->workaround&  FLS_USB2_WORKAROUND_ENGCM09152) {
> >> -        v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> >> -                USBPHYCTRL_OTGBASE_OFFSET));
> >> -        writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> >> -                USBPHYCTRL_OTGBASE_OFFSET));
> >> -    }
> >> -#endif
> >> +    if (cpu_is_mx35()) {
> >> +        unsigned int v;
> >> +
> >> +        /* workaround ENGcm09152 for i.MX35 */
> >> +        if (pdata->workaround&  FLS_USB2_WORKAROUND_ENGCM09152) {
can you please fix up the position of the '&'?

> >> +            v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> >> +                    USBPHYCTRL_OTGBASE_OFFSET));
> >> +            writel(v | USBPHYCTRL_EVDO,
> >> +                MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> >> +                    USBPHYCTRL_OTGBASE_OFFSET));
I wonder if the address isn't mapped via ioremap in the driver and the
cookie saved somewhere?  (And no, I don't ask you to change that in this
patch.)  (If so, it this already problematic aliasing?)

> >> +        }
> >> +    }
> >>
> > are you sure this compiles when MX35 is not selected ?
> 
> Including #include <mach/mx35.h> fixes the build for a non- mx35 kernel.
> 
> Would this be acceptable? If so, I can send v2.
If you keep the #if defined(CONFIG_ARCH_MX35) and only add the if
(cpu_is_mx35()) it should work without a new #include.
Doing that seems a tad cleaner to me.

Best regards
Uwe 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
