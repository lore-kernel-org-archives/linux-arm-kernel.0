From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Oct 2013 17:52:07 -0500
Subject: [PATCH v3 01/13] usb: phy: msm: Move mach depndend code to
 platform data
In-Reply-To: <1381764280-28420-2-git-send-email-iivanov@mm-sol.com>
References: <1381764280-28420-1-git-send-email-iivanov@mm-sol.com>
 <1381764280-28420-2-git-send-email-iivanov@mm-sol.com>
Message-ID: <20131014225207.GD7446@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 14, 2013 at 06:24:28PM +0300, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> This patch fix compilation error and is an intermediate step
> before the addition of DeviceTree support for newer targets.
> 
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  arch/arm/mach-msm/board-msm7x30.c |   35 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-msm/board-qsd8x50.c |   35 +++++++++++++++++++++++++++++++++++
>  drivers/usb/phy/phy-msm-usb.c     |   34 ++++++++++++++--------------------
>  include/linux/usb/msm_hsusb.h     |    3 +++
>  4 files changed, 87 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
> index f9af5a4..46de789 100644
> --- a/arch/arm/mach-msm/board-msm7x30.c
> +++ b/arch/arm/mach-msm/board-msm7x30.c
> @@ -30,6 +30,7 @@
>  #include <asm/memory.h>
>  #include <asm/setup.h>
>  
> +#include <mach/clk.h>
>  #include <mach/msm_iomap.h>
>  #include <mach/dma.h>
>  
> @@ -60,10 +61,44 @@ static int hsusb_phy_init_seq[] = {
>  	-1
>  };
>  
> +static int hsusb_link_clk_reset(struct clk *link_clk, bool assert)
> +{
> +	int ret;
> +
> +	if (assert) {
> +		ret = clk_reset(link_clk, CLK_RESET_ASSERT);
> +		if (ret)
> +			pr_err("usb hs_clk assert failed\n");
> +	} else {
> +		ret = clk_reset(link_clk, CLK_RESET_DEASSERT);
> +		if (ret)
> +			pr_err("usb hs_clk deassert failed\n");
> +	}
> +	return ret;
> +}
> +
> +static int hsusb_phy_clk_reset(struct clk *phy_clk)
> +{
> +	int ret;
> +
> +	ret = clk_reset(phy_clk, CLK_RESET_ASSERT);
> +	if (ret) {
> +		pr_err("usb phy clk assert failed\n");
> +		return ret;
> +	}
> +	usleep_range(10000, 12000);
> +	ret = clk_reset(phy_clk, CLK_RESET_DEASSERT);
> +	if (ret)
> +		pr_err("usb phy clk deassert failed\n");
> +	return ret;
> +}
> +
>  static struct msm_otg_platform_data msm_otg_pdata = {
>  	.phy_init_seq		= hsusb_phy_init_seq,
>  	.mode                   = USB_PERIPHERAL,
>  	.otg_control		= OTG_PHY_CONTROL,
> +	.link_clk_reset		= hsusb_link_clk_reset,
> +	.phy_clk_reset		= hsusb_phy_clk_reset,
>  };
>  
>  struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
> diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
> index 5f933bc..9169ec3 100644
> --- a/arch/arm/mach-msm/board-qsd8x50.c
> +++ b/arch/arm/mach-msm/board-qsd8x50.c
> @@ -31,6 +31,7 @@
>  #include <mach/irqs.h>
>  #include <mach/sirc.h>
>  #include <mach/vreg.h>
> +#include <mach/clk.h>
>  #include <linux/platform_data/mmc-msm_sdcc.h>
>  
>  #include "devices.h"
> @@ -81,10 +82,44 @@ static int hsusb_phy_init_seq[] = {
>  	-1
>  };
>  
> +static int hsusb_link_clk_reset(struct clk *link_clk, bool assert)
> +{
> +	int ret;
> +
> +	if (assert) {
> +		ret = clk_reset(link_clk, CLK_RESET_ASSERT);
> +		if (ret)
> +			pr_err("usb hs_clk assert failed\n");
> +	} else {
> +		ret = clk_reset(link_clk, CLK_RESET_DEASSERT);
> +		if (ret)
> +			pr_err("usb hs_clk deassert failed\n");
> +	}
> +	return ret;
> +}
> +
> +static int hsusb_phy_clk_reset(struct clk *phy_clk)
> +{
> +	int ret;
> +
> +	ret = clk_reset(phy_clk, CLK_RESET_ASSERT);
> +	if (ret) {
> +		pr_err("usb phy clk assert failed\n");
> +		return ret;
> +	}
> +	usleep_range(10000, 12000);
> +	ret = clk_reset(phy_clk, CLK_RESET_DEASSERT);
> +	if (ret)
> +		pr_err("usb phy clk deassert failed\n");
> +	return ret;
> +}
> +
>  static struct msm_otg_platform_data msm_otg_pdata = {
>  	.phy_init_seq		= hsusb_phy_init_seq,
>  	.mode                   = USB_PERIPHERAL,
>  	.otg_control		= OTG_PHY_CONTROL,
> +	.link_clk_reset		= hsusb_link_clk_reset,
> +	.phy_clk_reset		= hsusb_phy_clk_reset,
>  };
>  
>  static struct platform_device *devices[] __initdata = {
> diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
> index e9d4cd9..118798d 100644
> --- a/drivers/usb/phy/phy-msm-usb.c
> +++ b/drivers/usb/phy/phy-msm-usb.c
> @@ -40,8 +40,6 @@
>  #include <linux/usb/msm_hsusb_hw.h>
>  #include <linux/regulator/consumer.h>
>  
> -#include <mach/clk.h>
> -
>  #define MSM_USB_BASE	(motg->regs)
>  #define DRIVER_NAME	"msm_otg"
>  
> @@ -308,33 +306,29 @@ static void ulpi_init(struct msm_otg *motg)
>  
>  static int msm_otg_link_clk_reset(struct msm_otg *motg, bool assert)
>  {
> -	int ret;
> +	int ret = 0;
> +
> +	if (!motg->pdata->link_clk_reset)
> +		return ret;
> +
> +	ret = motg->pdata->link_clk_reset(motg->clk, assert);
> +	if (ret)
> +		dev_err(motg->phy.dev, "usb link clk reset failed\n");
>  
> -	if (assert) {
> -		ret = clk_reset(motg->clk, CLK_RESET_ASSERT);
> -		if (ret)
> -			dev_err(motg->phy.dev, "usb hs_clk assert failed\n");
> -	} else {
> -		ret = clk_reset(motg->clk, CLK_RESET_DEASSERT);
> -		if (ret)
> -			dev_err(motg->phy.dev, "usb hs_clk deassert failed\n");
> -	}
>  	return ret;
>  }
>  
>  static int msm_otg_phy_clk_reset(struct msm_otg *motg)
>  {
> -	int ret;
> +	int ret = 0;
>  
> -	ret = clk_reset(motg->phy_reset_clk, CLK_RESET_ASSERT);
> -	if (ret) {
> -		dev_err(motg->phy.dev, "usb phy clk assert failed\n");
> +	if (!motg->pdata->phy_clk_reset)
>  		return ret;
> -	}
> -	usleep_range(10000, 12000);
> -	ret = clk_reset(motg->phy_reset_clk, CLK_RESET_DEASSERT);
> +
> +	ret = motg->pdata->phy_clk_reset(motg->phy_reset_clk);
>  	if (ret)
> -		dev_err(motg->phy.dev, "usb phy clk deassert failed\n");
> +		dev_err(motg->phy.dev, "usb phy clk assert failed\n");

seems like you're doing more than *just* fixing the build error. Which
build error do you get ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/4ad9da10/attachment.sig>
