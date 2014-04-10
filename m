From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 10 Apr 2014 11:27:52 -0400 (EDT)
Subject: [PATCH v2 2/2] usb: ehci-platform: Return immediately from
 suspend if ehci_suspend fails
In-Reply-To: <1397125682-4955-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1404101127420.32351-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Apr 2014, Vivek Gautam wrote:

> Patch 'b8efdaf USB: EHCI: add check for wakeup/suspend race'
> adds a check for possible race between suspend and wakeup interrupt,
> and thereby it returns -EBUSY as error code if there's a wakeup
> interrupt.
> So the platform host controller should not proceed further with
> its suspend callback, rather should return immediately to avoid
> powering down the essential things, like phy.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> Changes from v1:
> -- Removed unnecessary change 'return 0'
> 
>  drivers/usb/host/ehci-platform.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b3a0e11..c7dd93a 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -303,6 +303,8 @@ static int ehci_platform_suspend(struct device *dev)
>  	int ret;
>  
>  	ret = ehci_suspend(hcd, do_wakeup);
> +	if (ret)
> +		return ret;
>  
>  	if (pdata->power_suspend)
>  		pdata->power_suspend(pdev);

Acked-by: Alan Stern <stern@rowland.harvard.edu>
