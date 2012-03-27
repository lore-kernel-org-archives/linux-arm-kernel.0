From: balbi@ti.com (Felipe Balbi)
Date: Tue, 27 Mar 2012 11:54:27 +0300
Subject: [PATCH] ARM: OMAP: fix section mismatches in usb-host.c
In-Reply-To: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
References: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20120327085426.GI7379@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 04:51:10PM +0200, Igor Grinberg wrote:
> Fix the below section mismatch warning and alike:
> 
> WARNING: vmlinux.o(.text+0x281d4): Section mismatch in reference from
> the function setup_ehci_io_mux() to the function
> .init.text:omap_mux_init_signal()
> The function setup_ehci_io_mux() references
> the function __init omap_mux_init_signal().
> This is often because setup_ehci_io_mux lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/usb-host.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index f51348d..dde8a11 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -54,7 +54,7 @@ static struct omap_device_pm_latency omap_uhhtll_latency[] = {
>  /*
>   * setup_ehci_io_mux - initialize IO pad mux for USBHOST
>   */
> -static void setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
> +static void __init setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_EHCI_PORT_MODE_PHY:
> @@ -197,7 +197,8 @@ static void setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  	return;
>  }
>  
> -static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
> +static
> +void __init setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_EHCI_PORT_MODE_PHY:
> @@ -315,7 +316,7 @@ static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  	}
>  }
>  
> -static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
> +static void __init setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> @@ -412,7 +413,8 @@ static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  	}
>  }
>  
> -static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
> +static
> +void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> -- 
> 1.7.3.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120327/b002ec64/attachment.sig>
