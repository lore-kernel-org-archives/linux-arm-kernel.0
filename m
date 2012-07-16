From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 16 Jul 2012 13:56:55 +0530
Subject: [PATCH 4/7] ARM: EXYNOS: Adding DRM platform device
In-Reply-To: <001d01cd5f4e$ff51c850$fdf558f0$%han@samsung.com>
References: <1341999741-15578-1-git-send-email-l.krishna@samsung.com>
 <1341999741-15578-5-git-send-email-l.krishna@samsung.com>
 <001d01cd5f4e$ff51c850$fdf558f0$%han@samsung.com>
Message-ID: <CAL1wa8d-Hq1mnwtRD9HR8Fopv2U8ka+s6ppbLbanFVqee4g-Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 3:51 PM, Jingoo Han <jg1.han@samsung.com> wrote:
>
>
>> -----Original Message-----
>> From: Leela Krishna Amudala [mailto:l.krishna at samsung.com]
>> Sent: Wednesday, July 11, 2012 6:42 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: grant.likely at secretlab.ca; olofj at google.com; thomas.ab at samsung.com; kgene.kim at samsung.com;
>> joshi at samsung.com; jg1.han at samsung.com
>> Subject: [PATCH 4/7] ARM: EXYNOS: Adding DRM platform device
>>
>> Add DRM platform device to machine file for exynos5.
>>
>> Signed-off-by: Prathyush K <prathyush.k@samsung.com>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> ---
>>  arch/arm/mach-exynos/mach-exynos5-dt.c |   27 +++++++++++++++++++++++++++
>>  1 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
>> index 652a537..a91c928 100644
>> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
>> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
>> @@ -17,6 +17,7 @@
>>
>>  #include <asm/mach/arch.h>
>>  #include <asm/hardware/gic.h>
>> +#include <asm/io.h>
>>  #include <mach/map.h>
>>
>>  #include <plat/cpu.h>
>> @@ -29,6 +30,22 @@
>>  #include <video/platform_lcd.h>
>>
>>
>> +static void exynos_fimd_gpio_setup_24bpp(void)
>> +{
>> +     unsigned int reg = 0;
>> +     /*
>> +      * Set DISP1BLK_CFG register for Display path selection
>> +      * FIMD of DISP1_BLK Bypass selection : DISP1BLK_CFG[15]
>> +      * ---------------------
>> +      * 0 | MIE/MDNIE
>> +      * 1 | FIMD : selected
>> +      */
>> +     reg = __raw_readl(S3C_VA_SYS + 0x0214);
>> +     reg &= ~(1 << 15);      /* To save other reset values */
>> +     reg |= (1 << 15);
>> +     __raw_writel(reg, S3C_VA_SYS + 0x0214);
>> +}
>> +
>>  static int smdk5250_bl_notify(struct device *unused, int brightness)
>>  {
>>       /* manage lcd_bl_en signal */
>> @@ -51,6 +68,14 @@ static struct platform_pwm_backlight_data smdk5250_bl_data = {
>>       .notify         = smdk5250_bl_notify,
>>  };
>>
>> +static struct platform_device exynos_drm_device = {
>> +     .name           = "exynos-drm",
>> +     .dev = {
>> +             .dma_mask = &exynos_drm_device.dev.coherent_dma_mask,
>> +             .coherent_dma_mask = 0xffffffffUL,
>> +     }
>> +};
>> +
>
>
> If your patches use ./drivers/video/s3c-fb.c, please use the term 'FB'.
> In this case, this 'exynos_drm_device' is not unnecessary.
>
> Um... Have you tested this patchset with board such as SMDK5250?
> Does it work properly?
>
>

Yes, I tested this patchset with smdk5250 board, and I could see bootup logo.

>>  static void lcd_set_power(struct plat_lcd_data *pd,
>>                       unsigned int power)
>>  {
>> @@ -134,6 +159,7 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>>
>>  static struct platform_device *smdk5250_devices[] __initdata = {
>>       &smdk5250_lcd, /* for platform_lcd device */
>> +     &exynos_drm_device,
>>  };
>>
>>  static void __init exynos5250_dt_map_io(void)
>> @@ -147,6 +173,7 @@ static void __init exynos5250_dt_machine_init(void)
>>       samsung_bl_set(&smdk5250_bl_gpio_info, &smdk5250_bl_data);
>>       of_platform_populate(NULL, of_default_bus_match_table,
>>                               exynos5250_auxdata_lookup, NULL);
>> +     exynos_fimd_gpio_setup_24bpp();
>>       platform_add_devices(smdk5250_devices, ARRAY_SIZE(smdk5250_devices));
>>  }
>>
>> --
>> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
