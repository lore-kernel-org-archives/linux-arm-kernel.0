From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 19 May 2016 10:06:53 -0400 (EDT)
Subject: [PATCH] usb: echi-hcd: Add ehci_setup check before echi_shutdown
In-Reply-To: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1605191005590.1565-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 May 2016, Srinivas Kandagatla wrote:

> This patch protects system from crashing at shutdown in
> cases where usb host is not added yet from OTG controller driver.
> As ehci_setup() not done yet, so stop accessing registers or
> variables initialized as part of ehci_setup().
> 
> The use case is simple, for boards like DB410c where the usb host
> or device functionality is decided based on the micro-usb cable
> presence. If the board boots up with micro-usb connected, the
> OTG driver like echi-msm would not add the usb host by default.
> However a system shutdown would go and access registers and
> uninitialized variables, resulting in below crash.

...

> Fixes 4bb3cad7125b ("usb: host: ehci-msm: Register usb shutdown function")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/usb/host/ehci-hcd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index ae1b6e6..a962b89 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -368,6 +368,15 @@ static void ehci_shutdown(struct usb_hcd *hcd)
>  {
>  	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
>  
> +	/**
> +	 * Protect the system from crashing at system shutdown in cases where
> +	 * usb host is not added yet from OTG controller driver.
> +	 * As ehci_setup() not done yet, so stop accessing registers or
> +	 * variables initialized in ehci_setup()
> +	 */
> +	if (!ehci->sbrn)
> +		return;
> +
>  	spin_lock_irq(&ehci->lock);
>  	ehci->shutdown = true;
>  	ehci->rh_state = EHCI_RH_STOPPING;

Acked-by: Alan Stern <stern@rowland.harvard.edu>
