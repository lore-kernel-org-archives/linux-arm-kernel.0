From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 16:52:03 +0200
Subject: [PATCH 1/3] ARM: mvebu: fix HW I/O coherency related deadlocks
In-Reply-To: <1466084547-31343-2-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 16 Jun 2016 15:42:25 +0200")
References: <1466084547-31343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1466084547-31343-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87r3bx9ofg.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., juin 16 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Until now, our understanding for HW I/O coherency to work on the
> Cortex-A9 based Marvell SoC was that only the PCIe regions should be
> mapped strongly-ordered. However, we were still encountering some
> deadlocks, especially when testing the CESA crypto engine. After
> checking with the HW designers, it was concluded that all the MMIO
> registers should be mapped as strongly ordered for the HW I/O coherency
> mechanism to work properly.
>
> This fixes some easy to reproduce deadlocks with the CESA crypto engine
> driver (dmcrypt on a sufficiently large disk partition).
>
> Tested-by: Terry Stockert <stockert@inkblotadmirer.me>
> Tested-by: Romain Perier <romain.perier@free-electrons.com>
> Cc: Terry Stockert <stockert@inkblotadmirer.me>
> Cc: Romain Perier <romain.perier@free-electrons.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/fixes

Thanks,

Gregory


> ---
>  arch/arm/mach-mvebu/coherency.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index 7e989d6..474abff 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -162,22 +162,16 @@ exit:
>  }
>  
>  /*
> - * This ioremap hook is used on Armada 375/38x to ensure that PCIe
> - * memory areas are mapped as MT_UNCACHED instead of MT_DEVICE. This
> - * is needed as a workaround for a deadlock issue between the PCIe
> - * interface and the cache controller.
> + * This ioremap hook is used on Armada 375/38x to ensure that all MMIO
> + * areas are mapped as MT_UNCACHED instead of MT_DEVICE. This is
> + * needed for the HW I/O coherency mechanism to work properly without
> + * deadlock.
>   */
>  static void __iomem *
> -armada_pcie_wa_ioremap_caller(phys_addr_t phys_addr, size_t size,
> -			      unsigned int mtype, void *caller)
> +armada_wa_ioremap_caller(phys_addr_t phys_addr, size_t size,
> +			 unsigned int mtype, void *caller)
>  {
> -	struct resource pcie_mem;
> -
> -	mvebu_mbus_get_pcie_mem_aperture(&pcie_mem);
> -
> -	if (pcie_mem.start <= phys_addr && (phys_addr + size) <= pcie_mem.end)
> -		mtype = MT_UNCACHED;
> -
> +	mtype = MT_UNCACHED;
>  	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
>  }
>  
> @@ -186,7 +180,7 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
>  	struct device_node *cache_dn;
>  
>  	coherency_cpu_base = of_iomap(np, 0);
> -	arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
> +	arch_ioremap_caller = armada_wa_ioremap_caller;
>  
>  	/*
>  	 * We should switch the PL310 to I/O coherency mode only if
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
