From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Feb 2012 09:00:30 +0800
Subject: [PATCH] pxa/hx4700: Correct StrataFlash block size discovery
In-Reply-To: <1330303506.37736.YahooMailClassic@web29015.mail.ird.yahoo.com>
References: <1330303506.37736.YahooMailClassic@web29015.mail.ird.yahoo.com>
Message-ID: <CAN1soZyyhikS0Wot09ikigEkRQ7aR5FR3oVz-_xksk27fikU8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 8:45 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The HP iPAQ hx4700 has 128Mb of flash provided by two Intel StrataFlash devices.
> The hx4700 platform configuration defines a single 128Mb flash resource,
> resulting in the MTD physmap-flash driver probing the first device only and
> presuming the second device is identical:
>
> physmap platform flash device: 08000000 at 00000000
> physmap-flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x008816
> physmap-flash: Found 2 x16 devices at 0x4000000 in 32-bit bank
> <snip>
> erase region 0: offset=0x0,size=0x10000,blocks=4
> erase region 1: offset=0x40000,size=0x40000,blocks=255
> erase region 2: offset=0x4000000,size=0x10000,blocks=4
> erase region 3: offset=0x4040000,size=0x40000,blocks=255
> physmap-flash: 2 set(s) of 2 interleaved chips --> 32 partitions of 4096 KiB
>
> Unfortunately the two devices are not identical. The first has a device ID of
> 0x8816, identifying a bottom parameter device. The second has a device ID of
> 0x8813, identifying a top parameter device. By not probing the second device,
> physmap-flash does not discover the correct block sizes.
>
> This patch splits the configuration into two 64Mb flash resources, forcing
> physmap-flash to probe both devices and thus discover the correct block sizes:
>
> physmap platform flash device: 04000000 at 00000000
> physmap-flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x008816
> <snip>
> erase region 0: offset=0x0,size=0x10000,blocks=4
> erase region 1: offset=0x40000,size=0x40000,blocks=255
> physmap-flash: 1 set(s) of 2 interleaved chips --> 16 partitions of 4096 KiB
> physmap platform flash device: 04000000 at 04000000
> physmap-flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x008813
> <snip>
> erase region 0: offset=0x0,size=0x40000,blocks=255
> erase region 1: offset=0x3fc0000,size=0x10000,blocks=4
> physmap-flash: 1 set(s) of 2 interleaved chips --> 16 partitions of 4096 KiB
> Concatenating MTD devices:
> (0): "physmap-flash"
> (1): "physmap-flash"
> into device "physmap-flash"
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> --- clean-3.3-rc5/arch/arm/mach-pxa/hx4700.c ? ?2012-02-25 20:18:16.000000000 +0000
> +++ linux-3.3-rc5/arch/arm/mach-pxa/hx4700.c ? ?2012-02-27 00:02:55.530072120 +0000
> @@ -704,10 +704,17 @@ static void hx4700_set_vpp(struct platfo
> ? ? ? ?gpio_set_value(GPIO91_HX4700_FLASH_VPEN, vpp);
> ?}
>
> -static struct resource strataflash_resource = {
> - ? ? ? .start = PXA_CS0_PHYS,
> - ? ? ? .end ? = PXA_CS0_PHYS + SZ_128M - 1,
> - ? ? ? .flags = IORESOURCE_MEM,
> +static struct resource strataflash_resource[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start = PXA_CS0_PHYS,
> + ? ? ? ? ? ? ? .end ? = PXA_CS0_PHYS + SZ_64M - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start = PXA_CS0_PHYS + SZ_64M,
> + ? ? ? ? ? ? ? .end ? = PXA_CS0_PHYS + SZ_128M - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> ?};
>

Could you help to use DEFINE_RES_MEM() to define the resource?
Actually, I want to clean up the resource definition in arch-pxa.

Thanks
Haojian
