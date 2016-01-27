From: rogershimizu@gmail.com (Roger Shimizu)
Date: Wed, 27 Jan 2016 19:03:23 +0900
Subject: [PATCH v2] ARM: dts: orion5x: gpio pin fixes for linkstation
 lswtgl
In-Reply-To: <CAEQ9gE=NoUpnqaPaz4UU8PB8G68rDTaemDM_nuWEqr6R5wPXPA@mail.gmail.com>
References: <1453286688-9533-1-git-send-email-rogershimizu@gmail.com>
 <1453388436-8390-1-git-send-email-rogershimizu@gmail.com>
 <87d1spel60.fsf@free-electrons.com>
 <CAEQ9gE=NoUpnqaPaz4UU8PB8G68rDTaemDM_nuWEqr6R5wPXPA@mail.gmail.com>
Message-ID: <CAEQ9gEnn3o6a5NEZDLXHDeAapzTsHwCcHQX_RSA65paO5xyH=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 2:20 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
>
> However, there's still one thing missing, the MTD, which stores the
> u-boot environment.
> Maybe you're not the right person to ask this question, but I believe
> you know how to reach the right one.
> Please help, or forward to the right person for me. Thank you!
>
> For the kirkwood based Linkstation, such as LS-WXL or LS-WVL, the MTD
> is a spi/m25p40 device.
> But for LS-WTGL orion5x based Linkstation, I tried a few ways, still
> cannot get the MTD device out.
>
> I also referred the orion5x-rd88f5182-nas.dts, to add
> devbus_bootcs/devbus_cs1, but didn't work.
>
> The MTD working kernel is a patch for kernel 2.6, which is not DTB,
> but in lagacy way.
> The patch can be get from:
> - https://github.com/rogers0/linux-2.6_squeeze-security/blob/master/debian/patches/features/arm/ls-produo/01_ls-produo_driver.patch
>
> MTD related part seems like:
>
> +#define LSPRODUO_NOR_BOOT_BASE 0xf4000000
> +#define LSPRODUO_NOR_BOOT_SIZE SZ_256K
>
> +static struct resource lsproduo_nor_flash_resource = {
> + .flags = IORESOURCE_MEM,
> + .start = LSPRODUO_NOR_BOOT_BASE,
> + .end = LSPRODUO_NOR_BOOT_BASE + LSPRODUO_NOR_BOOT_SIZE - 1,
> +};
>
> +static struct platform_device lsproduo_nor_flash = {
> + .name = "physmap-flash",
> + .id = 0,
> + .dev = {
> + .platform_data = &lsproduo_nor_flash_data,
> + },
> + .num_resources = 1,
> + .resource = &lsproduo_nor_flash_resource,
> +};
>
> + orion5x_setup_dev_boot_win(LSPRODUO_NOR_BOOT_BASE,
> + LSPRODUO_NOR_BOOT_SIZE);
> + platform_device_register(&lsproduo_nor_flash);

I solved mtd problem by myself.

I read drivers/mtd/maps/physmap_of.c, then find the supported list of flash type
in struct of_device_id of_flash_match: cfi-flash, jedec-flash,
mtd-ram, mtd-rom, direct-mapped.

I previous refered the type in orion5x-rd88f5182-nas.dts is
"cfi-flash", as which I mentioned it never worked.
After I tired to use "jedec-flash", the mtd is working, dmesg as following:

[   12.863750] Found: SST 39LF020
[   12.866834] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
[   12.873194] number of JEDEC chips: 1
[   12.895609] 3 ofpart partitions found on MTD device f4000000.flash
[   12.901868] Creating 3 MTD partitions on "f4000000.flash":
[   12.907454] 0x000000000000-0x000000030000 : "header"
[   12.915764] 0x000000030000-0x00000003f000 : "uboot"
[   12.924022] 0x00000003f000-0x000000040000 : "uboot_env"

So I'll send patch to update orion5x-linkstation-lswtgl.dts soon.

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 17B3ACB1
