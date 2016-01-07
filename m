From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 7 Jan 2016 14:14:22 +0530
Subject: [PATCH] arm: pci: mark the dra7xx driver as broken
In-Reply-To: <20160107081102.GA6243@localhost.localdomain>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com> <20160107081102.GA6243@localhost.localdomain>
Message-ID: <568E2566.6000209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thursday 07 January 2016 01:41 PM, Richard Cochran wrote:
> This patch marks the dra7xx pci host driver as broken.  This driver
> was first merged in v3.17 and has never worked.  Although the driver
> compiles just fine, it is missing an essential device reset.  If the
> driver is included, the kernel locks up hard shortly after booting,
> before any console output appears.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> 
> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d5e58ba..d83e8f0 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -5,6 +5,7 @@ config PCI_DRA7XX
>  	bool "TI DRA7xx PCIe controller"
>  	select PCIE_DW
>  	depends on OF && HAS_IOMEM && TI_PIPE3
> +	depends on BROKEN

In my point of view the driver is not broken as such but an independent piece
(reset) which is missing, since this driver compiles and works fine if that
reset piece is added. You are right in that this shouldn't have been probed
since it's known that the reset piece is missing. Maybe we should just set
"status = disabled" in dra7.dtsi and when that reset piece is added enable it
back in dra7-evm.dts?

Thanks
Kishon
>  	help
>  	 Enables support for the PCIe controller in the DRA7xx SoC.  There
>  	 are two instances of PCIe controller in DRA7xx.  This controller can
> 
