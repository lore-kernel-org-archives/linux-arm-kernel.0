From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Jun 2011 22:38:09 +0200
Subject: [PATCH v2 5/6] ARM: mxc: all three imx51 TOs use TO1 version of
	sdma script
In-Reply-To: <1308032407-3860-1-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-6-git-send-email-shawn.guo@linaro.org>
	<1308032407-3860-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110614203809.GA23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 02:20:07PM +0800, Shawn Guo wrote:
> Though there are three TOs of imx51 soc, the sdma script never
> changes since TO1, which means all three TOs of imx51 uses TO1
> version of sdma script.
> 
> The current code passes TO number to imx-sdma driver to load
> different firmware for different TO.  That means we have to prepare
> 3 identical firmwares, sdma-imx51-to1.bin sdma-imx51-to2.bin and
> sdma-imx51-to3.bin, to have the kernel capable of running on all
> three TOs.  This just makes no sense.
> 
> The patch removes the TO number passing and get the default TO1
> version of sdma firmware work for all TOs.

I don't agree to this approach. The SDMA firmware has been different on
all TO versions of earlier i.MXs. For the linearity of the universe we
should keep this. What about providing a link in userspace?

Sascha

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v1:
>  * fix typo in imx51 firmware name caught by Fabio Estevam
> 
>  arch/arm/plat-mxc/devices/platform-imx-dma.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> index c64f015..2091540 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> @@ -196,8 +196,6 @@ static int __init imxXX_add_imx_dma(void)
>  
>  #if defined(CONFIG_SOC_IMX51)
>  	if (cpu_is_mx51()) {
> -		int to_version = mx51_revision() >> 4;
> -		imx51_imx_sdma_data.pdata.to_version = to_version;
>  		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51;
>  		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
>  	} else
> -- 
> 1.7.4.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
