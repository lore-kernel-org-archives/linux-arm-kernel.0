From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 18 Sep 2015 11:46:13 +0530
Subject: [PATCH 16/16] phy: phy-core: fix initcall level
In-Reply-To: <1440592108-3740-17-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
 <1440592108-3740-17-git-send-email-holler@ahsoftware.de>
Message-ID: <55FBAC2D.1020301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 26 August 2015 05:58 PM, Alexander Holler wrote:
> The phy-core has to be initialized before other dependent usb-drivers,
> otherwise a crash might occur.
> 
> Currently phy_core_init() is called in the initcall-level device, which is
> the same level where most usb-drivers will end up. By luck this seemed to
> have been called most of the time before other usb-drivers without having
> been explicitly enforced. But if phy_core_init() is not called before a
> dependent driver, a null-pointer exception might occur (e.g. because the
> phy device class isn't registered).

Did you actually face a problem? IIUC the modules get loaded based on
the drivers/Makefile order (unless the other modules are in a different
initcall table).

IMHO the fix should be in the module that caused the crash. Change it to
use module_init?

Thanks
Kishon

> 
> To fix this, phy_core_init() is moved to the initcall-level fs (right
> before the standard initcall level device).
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  drivers/phy/phy-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index fc48fac..4945029 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -930,7 +930,7 @@ static int __init phy_core_init(void)
>  
>  	return 0;
>  }
> -module_init(phy_core_init);
> +fs_initcall_sync(phy_core_init);
>  
>  static void __exit phy_core_exit(void)
>  {
> 
