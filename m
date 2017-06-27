From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Jun 2017 17:37:04 -0500
Subject: [PATCH 1/4] ARM/PCI: iop13xx: address uninitialized variable
 warning
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
Message-ID: <20170627223704.GF17844@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 11:52:59PM +0200, Arnd Bergmann wrote:
> The last rework returned a variable that the compiler cannot prove
> to be initialized:
> 
> arch/arm/mach-iop13xx/pci.c: In function 'iop13xx_scan_bus':
> arch/arm/mach-iop13xx/pci.c:509:17: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> In the switch statement that sets the return value, this adds
> a default returning an error.
> 
> Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Folded into Lorenzo's series on pci/enumeration, thanks!

> ---
>  arch/arm/mach-iop13xx/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
> index b97879bfb81a..3c51a9bb9b49 100644
> --- a/arch/arm/mach-iop13xx/pci.c
> +++ b/arch/arm/mach-iop13xx/pci.c
> @@ -553,6 +553,8 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
>  		if (!ret)
>  			pci_bus_atue = bridge->bus;
>  		break;
> +	default:
> +		ret = -EINVAL;
>  	}
>  
>  	return ret;
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
