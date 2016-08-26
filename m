From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 26 Aug 2016 13:18:25 -0400 (EDT)
Subject: [PATCH 1/2] usb: ohci-sa1111: remove machine_has_neponset()
In-Reply-To: <E1bdKCC-0001lZ-1v@rmk-PC.armlinux.org.uk>
Message-ID: <Pine.LNX.4.44L0.1608261313030.1794-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2016, Russell King wrote:

> The neponset is a daughter board for the Assabet platform, which has a
> SA1111 chip on it.  If we're initialising the SA1111 OHCI, and we're
> part of a neponset, the host platform must be an Assabet.
> 
> This allows us to eliminate machine_has_neponset() from this driver,
> replacing it instead with machine_is_assabet(), and killing the
> mach/assabet.h include.

Silly question: What happens when there's an SA1111 OHCI controller on
an Assabet platform, but contained in something other than a neponset
daughterboard?

If that's a possible configuration, the test in the original driver 
would fail whereas the test in the patched driver would succeed.

Alan Stern

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/usb/host/ohci-sa1111.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
> index 2ac266d692a2..6dc5eaed8551 100644
> --- a/drivers/usb/host/ohci-sa1111.c
> +++ b/drivers/usb/host/ohci-sa1111.c
> @@ -15,7 +15,6 @@
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> -#include <mach/assabet.h>
>  #include <asm/hardware/sa1111.h>
>  
>  #ifndef CONFIG_SA1111
> @@ -127,7 +126,7 @@ static int sa1111_start_hc(struct sa1111_dev *dev)
>  	dev_dbg(&dev->dev, "starting SA-1111 OHCI USB Controller\n");
>  
>  	if (machine_is_xp860() ||
> -	    machine_has_neponset() ||
> +	    machine_is_assabet() ||
>  	    machine_is_pfs168() ||
>  	    machine_is_badge4())
>  		usb_rst = USB_RESET_PWRSENSELOW | USB_RESET_PWRCTRLLOW;
> 
