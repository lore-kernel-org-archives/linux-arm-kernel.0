From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 17:06:34 -0500 (EST)
Subject: [PATCH v5 6/7] ARM: ebsa110: use runtime ioremap hook
In-Reply-To: <1331070317-9598-6-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
 <1331070317-9598-6-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203061704180.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Convert ebsa110 platforms to use run-time ioremap hook instead of the
> compile time hook.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/mach-ebsa110/core.c            |   15 +++++++++++++++
>  arch/arm/mach-ebsa110/include/mach/io.h |    9 ---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
> index 804c912..e0b831e 100644
> --- a/arch/arm/mach-ebsa110/core.c
> +++ b/arch/arm/mach-ebsa110/core.c
> @@ -119,6 +119,20 @@ static void __init ebsa110_map_io(void)
>  	iotable_init(ebsa110_io_desc, ARRAY_SIZE(ebsa110_io_desc));
>  }
>  
> +static void __iomem *ebsa110_ioremap(unsigned long cookie, size_t size,
> +				     unsigned int flags)
> +{
> +	return (void __iomem *)cookie;
> +}
> +
> +static void ebsa110_iounmap(volatile void __iomem *io_addr)
> +{}
> +
> +static void __init ebsa110_init_early(void)
> +{
> +	arch_ioremap_caller = ebsa110_ioremap;

ebsa110_ioremap() appears to lack the caller argument, so this will 
generate a pointer mismatch error.


Nicolas
