From: robherring2@gmail.com (Rob Herring)
Date: Sun, 04 Sep 2011 23:00:46 -0500
Subject: [PATCH] mach-integrator: fix VGA base regression
In-Reply-To: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
References: <1315172408-18957-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4E64496E.1090000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 09/04/2011 04:40 PM, Linus Walleij wrote:
> The changes introduced in commit
> cc22b4c18540e5e8bf55c7d124044f9317527d3c
> "ARM: set vga memory base at run-time"
> 
> Makes the Integrator/AP freeze completely. I appears that
> this is due to the VGA base address being assigned at PCI
> init time, while this base is needed earlier than that.
> Moving the initialization of the base address to the
> .map_io function solves this problem.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/mach-integrator/integrator_ap.c |    2 ++
>  arch/arm/mach-integrator/pci_v3.c        |    2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index 2fbbdd5..4d88fc4 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -32,6 +32,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/mtd/physmap.h>
> +#include <video/vga.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/platform.h>
> @@ -154,6 +155,7 @@ static struct map_desc ap_io_desc[] __initdata = {
>  static void __init ap_map_io(void)
>  {
>  	iotable_init(ap_io_desc, ARRAY_SIZE(ap_io_desc));
> +	vga_base = PCI_MEMORY_VADDR;
>  }
>  
>  #define INTEGRATOR_SC_VALID_INT	0x003fffff
> diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
> index dd56bfb..11b86e5 100644
> --- a/arch/arm/mach-integrator/pci_v3.c
> +++ b/arch/arm/mach-integrator/pci_v3.c
> @@ -27,7 +27,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> -#include <video/vga.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/platform.h>
> @@ -505,7 +504,6 @@ void __init pci_v3_preinit(void)
>  
>  	pcibios_min_io = 0x6000;
>  	pcibios_min_mem = 0x00100000;
> -	vga_base = PCI_MEMORY_VADDR;
>  
>  	/*
>  	 * Hook in our fault handler for PCI errors

Should the VGA memory really be accessed before PCI host is initialized?

Rob
