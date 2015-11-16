From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2015 18:39:41 +0000
Subject: [RFC] ARM64: simplify dma_get_ops
In-Reply-To: <4270550.cGd11OgA5n@wuerfel>
References: <4270550.cGd11OgA5n@wuerfel>
Message-ID: <20151116183941.GF6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 05:25:48PM +0100, Arnd Bergmann wrote:
> Including linux/acpi.h from asm/dma-mapping.h causes tons of compile-time
> warnings, e.g.
> 
>  drivers/isdn/mISDN/dsp_ecdis.h:43:0: warning: "FALSE" redefined
>  drivers/isdn/mISDN/dsp_ecdis.h:44:0: warning: "TRUE" redefined
>  drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
>  drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
> 
> However, it looks like the dependency should not even there as
> I do not see why __generic_dma_ops() cares about whether we have
> an ACPI based system or not.
> 
> The current behavior is to fall back to the global dma_ops when
> a device has not set its own dma_ops, but only for DT based systems.
> This seems dangerous, as a random device might have different
> requirements regarding IOMMU or coherency, so we should really
> never have that fallback and just forbid DMA when we have not
> initialized DMA for a device.

I think this is from the days when we didn't have an
arch_setup_dma_ops() to be called from the DT code.

I did placed a WARN_ON() to see who's getting the dummy_dma_ops and it
triggered this call trace:

WARNING: at /work/Linux/linux-2.6-aarch64/arch/arm64/include/asm/dma-mapping.h:40
Modules linked in:

CPU: 3 PID: 1 Comm: swapper/0 Tainted: G        W       4.4.0-rc1+ #601
Hardware name: Juno (DT)
task: ffffffc9768a0000 ti: ffffffc9768a8000 task.ti: ffffffc9768a8000
PC is at ohci_platform_probe+0x2b8/0x518
LR is at ohci_platform_probe+0x2c/0x518
Call trace:
[<ffffffc0004920e0>] ohci_platform_probe+0x2b8/0x518
[<ffffffc0003e842c>] platform_drv_probe+0x54/0xb8
[<ffffffc0003e68d4>] driver_probe_device+0x1ec/0x2f0
[<ffffffc0003e6a74>] __driver_attach+0x9c/0xa0
[<ffffffc0003e4a10>] bus_for_each_dev+0x60/0xa0
[<ffffffc0003e61b8>] driver_attach+0x20/0x28
[<ffffffc0003e5dd8>] bus_add_driver+0x1d0/0x238
[<ffffffc0003e7218>] driver_register+0x60/0xf8
[<ffffffc0003e8328>] __platform_driver_register+0x40/0x48
[<ffffffc00086f720>] ohci_platform_init+0x50/0x60
[<ffffffc000082938>] do_one_initcall+0x90/0x1a0
[<ffffffc00084caac>] kernel_init_freeable+0x154/0x1f8
[<ffffffc0005e9c40>] kernel_init+0x10/0xe0
[<ffffffc000085c50>] ret_from_fork+0x10/0x40
ohci-platform: probe of 7ffb0000.ohci failed with error -5

I need to check whether we break anything by no longer returning
swiotlb_dma_ops.

> This removes the global dma_ops variable and the special-casing
> for ACPI, and just returns the dma ops that got set for the
> device, or the dummy_dma_ops if none were present.
> 
> The original code has apparently been copied from arm32 where we
> rely on it for ISA devices things like the floppy controller, but
> we should have no such devices on ARM64.

IIRC, this was required for DT before we had the arch_set_dma_ops()
(though I may be wrong, I haven't checked the logs). The dummy ops were
introduced with ACPI to avoid any default, I think this was related to
the _CCA property.

> @@ -985,7 +977,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  			struct iommu_ops *iommu, bool coherent)
>  {
>  	if (!acpi_disabled && !dev->archdata.dma_ops)
> -		dev->archdata.dma_ops = dma_ops;
> +		dev->archdata.dma_ops = &swiotlb_dma_ops;

Why do we still keep the !acpi_disabled check here? If I remove it, the
WARN_ON() above disappears.

-- 
Catalin
