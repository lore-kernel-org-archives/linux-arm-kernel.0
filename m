From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 26 Jan 2016 02:20:34 +0900
Subject: [PATCH v2] ARM: dts: orion5x: gpio pin fixes for linkstation
 lswtgl
In-Reply-To: <87d1spel60.fsf@free-electrons.com>
References: <1453286688-9533-1-git-send-email-rogershimizu@gmail.com>
 <1453388436-8390-1-git-send-email-rogershimizu@gmail.com>
 <87d1spel60.fsf@free-electrons.com>
Message-ID: <CAEQ9gE=NoUpnqaPaz4UU8PB8G68rDTaemDM_nuWEqr6R5wPXPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew, Gregory,

On Tue, Jan 26, 2016 at 12:25 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Roger,
>
>  On jeu., janv. 21 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:
>
>> Here're a few gpio pin related fixes:
>>   - remove pinctrl-0 definition from pinctrl, since those pins are used
>>     in other places such as gpio-fan and regulators.
>>   - keep initial state of power led
>>   - fix for alarm pin of gpio-fan.
>>
>> Fixes: dc57844a736f ("ARM: dts: orion5x: add buffalo linkstation ls-wtgl")
>> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
>
> Applied on mvebu/fixes with Andrew Reviewed-by tag

Thanks for the review and apply of my patch!
After this patch, now there's not any error/warning in dmesg. I feel great!

However, there's still one thing missing, the MTD, which stores the
u-boot environment.
Maybe you're not the right person to ask this question, but I believe
you know how to reach the right one.
Please help, or forward to the right person for me. Thank you!

For the kirkwood based Linkstation, such as LS-WXL or LS-WVL, the MTD
is a spi/m25p40 device.
But for LS-WTGL orion5x based Linkstation, I tried a few ways, still
cannot get the MTD device out.

I also referred the orion5x-rd88f5182-nas.dts, to add
devbus_bootcs/devbus_cs1, but didn't work.

The MTD working kernel is a patch for kernel 2.6, which is not DTB,
but in lagacy way.
The patch can be get from:
- https://github.com/rogers0/linux-2.6_squeeze-security/blob/master/debian/patches/features/arm/ls-produo/01_ls-produo_driver.patch

MTD related part seems like:

+#define LSPRODUO_NOR_BOOT_BASE 0xf4000000
+#define LSPRODUO_NOR_BOOT_SIZE SZ_256K

+static struct resource lsproduo_nor_flash_resource = {
+ .flags = IORESOURCE_MEM,
+ .start = LSPRODUO_NOR_BOOT_BASE,
+ .end = LSPRODUO_NOR_BOOT_BASE + LSPRODUO_NOR_BOOT_SIZE - 1,
+};

+static struct platform_device lsproduo_nor_flash = {
+ .name = "physmap-flash",
+ .id = 0,
+ .dev = {
+ .platform_data = &lsproduo_nor_flash_data,
+ },
+ .num_resources = 1,
+ .resource = &lsproduo_nor_flash_resource,
+};

+ orion5x_setup_dev_boot_win(LSPRODUO_NOR_BOOT_BASE,
+ LSPRODUO_NOR_BOOT_SIZE);
+ platform_device_register(&lsproduo_nor_flash);

I'd appreciate your help!

Cheers,
Roger
