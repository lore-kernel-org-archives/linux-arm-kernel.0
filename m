From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Feb 2012 15:06:19 -0800 (PST)
Subject: [PATCH v2] arm:orion: Fix USB phy for orion5x.
In-Reply-To: <1328712767-25725-1-git-send-email-andrew@lunn.ch>
References: <1328712767-25725-1-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.LFD.2.02.1202081502320.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Andrew Lunn wrote:

> The patch "ARM: orion: Consolidate USB platform setup code.", commit
> 4fcd3f374a928081d391cd9a570afe3b2c692fdc broke USB on TS-7800 and
> other orion5x boards, because the wrong type of PHY was being passed
> to the EHCI driver in the platform data. Orion5x needs EHCI_PHY_ORION
> and all the others want EHCI_PHY_NA.
> 
> Allow the mach- code to tell the generic plat-orion code which USB PHY
> enum to place into the platform data.
> 
> Versio 2: Rebase to v3.3-rc2.
> 
> Reported-by: Ambroz Bizjak <ambrop7@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Ambroz Bizjak <ambrop7@gmail.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

This also needs a CC: stable at vger.kernel.org

> ---
>  arch/arm/mach-dove/common.c               |    3 ++-
>  arch/arm/mach-kirkwood/common.c           |    3 ++-
>  arch/arm/mach-mv78xx0/common.c            |    3 ++-
>  arch/arm/mach-orion5x/common.c            |    4 +++-
>  arch/arm/plat-orion/common.c              |    9 ++++-----
>  arch/arm/plat-orion/include/plat/common.h |    3 ++-
>  6 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index dd1429a..bda7aca 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -28,6 +28,7 @@
>  #include <asm/mach/arch.h>
>  #include <linux/irq.h>
>  #include <plat/time.h>
> +#include <plat/ehci-orion.h>
>  #include <plat/common.h>
>  #include <plat/addr-map.h>
>  #include "common.h"
> @@ -71,7 +72,7 @@ void __init dove_map_io(void)
>   ****************************************************************************/
>  void __init dove_ehci0_init(void)
>  {
> -	orion_ehci_init(DOVE_USB0_PHYS_BASE, IRQ_DOVE_USB0);
> +	orion_ehci_init(DOVE_USB0_PHYS_BASE, IRQ_DOVE_USB0, EHCI_PHY_NA);
>  }
>  
>  /*****************************************************************************
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index cc15426..77d4852 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -27,6 +27,7 @@
>  #include <plat/cache-feroceon-l2.h>
>  #include <plat/mvsdio.h>
>  #include <plat/orion_nand.h>
> +#include <plat/ehci-orion.h>
>  #include <plat/common.h>
>  #include <plat/time.h>
>  #include <plat/addr-map.h>
> @@ -73,7 +74,7 @@ unsigned int kirkwood_clk_ctrl = CGC_DUNIT | CGC_RESERVED;
>  void __init kirkwood_ehci_init(void)
>  {
>  	kirkwood_clk_ctrl |= CGC_USB0;
> -	orion_ehci_init(USB_PHYS_BASE, IRQ_KIRKWOOD_USB);
> +	orion_ehci_init(USB_PHYS_BASE, IRQ_KIRKWOOD_USB, EHCI_PHY_NA);
>  }
>  
>  
> diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
> index 0cdd410..a5dcf766 100644
> --- a/arch/arm/mach-mv78xx0/common.c
> +++ b/arch/arm/mach-mv78xx0/common.c
> @@ -19,6 +19,7 @@
>  #include <mach/mv78xx0.h>
>  #include <mach/bridge-regs.h>
>  #include <plat/cache-feroceon-l2.h>
> +#include <plat/ehci-orion.h>
>  #include <plat/orion_nand.h>
>  #include <plat/time.h>
>  #include <plat/common.h>
> @@ -169,7 +170,7 @@ void __init mv78xx0_map_io(void)
>   ****************************************************************************/
>  void __init mv78xx0_ehci0_init(void)
>  {
> -	orion_ehci_init(USB0_PHYS_BASE, IRQ_MV78XX0_USB_0);
> +	orion_ehci_init(USB0_PHYS_BASE, IRQ_MV78XX0_USB_0, EHCI_PHY_NA);
>  }
>  
>  
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 0e28bae..5dad38e 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -29,6 +29,7 @@
>  #include <mach/hardware.h>
>  #include <mach/orion5x.h>
>  #include <plat/orion_nand.h>
> +#include <plat/ehci-orion.h>
>  #include <plat/time.h>
>  #include <plat/common.h>
>  #include <plat/addr-map.h>
> @@ -72,7 +73,8 @@ void __init orion5x_map_io(void)
>   ****************************************************************************/
>  void __init orion5x_ehci0_init(void)
>  {
> -	orion_ehci_init(ORION5X_USB0_PHYS_BASE, IRQ_ORION5X_USB0_CTRL);
> +	orion_ehci_init(ORION5X_USB0_PHYS_BASE, IRQ_ORION5X_USB0_CTRL,
> +			EHCI_PHY_ORION);
>  }
>  
>  
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index e5a2fde..089899a 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -789,10 +789,7 @@ void __init orion_xor1_init(unsigned long mapbase_low,
>  /*****************************************************************************
>   * EHCI
>   ****************************************************************************/
> -static struct orion_ehci_data orion_ehci_data = {
> -	.phy_version	= EHCI_PHY_NA,
> -};
> -
> +static struct orion_ehci_data orion_ehci_data;
>  static u64 ehci_dmamask = DMA_BIT_MASK(32);
>  
>  
> @@ -812,8 +809,10 @@ static struct platform_device orion_ehci = {
>  };
>  
>  void __init orion_ehci_init(unsigned long mapbase,
> -			    unsigned long irq)
> +			    unsigned long irq,
> +			    enum orion_ehci_phy_ver phy_version)
>  {
> +	orion_ehci_data.phy_version = phy_version;
>  	fill_resources(&orion_ehci, orion_ehci_resources, mapbase, SZ_4K - 1,
>  		       irq);
>  
> diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
> index 0fe08d7..a7fa005 100644
> --- a/arch/arm/plat-orion/include/plat/common.h
> +++ b/arch/arm/plat-orion/include/plat/common.h
> @@ -89,7 +89,8 @@ void __init orion_xor1_init(unsigned long mapbase_low,
>  			    unsigned long irq_1);
>  
>  void __init orion_ehci_init(unsigned long mapbase,
> -			    unsigned long irq);
> +			    unsigned long irq,
> +			    enum orion_ehci_phy_ver phy_version);
>  
>  void __init orion_ehci_1_init(unsigned long mapbase,
>  			      unsigned long irq);
> -- 
> 1.7.2.5
> 
