From: kosaki.motohiro@gmail.com (KOSAKI Motohiro)
Date: Mon, 29 Apr 2013 16:46:17 -0400
Subject: [PATCH] mm: add an option to disable bounce
In-Reply-To: <1366644180-6140-1-git-send-email-vinayakm.list@gmail.com>
References: <1366644180-6140-1-git-send-email-vinayakm.list@gmail.com>
Message-ID: <517EDC19.7020705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(4/22/13 11:23 AM), vinayakm.list at gmail.com wrote:
> From: Vinayak Menon <vinayakm.list@gmail.com>
> 
> There are times when HIGHMEM is enabled, but
> we don't prefer CONFIG_BOUNCE to be enabled.
> CONFIG_BOUNCE can reduce the block device
> throughput, and this is not ideal for machines
> where we don't gain much by enabling it. So
> provide an option to deselect CONFIG_BOUNCE. The
> observation was made while measuring eMMC throughput
> using iozone on an ARM device with 1GB RAM.
> 
> Signed-off-by: Vinayak Menon <vinayakm.list@gmail.com>
> ---
>  mm/Kconfig |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 3bea74f..29f9736 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -263,8 +263,14 @@ config ZONE_DMA_FLAG
>  	default "1"
>  
>  config BOUNCE
> +	bool "Enable bounce buffers"
>  	def_bool y
>  	depends on BLOCK && MMU && (ZONE_DMA || HIGHMEM)
> +	help
> +	  Enable bounce buffers for devices that cannot access
> +	  the full range of memory available to the CPU. Enabled
> +	  by default when ZONE_DMA or HIGMEM is selected, but you
> +	  may say n to override this.

This should depend on CONFIG_EXPERT. Because this makes typically worse result
on typical desktop machine.
