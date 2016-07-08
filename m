From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 8 Jul 2016 17:25:35 +0800
Subject: [PATCH v2 06/22] usb: chipidea: Add platform flag for wrapper
 phy management
In-Reply-To: <20160707222114.1673-7-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-7-stephen.boyd@linaro.org>
Message-ID: <20160708092535.GD20485@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:20:57PM -0700, Stephen Boyd wrote:
> The ULPI phy on qcom platforms needs to be initialized and
> powered on after a USB reset and before we toggle the run/stop
> bit. Otherwise, the phy locks up and doesn't work properly.
> Therefore, add a flag to skip any phy power management in the
> core layer, leaving it up to the glue driver to manage.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/core.c  | 6 ++++++
>  include/linux/usb/chipidea.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 01390e02ee53..532085a096d9 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -361,6 +361,9 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
>   */
>  static void ci_usb_phy_exit(struct ci_hdrc *ci)
>  {
> +	if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
> +		return;
> +
>  	if (ci->phy) {
>  		phy_power_off(ci->phy);
>  		phy_exit(ci->phy);
> @@ -379,6 +382,9 @@ static int ci_usb_phy_init(struct ci_hdrc *ci)
>  {
>  	int ret;
>  
> +	if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
> +		return 0;
> +

How you handle the code for PHY getting at probe?

-- 

Best Regards,
Peter Chen
