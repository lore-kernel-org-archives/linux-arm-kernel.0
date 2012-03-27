From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 27 Mar 2012 11:44:12 +0530
Subject: [PATCH] ARM: OMAP: fix section mismatches in usb-host.c
In-Reply-To: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
References: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <4F715AB4.6070900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,
On Monday 26 March 2012 08:21 PM, Igor Grinberg wrote:
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
These functions are called from init section only so the functions also
should also have the __init
annotation.
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>

> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
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
