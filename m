From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 15:35:16 +0000
Subject: [PATCH 1/5] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <1321036026-23411-2-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20111116153516.GB2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:02PM +0000, Pawel Moll wrote:
> This patch gets rid of the MMIO_P2V and __MMPIO_P2V macros,
> defining constant virtual base for motherboard and tile
> peripherals instead.
> 
> Additionally, in preparation for the new motherboard memory
> map, the motherboard peripherals are using base pointers
> calculated in runtime, instead of compile-time calculated
> values.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/include/asm/hardware/arm_timer.h         |    5 ++
>  arch/arm/mach-vexpress/core.h                     |   12 +++-
>  arch/arm/mach-vexpress/ct-ca9x4.c                 |   52 ++++-------------
>  arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |   13 ++---
>  arch/arm/mach-vexpress/include/mach/motherboard.h |   53 ++++++++---------
>  arch/arm/mach-vexpress/platsmp.c                  |    4 +-
>  arch/arm/mach-vexpress/v2m.c                      |   64 ++++++++++++++-------
>  7 files changed, 100 insertions(+), 103 deletions(-)

[...]

> diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
> index 2b1e836..47c0733 100644
> --- a/arch/arm/mach-vexpress/ct-ca9x4.c
> +++ b/arch/arm/mach-vexpress/ct-ca9x4.c
> @@ -30,57 +30,26 @@
>  
>  #include <plat/clcd.h>
>  
> -#define V2M_PA_CS7	0x10000000
> -
>  static struct map_desc ct_ca9x4_io_desc[] __initdata = {
>  	{
> -		.virtual	= __MMIO_P2V(CT_CA9X4_MPIC),
> -		.pfn		= __phys_to_pfn(CT_CA9X4_MPIC),
> -		.length		= SZ_16K,
> -		.type		= MT_DEVICE,
> -	}, {
> -		.virtual	= __MMIO_P2V(CT_CA9X4_SP804_TIMER),
> -		.pfn		= __phys_to_pfn(CT_CA9X4_SP804_TIMER),
> -		.length		= SZ_4K,
> -		.type		= MT_DEVICE,
> -	}, {
> -		.virtual	= __MMIO_P2V(CT_CA9X4_L2CC),
> -		.pfn		= __phys_to_pfn(CT_CA9X4_L2CC),
> -		.length		= SZ_4K,
> -		.type		= MT_DEVICE,
> +		.virtual        = V2T_PERIPH,
> +		.pfn            = __phys_to_pfn(CT_CA9X4_MPIC),
> +		.length         = SZ_8K,

Can you explain the size change?

[...]

> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 1fafc32..b84fa45 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c

[...]

> @@ -413,6 +431,10 @@ static void __init v2m_populate_ct_desc(void)
>  static void __init v2m_map_io(void)
>  {
>  	iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
> +
> +	/* Will become an ioremap() when possible */
> +	v2m_sysreg_base = V2M_PERIPH_P2V(V2M_SYSREGS);

linux/of_fdt.h has functions for manipulating the flattened device tree
blob.

Could that solve our problem?  We just need to get the root node compatible
property out.

Is there anything else blocking the building of legacy and RS1 memory
maps into a single kernel?

(I'm still hazy on how all the remapping stuff works, myself.)


Cheers
---Dave
