From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 4 Feb 2013 11:16:13 +0800
Subject: [PATCH 4/9] USB: chipidea: add PTW and PTS handling
In-Reply-To: <874nhwmc41.fsf@ashishki-desk.ger.corp.intel.com>
References: <1359705132-9434-1-git-send-email-s.hauer@pengutronix.de>
 <1359705132-9434-5-git-send-email-s.hauer@pengutronix.de>
 <20130201090046.GA8056@pengutronix.de>
 <874nhwmc41.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130204031612.GA24106@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 02:50:54PM +0200, Alexander Shishkin wrote:
> Michael Grzeschik <mgr@pengutronix.de> writes:
> 
> > On Fri, Feb 01, 2013 at 08:52:07AM +0100, Sascha Hauer wrote:
> >> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >> 
> >> This patch makes it possible to configure the PTW and PTS bits inside
> >> the portsc register for host and device mode before the driver starts
> >> and the phy can be addressed as hardware implementation is designed.
> >> 
> >> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> ---
> >>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +++
> >>  drivers/usb/chipidea/bits.h                        |   14 ++++++-
> >>  drivers/usb/chipidea/ci13xxx_imx.c                 |    3 ++
> >>  drivers/usb/chipidea/core.c                        |   39 ++++++++++++++++++++
> >>  include/linux/usb/chipidea.h                       |    1 +
> >>  5 files changed, 61 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >> index 5778b9c..dd42ccd 100644
> >> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >> @@ -5,6 +5,11 @@ Required properties:
> >>  - reg: Should contain registers location and length
> >>  - interrupts: Should contain controller interrupt
> >>  
> >> +Recommended properies:
> >> +- phy_type: the type of the phy connected to the core. Should be one
> >> +  of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
> >> +  property the PORTSC register won't be touched
> >> +
> >>  Optional properties:
> >>  - fsl,usbphy: phandler of usb phy that connects to the only one port
> >>  - fsl,usbmisc: phandler of non-core register device, with one argument
> >> diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
> >> index 050de85..d8ffc2f 100644
> >> --- a/drivers/usb/chipidea/bits.h
> >> +++ b/drivers/usb/chipidea/bits.h
> >> @@ -48,10 +48,22 @@
> >>  #define PORTSC_SUSP           BIT(7)
> >>  #define PORTSC_HSP            BIT(9)
> >>  #define PORTSC_PTC            (0x0FUL << 16)
> >> +/* PTS and PTW for non lpm version only */
> >> +#define PORTSC_PTS(d)         ((((d) & 0x3) << 30) | (((d) & 0x4) ? BIT(25) : 0))
> >> +#define PORTSC_PTW            BIT(28)
> >>  
> >>  /* DEVLC */
> >>  #define DEVLC_PSPD            (0x03UL << 25)
> >> -#define    DEVLC_PSPD_HS      (0x02UL << 25)
> >> +#define DEVLC_PSPD_HS         (0x02UL << 25)
> >> +#define DEVLC_PTW             BIT(27)
> >> +#define DEVLC_STS             BIT(28)
> >> +#define DEVLC_PTS(d)          (((d) & 0x7) << 29)
> >> +
> >> +/* Encoding for DEVLC_PTS and PORTSC_PTS */
> >> +#define PTS_UTMI              0
> >> +#define PTS_ULPI              2
> >> +#define PTS_SERIAL            3
> >> +#define PTS_HSIC              4
> >>  
> >>  /* OTGSC */
> >>  #define OTGSC_IDPU	      BIT(5)
> >> diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> >> index 69024e0..ebc1148 100644
> >> --- a/drivers/usb/chipidea/ci13xxx_imx.c
> >> +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> >> @@ -21,6 +21,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/regulator/consumer.h>
> >>  #include <linux/pinctrl/consumer.h>
> >> +#include <linux/usb/of.h>
> >>  
> >>  #include "ci.h"
> >>  #include "ci13xxx_imx.h"
> >> @@ -112,6 +113,8 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
> >>  		       CI13XXX_PULLUP_ON_VBUS |
> >>  		       CI13XXX_DISABLE_STREAMING;
> >>  
> >> +	pdata->phy_mode = of_usb_get_phy_mode(pdev->dev.of_node);
> >> +
> >>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >>  	if (!data) {
> >>  		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX data!\n");
> >> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> >> index 57cae1f..a3ec29d 100644
> >> --- a/drivers/usb/chipidea/core.c
> >> +++ b/drivers/usb/chipidea/core.c
> >> @@ -67,6 +67,8 @@
> >>  #include <linux/usb/gadget.h>
> >>  #include <linux/usb/otg.h>
> >>  #include <linux/usb/chipidea.h>
> >> +#include <linux/usb/of.h>
> >> +#include <linux/phy.h>
> >>  
> >>  #include "ci.h"
> >>  #include "udc.h"
> >> @@ -211,6 +213,41 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
> >>  	return 0;
> >>  }
> >>  
> >> +static void hw_phymode_configure(struct ci13xxx *ci)
> >> +{
> >> +	u32 portsc, lpm;
> >> +
> >> +	switch (ci->platdata->phy_mode) {
> >> +	case USBPHY_INTERFACE_MODE_UTMI:
> >> +		portsc = PORTSC_PTS(PTS_UTMI);
> >> +		lpm = DEVLC_PTS(PTS_UTMI);
> >> +		break;
> >> +	case USBPHY_INTERFACE_MODE_UTMIW:
> >> +		portsc = PORTSC_PTS(PTS_UTMI) | PORTSC_PTW;
> >> +		lpm = DEVLC_PTS(PTS_UTMI) | DEVLC_PTW;
> >> +		break;
> >> +	case USBPHY_INTERFACE_MODE_ULPI:
> >> +		portsc = PORTSC_PTS(PTS_ULPI);
> >> +		lpm = DEVLC_PTS(PTS_ULPI);
> >> +		break;
> >> +	case USBPHY_INTERFACE_MODE_SERIAL:
> >> +		portsc = PORTSC_PTS(PTS_SERIAL);
> >> +		lpm = DEVLC_PTS(PTS_SERIAL);
> >> +		break;
> >> +	case USBPHY_INTERFACE_MODE_HSIC:
> >> +		portsc = PORTSC_PTS(PTS_HSIC);
> >> +		lpm = DEVLC_PTS(PTS_HSIC);
> >> +		break;
> >> +	default:
> >> +		return;
> >> +	}
> >> +
> >> +	if (ci->hw_bank.lpm)
> >> +		hw_write(ci, OP_PORTSC, DEVLC_PTS(7) | DEVLC_PTW, lpm);
> >                              ^^^^^^^^^
> >
> > This is probably supposed to be OP_DEVLC.
> 
> Looks like that. I'd like to test this code on an LPM device first.
> Can somebody with an imx test give a Tested-by?

Sascha, would you like add above changes and change "int" to 
"enum usb_dr_mode" for your [PATCH 5/9] USB chipidea: 
introduce dual role mode pdata flags.
Then send v4 patch, I can help to test it before
this Tuesday (There will be 9 days Chinese New Year holiday).

> 
> Regards,
> --
> Alex
> 

-- 

Best Regards,
Peter Chen
