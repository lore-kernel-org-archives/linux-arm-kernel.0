From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 12 May 2015 08:31:35 +0200
Subject: [PATCH] ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)
In-Reply-To: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
References: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
Message-ID: <55519E47.7040008@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.05.2015 08:22, Michal Simek wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
>
> This patch is based on the
> commit 1a8e41cd672f ("ARM: 6395/1: VExpress: Set bit 22 in the PL310
> (cache controller) AuxCtlr register")


I've been under the impression that this shouldn't be done in the 
kernel, but in the boot loader/firmware:

https://lkml.org/lkml/2015/2/20/199

http://lists.denx.de/pipermail/u-boot/2015-March/207803.html

Best regards

Dirk


> Clearing bit 22 in the PL310 Auxiliary Control register (shared
> attribute override enable) has the side effect of transforming Normal
> Shared Non-cacheable reads into Cacheable no-allocate reads.
>
> Coherent DMA buffers in Linux always have a cacheable alias via the
> kernel linear mapping and the processor can speculatively load cache
> lines into the PL310 controller. With bit 22 cleared, Non-cacheable
> reads would unexpectedly hit such cache lines leading to buffer
> corruption.
>
> For Zynq, this fix avoids memory inconsistencies between Gigabit
> Ethernet controller (GEM) and CPU when DMA_CMA is disabled.
>
> Suggested-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>   arch/arm/mach-zynq/common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 39c1c7d43522..af36dc2545c1 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -197,8 +197,8 @@ static const char * const zynq_dt_match[] = {
>
>   DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
>   	/* 64KB way size, 8-way associativity, parity disabled */
> -	.l2c_aux_val	= 0x00000000,
> -	.l2c_aux_mask	= 0xffffffff,
> +	.l2c_aux_val    = 0x00400000,
> +	.l2c_aux_mask	= 0xffbfffff,
>   	.smp		= smp_ops(zynq_smp_ops),
>   	.map_io		= zynq_map_io,
>   	.init_irq	= zynq_irq_init,
>
