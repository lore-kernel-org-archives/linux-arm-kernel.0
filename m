From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Oct 2012 09:50:12 +0300
Subject: [PATCH v2 3/3] ARM: OMAP: ocp2scp: create omap device for ocp2scp
In-Reply-To: <1349675983-23803-4-git-send-email-kishon@ti.com>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-4-git-send-email-kishon@ti.com>
Message-ID: <20121026065012.GC22206@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 08, 2012 at 11:29:43AM +0530, Kishon Vijay Abraham I wrote:
> Platfrom device for ocp2scp is created using omap_device_build in
> devices file. This is used for both omap4(musb) and omap5(dwc3).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   76 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c8c2117..ac2bfce 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/omap4-keypad.h>
> +#include <linux/platform_data/omap_ocp2scp.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -613,6 +614,80 @@ static void omap_init_vout(void)
>  static inline void omap_init_vout(void) {}
>  #endif
>  
> +#if defined(CONFIG_OMAP_OCP2SCP) || defined(CONFIG_OMAP_OCP2SCP_MODULE)
> +static int count_ocp2scp_devices(struct omap_ocp2scp_dev *ocp2scp_dev)
> +{
> +	int cnt	= 0;
> +
> +	while (ocp2scp_dev->drv_name != NULL) {
> +		cnt++;
> +		ocp2scp_dev++;
> +	}
> +
> +	return cnt;
> +}
> +
> +static void omap_init_ocp2scp(void)
> +{
> +	struct omap_hwmod	*oh;
> +	struct platform_device	*pdev;
> +	int			bus_id = -1, dev_cnt = 0, i;
> +	struct omap_ocp2scp_dev	*ocp2scp_dev;
> +	const char		*oh_name, *name;
> +	struct omap_ocp2scp_platform_data *pdata;
> +
> +	oh_name = "ocp2scp_usb_phy";
> +	name	= "omap-ocp2scp";

how about adding checks here to return early case we're not running on
OMAP4 or OMAP5 ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121026/7bf840dc/attachment.sig>
