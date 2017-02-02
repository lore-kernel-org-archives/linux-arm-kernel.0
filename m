From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 02 Feb 2017 23:50:42 +0800
Subject: [PATCH v3 08/10] dmaengine: sun6i: allow build on ARM64 platforms
 (sun50i)
In-Reply-To: <20170131033236.GH19244@localhost>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-9-icenowy@aosc.xyz>
 <20170130164210.GD19244@localhost>
 <3729521485800635@web23g.yandex.ru> <20170131033236.GH19244@localhost>
Message-ID: <5605761486050642@web3m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



31.01.2017, 11:32, "Vinod Koul" <vinod.koul@intel.com>:
> On Tue, Jan 31, 2017 at 02:23:55AM +0800, Icenowy Zheng wrote:
>> ?31.01.2017, 00:41, "Vinod Koul" <vinod.koul@intel.com>:
>> ?> On Sun, Jan 29, 2017 at 10:33:29AM +0800, Icenowy Zheng wrote:
>> ?>> ?As 64-bit Allwinner H5 SoC has the same DMA engine with H3, the DMA
>> ?>> ?driver should be allowed to be built for ARM64, in order to make it work on H5.
>> ?>>
>> ?>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?>> ?Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ?>> ?Acked-by: Chen-Yu Tsai <wens@csie.org>
>> ?>> ?---
>> ?>> ?Patch introduced between v1 and v2, to satisfy the newly added H3/H5 audio
>> ?>> ?codec support.
>> ?>>
>> ?>> ??drivers/dma/Kconfig | 2 +-
>> ?>> ??1 file changed, 1 insertion(+), 1 deletion(-)
>> ?>>
>> ?>> ?diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> ?>> ?index 0d6a96ee9fc7..d01d59812cf3 100644
>> ?>> ?--- a/drivers/dma/Kconfig
>> ?>> ?+++ b/drivers/dma/Kconfig
>> ?>> ?@@ -157,7 +157,7 @@ config DMA_SUN4I
>> ?>>
>> ?>> ??config DMA_SUN6I
>> ?>> ??????????tristate "Allwinner A31 SoCs DMA support"
>> ?>> ?- depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
>> ?>> ?+ depends on MACH_SUN6I || MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>> ?>
>> ?> Do we really need ARM64 here? also looking at others I wonder why isn't
>> ?> this MACH_SUNXI...?
>>
>> ?You mean directly place "ARCH_SUNXI" here?
>>
>> ?SUN4I/SUN5I/SUN7I do not use DMA_SUN6I, they have different DMA
>> ?controllers.
>
> No my question was different..
>
> We have MACH_SUNxx for 6I and 8I, so why do we have ARCH_SUNXI and if its an
> arch SUNXI, X means it can take any value...
>
> This schema looks pretty confusing while reading

It's a weird schema made by the vendor.

> Also I had a question on usage of ARM64..

For ARM64, we have no MACH_SUN50I, as the only ARM64-capable series in SUNXI
is SUN50I. So I use (ARM64 && ARCH_SUNXI) here to represent "MACH_SUN50I".

P.S. Allwinner have sun4i(A10), sun5i(A13/A10s/GR8), sun6i(A31/A31s), sun7i(A20),
sun8i(A23/A33/H3/V3s/A83T), sun9i(A80), sun50i(A64/H5). From the sun6i
generation, things changed a lot; however, sun7i is a derivation of sun4i. In U-Boot,
every SoC after sun6i (except sun7i) have an option CONFIG_GEN_SUN6I.

This DMAengine driver is for the new generation DMA engine.

SUN4I, SUN5I and SUN7I have no hardware that uses such a DMAengine, so here's
MACH_SUN6I || MACH_SUN8I || (ARM64 && ARCH_SUNXI), to prevent it to be built
in a kernel that do not support any system with such a DMAengine.

>
> --
> ~Vinod
