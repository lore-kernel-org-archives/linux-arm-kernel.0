From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 20 Jul 2010 15:07:14 +0200
Subject: [RFC] arm: versatile: enable PCI I/O space
Message-ID: <AANLkTikiim-a8zM0PRDVVN078xBWeZt7ElwbC4oZsfXy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 11:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I believe I have found out what is actually going on with PCI I/O
> space mapping on the versatile platform, thanks to Catalin pointing
> me in the right direction.
>
> It seems that I/O space handling on the versatile platform is
> currently broken in multiple ways. Most importantly, the ports do
> not get mapped into the virtual address space at all.
>
> Also, there is some amount of confusion between PCI I/O
> space and other statically mapped MMIO registers in the
> platform code:
>
> * The __io_address() macro that is used to access the
> ?platform register maps to the same __io macro that gets
> ?used for I/O space.
>
> * The IO_SPACE_LIMIT is set to a value that is much larger
> ?than the total available space.
>
> * The I/O resource of the PCI bus is set to the physical
> ?address of the mapping, which is way outside of the
> ?actual I/O space limit as well as the address range that
> ?gets decoded by traditional PCI cards.
>
> * No attempt is made to stay outside of the ISA port range
> ?that some device drivers try access.
>
> * No resource gets requested as a child of ioport_resource,
> ?but an IORESOURCE_IO type mapping gets requested
> ?as a child of iomem_resource.
>
> This patch attempts to correct all of the above. This makes
> it possible to use virtio-pci based virtual devices as well
> as actual PCI cards including those with legacy ISA port
> ranges like VGA.
>
> Some of the issues seem to be duplicated on other platforms
> and if I got it right, we should probably do similar changes
> there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
> index 3dff864..27051a3 100644
> --- a/arch/arm/mach-versatile/core.c
> +++ b/arch/arm/mach-versatile/core.c
> @@ -200,26 +200,13 @@ static struct map_desc versatile_io_desc[] __initdata = {
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(VERSATILE_PCI_CFG_BASE),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = VERSATILE_PCI_CFG_BASE_SIZE,
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE
> - ? ? ? },
> -#if 0
> - ? ? ? {
> + ? ? ? }, {
> ? ? ? ? ? ? ? ?.virtual ? ? ? ?= ?VERSATILE_PCI_VIRT_MEM_BASE0,
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(VERSATILE_PCI_MEM_BASE0),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_16M,
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE
> - ? ? ? }, {
> - ? ? ? ? ? ? ? .virtual ? ? ? ?= ?VERSATILE_PCI_VIRT_MEM_BASE1,
> - ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(VERSATILE_PCI_MEM_BASE1),
> - ? ? ? ? ? ? ? .length ? ? ? ? = SZ_16M,
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> - ? ? ? }, {
> - ? ? ? ? ? ? ? .virtual ? ? ? ?= ?VERSATILE_PCI_VIRT_MEM_BASE2,
> - ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(VERSATILE_PCI_MEM_BASE2),
> - ? ? ? ? ? ? ? .length ? ? ? ? = SZ_16M,
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> ? ? ? ?},
> ?#endif
> -#endif
> ?};
>
> ?void __init versatile_map_io(void)
> diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
> index 4f8f99a..9b080ee 100644
> --- a/arch/arm/mach-versatile/include/mach/hardware.h
> +++ b/arch/arm/mach-versatile/include/mach/hardware.h
> @@ -29,25 +29,16 @@
> ?*/
> ?#define VERSATILE_PCI_VIRT_BASE ? ? ? ? ? ? ? ?(void __iomem *)0xe8000000ul
> ?#define VERSATILE_PCI_CFG_VIRT_BASE ? ?(void __iomem *)0xe9000000ul
> +#define VERSATILE_PCI_VIRT_MEM_BASE0 ? (void __iomem *)0xeb000000ul
>
> -#if 0
> -#define VERSATILE_PCI_VIRT_MEM_BASE0 ? 0xf4000000
> -#define VERSATILE_PCI_VIRT_MEM_BASE1 ? 0xf5000000
> -#define VERSATILE_PCI_VIRT_MEM_BASE2 ? 0xf6000000
> -
> -#define PCIO_BASE ? ? ? ? ? ? ? ? ? ? ?VERSATILE_PCI_VIRT_MEM_BASE0
> -#define PCIMEM_BASE ? ? ? ? ? ? ? ? ? ?VERSATILE_PCI_VIRT_MEM_BASE1
> -#endif
> -
> -/* CIK guesswork */
> -#define PCIBIOS_MIN_IO ? ? ? ? ? ? ? ? 0x44000000
> +#define PCIBIOS_MIN_IO ? ? ? ? ? ? ? ? 0x00001000

I guess this is true for other sub-architectures. Currently no idea
why they are all using different values. But 0x1000 seems to be
good value and maybe we should default all of them to this and
move it into some common place instead of defining them every
where.
