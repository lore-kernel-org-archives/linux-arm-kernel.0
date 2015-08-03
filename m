From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 3 Aug 2015 22:23:42 +0300
Subject: [PATCH] usb: ehci-platform: Fix using multiple controllers from OF
In-Reply-To: <1438629150-11662-1-git-send-email-albeu@free.fr>
References: <1438629150-11662-1-git-send-email-albeu@free.fr>
Message-ID: <55BFBFBE.5050905@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2015 10:12 PM, Alban Bedel wrote:

> When using OF defined controllers the platform data struct is shared
> between all devices, so it can't be used for device specific settings.
> However it is currently used for the OF properties
> needs-reset-on-resume and has-transaction-translator.

> To fix this issue move setting hcd->has_tt to the probe and
> move pdata->reset_on_resume to the private data.

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>   drivers/usb/host/ehci-platform.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2593def..40d029e 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -45,6 +45,7 @@ struct ehci_platform_priv {
>   	struct reset_control *rst;
>   	struct phy **phys;
>   	int num_phys;
> +	bool reset_on_resume;
>   };
>
>   static const char hcd_name[] = "ehci-platform";
[...]
> @@ -193,11 +193,11 @@ static int ehci_platform_probe(struct platform_device *dev)
>
>   		if (of_property_read_bool(dev->dev.of_node,
>   					  "needs-reset-on-resume"))
> -			pdata->reset_on_resume = 1;
> +			priv->reset_on_resume = 1;

    'true' since the typi is 'bool'.

[...]

MBR, Sergei
