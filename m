From: hare@suse.de (Hannes Reinecke)
Date: Tue, 13 Oct 2015 07:47:28 +0200
Subject: [PATCH] scsi: advansys needs ISA dma api for ISA support
In-Reply-To: <5081546.QjQ32dGX2L@wuerfel>
References: <5081546.QjQ32dGX2L@wuerfel>
Message-ID: <561C9AF0.5000004@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 05:10 PM, Arnd Bergmann wrote:
> The advansys drvier uses the request_dma function that is used on ISA
> machines for the internal DMA controller, which causes build errors
> on platforms that have ISA slots but do not provide the ISA DMA API:
> 
> drivers/scsi/advansys.c: In function 'advansys_board_found':
> drivers/scsi/advansys.c:11300:10: error: implicit declaration of function 'request_dma' [-Werror=implicit-function-declaration]
> 
> The problem now showed up in ARM randconfig builds after commit
> 6571fb3f8b7f ("advansys: Update to version 3.5 and remove compilation
> warning") made it possible to build on platforms that have neither
> VIRT_TO_BUS nor ISA_DMA_API but that do have ISA.
> 
> This adds the missing dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index d2f480b04a52..d4aa6a1a806c 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -499,6 +499,7 @@ config SCSI_ADVANSYS
>  	tristate "AdvanSys SCSI support"
>  	depends on SCSI
>  	depends on ISA || EISA || PCI
> +	depends on ISA_DMA_API || !ISA
>  	help
>  	  This is a driver for all SCSI host adapters manufactured by
>  	  AdvanSys. It is documented in the kernel source in
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
