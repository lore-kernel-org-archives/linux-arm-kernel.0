From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 17 Jan 2015 15:30:45 -0500 (EST)
Subject: [PATCH 1/3] USB: host: ehci_atmel: Move global variables to
 private struct
In-Reply-To: <1421519013-22123-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Jan 2015, Sylvain Rochet wrote:

> This patch move Atmel EHCI global variables (clocks ptr and clocked
> boolean) to private struct atmel_ehci, appended at the end of the parent
> struct usb_hcd.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>  drivers/usb/host/ehci-atmel.c | 75 +++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index 2e0043b..a47fe3f 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -30,45 +30,62 @@ static const char hcd_name[] = "ehci-atmel";
>  static struct hc_driver __read_mostly ehci_atmel_hc_driver;
>  
>  /* interface and function clocks */
> -static struct clk *iclk, *fclk, *uclk;
> -static int clocked;
> +struct atmel_ehci {
> +	struct ehci_hcd	ehci;
> +
> +	struct clk *iclk;
> +	struct clk *fclk;
> +	struct clk *uclk;
> +	bool clocked;
> +};
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static void atmel_start_clock(void)
> +static inline struct atmel_ehci *hcd_to_atmel_ehci(struct usb_hcd *hcd)
> +{
> +	return (struct atmel_ehci *) hcd->hcd_priv;
> +}

This is not the right way to do it.  For an example of the right way, 
see the ehci-platform.c file.  Your private structure is stored in 
ehci->priv, and its size is specified by the .extra_priv_size member of 
an ehci_driver_overrides structure passed to ehci_init_driver().

Nevertheless, I approve the idea of getting rid of global variables.

Alan Stern
