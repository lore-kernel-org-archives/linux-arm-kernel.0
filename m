From: rogershimizu@gmail.com (Roger Shimizu)
Date: Wed, 23 Mar 2016 07:54:35 +0900
Subject: [PATCH] ARM: dts: orion5x: add device tree for kurobox-pro
In-Reply-To: <20160322164200.GH5250@lunn.ch>
References: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
 <20160322164200.GH5250@lunn.ch>
Message-ID: <CAEQ9gEniE1CGaSb46uWDdg1AU0VWEU-Eq8uVF7X7Rxn1jM+KUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

Thanks for your review!

On Wed, Mar 23, 2016 at 1:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Mar 22, 2016 at 11:28:18PM +0900, Roger Shimizu wrote:
>> Add dts file to support Buffalo/Revogear Kurobox-Pro, which is marvell
>> orion5x based 3.5" HDD NAS.
>>
>> It's a quite old product and already discontinued. So there's no
>> official website for it. But it was an early product which used marvell
>> orion5x 88F5182 chipset, it's popular in the community.
>> Some unofficial site:
>>   - http://buffalo.nas-central.org/wiki/Category:KuroboxPro
>>   - http://nice.kaze.com/KUROPRO_ProductSpecifications.pdf
>>
>> This device tree is based on the board file:
>>   arch/arm/mach-orion5x/kurobox_pro-setup.c
>
> Hi Roger
>
> This looks good, but lets try to figure out the NAND.
>
>> However, the NAND device, which is supported by board file, is not
>> supported by device tree yet. So I still want to keep the board file
>> for the time being.
>
>> +&devbus_cs0 {
>> +     status = "disabled";
>> +     devbus,keep-config;
>> +
>> +     /* According to board file: arch/arm/mach-orion5x/kurobox_pro-setup.c
>> +      * There's a NAND flash on Device Bus CS0, but it fails on probing,
>> +      * so it's disabled here.
>> +      */
>> +
>> +     flash at 0 {
>> +             compatible = "cfi-flash";
>> +             reg = <0 0x1000000>;
>> +             bank-width = <1>;
>> +     };
>> +};
>
> kurobox_pro-setup.c says:
>
> /*
>  * 256K NOR flash Device bus boot chip select
>  */
>
> #define KUROBOX_PRO_NOR_BOOT_BASE       0xf4000000
> #define KUROBOX_PRO_NOR_BOOT_SIZE       SZ_256K
>
> /*
>  * 256M NAND flash on Device bus chip select 1
>  */
>
> #define KUROBOX_PRO_NAND_BASE           0xfc000000
> #define KUROBOX_PRO_NAND_SIZE           SZ_2M
>
> So there is a NOR on CS0, not NAND.

The NOR is on Device Bus Boot, which described in
orion5x-linkstation.dtsi and is the probed OK:

[    1.843221] Found: SST 39LF020
[    1.846391] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
[    1.852715] number of JEDEC chips: 1
[    1.872860] 3 ofpart partitions found on MTD device f4000000.flash
[    1.879122] Creating 3 MTD partitions on "f4000000.flash":
[    1.884697] 0x000000000000-0x000000030000 : "header"
[    1.893209] 0x000000030000-0x00000003f000 : "uboot"
[    1.901671] 0x00000003f000-0x000000040000 : "uboot_env"


The NAND, which is on Device Bus CS0, has probing issue. I only can
have it probed by the board file:

[    8.698762] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xda
[    8.705194] nand: ST Micro NAND 256MiB 3,3V 8-bit
[    8.709953] nand: 256 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    8.717619] Scanning device for bad blocks
[    8.782220] Bad eraseblock 1530 at 0x00000bf40000
[    8.794409] Bad eraseblock 1718 at 0x00000d6c0000
[    8.806717] Bad eraseblock 1909 at 0x00000eea0000
[    8.816968] Creating 3 MTD partitions on "orion_nand":
[    8.822169] 0x000000000000-0x000000400000 : "uImage"
[    8.830605] 0x000000400000-0x000004400000 : "rootfs"
[    8.839497] 0x000004400000-0x000010000000 : "extra"

> static struct platform_device kurobox_pro_nand_flash = {
>         .name           = "orion_nand",
>         .id             = -1,
>         .dev            = {
>                 .platform_data  = &kurobox_pro_nand_data,
>         },
>         .resource       = &kurobox_pro_nand_resource,
>         .num_resources  = 1,
> };
>
> The name "orion_nand" means this fits with the driver:
>
> drivers/mtd/nand/orion_nand.c:
>
> static struct platform_driver orion_nand_driver = {
>         .remove         = orion_nand_remove,
>         .driver         = {
>                 .name   = "orion_nand",
>                 .of_match_table = of_match_ptr(orion_nand_of_match_table),
>         },
> };
>
> And this uses compatible string         { .compatible = "marvell,orion-nand", },
>
> We need to add this to the dts file. The kirkwood.dtsi might be a good
> example to copy.

I already tried to use 'compatible = "marvell,orion-nand"' in flash
block of devbus_cs0 part, but with no luck.

So you mean I need to refer the nand block in mbus part in kirkwood.dtsi?

        nand: nand at 012f {
            #address-cells = <1>;
            #size-cells = <1>;
            cle = <0>;
            ale = <1>;
            bank-width = <1>;
            compatible = "marvell,orion-nand";
            reg = <MBUS_ID(0x01, 0x2f) 0 0x400>;
            chip-delay = <25>;
            /* set partition map and/or chip-delay in board dts */
            clocks = <&gate_clk 7>;
            pinctrl-0 = <&pmx_nand>;
            pinctrl-names = "default";
            status = "disabled";
        };

The difficulty for me is I have no idea on
- which clock to use
- which mpp pin to use
- how to set these address

And anohter question is, so the NAND is actually on mbus/nand, not
Device Bus CS0?
I say CS0 because it's described in board file, which may be wrong?

Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 17B3ACB1
