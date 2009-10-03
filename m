From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Oct 2009 20:41:55 +0100
Subject: Sparsemem  on EP93XX
In-Reply-To: <4AC7A3D4.3080408@techworks.ie>
References: <4AC7A3D4.3080408@techworks.ie>
Message-ID: <20091003194155.GA21857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 03, 2009 at 08:19:48PM +0100, Christian Gagneraud wrote:
> Hi all,
>
> I'm trying to get a TS72XX board working with sparsemem, but got unlucky 
> so far. I've read all related threads in the archive and especially this 
> one:
> http://marc.info/?l=linux-arm&m=122754446724900&w=2
>
> Here is the patch I've applied:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1c4119c..0f1d52f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -288,6 +288,7 @@ config ARCH_EP93XX
>         select CPU_ARM920T
>         select ARM_AMBA
>         select ARM_VIC
> +       select ARCH_SPARSEMEM_ENABLE
>         select GENERIC_GPIO
>         select HAVE_CLK
>         select COMMON_CLKDEV

In spite of the above...

> <7>On node 0 totalpages: 16384
> <6>bootmem::alloc_bootmem_core nid=0 size=1cb0000 [7344 pages] align=20 
> goal=e7ffffff limit=0
> <6>bootmem::alloc_bootmem_core nid=0 size=1cb0000 [7344 pages] align=20 
> goal=0 limit=0
> <1>bootmem alloc of 30081024 bytes failed!
> <0>Kernel panic - not syncing: Out of memory
> Backtrace:
> [<c001c750>] (dump_backtrace+0x0/0x10c) from [<c0120c0c>]  
> (dump_stack+0x18/0x1c)
>  r7:00000020 r6:c01618d0 r5:00000000 r4:01cb0000
> [<c0120bf4>] (dump_stack+0x0/0x1c) from [<c0120c5c>] (panic+0x4c/0x12c)
> [<c0120c10>] (panic+0x0/0x12c) from [<c000f298>]  
> (___alloc_bootmem+0x30/0x38)
>  r3:ffffffff r2:c0156140 r1:600000d3 r0:c0144420
> [<c000f268>] (___alloc_bootmem+0x0/0x38) from [<c000f310>]  
> (___alloc_bootmem_node+0x70/0x74)
>  r5:00000000 r4:c0017280
> [<c000f2a0>] (___alloc_bootmem_node+0x0/0x74) from [<c000f3ec>]  
> (__alloc_bootmem_node+0x44/0x90)
>  r8:c0160de4 r7:01cb0000 r6:e7ffffff r5:00000020 r4:c0160de4
> [<c000f3a8>] (__alloc_bootmem_node+0x0/0x90) from [<c0120a90>]  
> (alloc_node_mem_map+0x74/0x90)

This seems to suggest that sparsemem is still disabled, since
alloc_bootmem_node will only be called from alloc_node_mem_map
if FLAT_NODE_MEM_MAP is enabled, and this should not be enabled
with sparsemem.

Seeing your .config file might be useful.
