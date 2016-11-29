From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 Nov 2016 15:03:43 +0100
Subject: [PATCH] USB: OHCI: use module_platform_driver macro
In-Reply-To: <1479822562-18719-1-git-send-email-csmanjuvijay@gmail.com>
References: <1479822562-18719-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <20161129140343.GB3605@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 01:49:22PM +0000, csmanjuvijay at gmail.com wrote:
> From: Manjunath Goudar <csmanjuvijay@gmail.com>
> 
> Use the module_platform_driver macro to do module init/exit.
> This eliminates a lot of boilerplate.This also removes
> checkpatch.pl errors.
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-usb at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/usb/host/ohci-nxp.c | 38 ++++++++++++++------------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index b7d4756..9908647 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -56,8 +56,6 @@ static struct hc_driver __read_mostly ohci_nxp_hc_driver;
>  
>  static struct i2c_client *isp1301_i2c_client;
>  
> -extern int usb_disabled(void);
> -
>  static struct clk *usb_host_clk;
>  
>  static void isp1301_configure_lpc32xx(void)
> @@ -127,6 +125,7 @@ static inline void isp1301_vbus_off(void)
>  static void ohci_nxp_start_hc(void)
>  {
>  	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
> +
>  	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
>  	isp1301_vbus_on();
>  }
> @@ -134,6 +133,7 @@ static void ohci_nxp_start_hc(void)
>  static void ohci_nxp_stop_hc(void)
>  {
>  	unsigned long tmp;
> +
>  	isp1301_vbus_off();
>  	tmp = __raw_readl(USB_OTG_STAT_CONTROL) & ~HOST_EN;
>  	__raw_writel(tmp, USB_OTG_STAT_CONTROL);

Why make these last two changes?  They are just coding style "fixups"
that have nothing to do with this patch :(

When you say "also" in a patch description, that's a huge flag that you
should be splitting the patch up into multiple patches.  Please do so
here.

thanks,

greg k-h
