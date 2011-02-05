From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Feb 2011 16:18:53 +0000
Subject: [PATCH 2/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <eee52c43-76da-4e47-9f40-4a2d7ee963b6@VA3EHSMHS032.ehs.local>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<eee52c43-76da-4e47-9f40-4a2d7ee963b6@VA3EHSMHS032.ehs.local>
Message-ID: <20110205161853.GC29411@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 09:08:42AM -0700, John Linn wrote:
> +void __init irq_init(void)
> +{
> +	gic_cpu_base_addr = (void __iomem *)SCU_GIC_CPU_BASE;

Just pass this address into gic_init - there's no need to initialize
this variable yourself anymore.

> +	gic_init(0, 29, (void __iomem *)SCU_GIC_DIST_BASE, gic_cpu_base_addr);
...
> +static struct map_desc io_desc[] __initdata = {
...
> +#ifdef CONFIG_DEBUG_LL
> +	{
> +		.virtual	= UART0_BASE,
> +		.pfn		= __phys_to_pfn(UART0_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
> +#endif

You shouldn't need to do this if your addruart macro in mach/debug-macros.S
is correctly returning the virtual and physical addresses in rp and rv.
