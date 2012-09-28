From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 28 Sep 2012 15:06:12 +0200
Subject: [PATCH v3] Visstrim SM10: Use mo_version to decide board video
 mode.
In-Reply-To: <20120828074710.GX26594@pengutronix.de>
References: <1345457581-13837-1-git-send-email-javier.martin@vista-silicon.com>
 <20120828074710.GX26594@pengutronix.de>
Message-ID: <CACKLOr0HO4OapJk_-ktWcfwcnVD1MLfL6MF1bbaVUHjD5LVuJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,
this patch should originally go via arm-soc but it has a dependency on
support for coda video codec which is already in your tree.

Now that we've got Sascha's ack could you merge this patch through your tree?

Regards.

On 28 August 2012 09:47, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Aug 20, 2012 at 12:13:01PM +0200, Javier Martin wrote:
>> If the mother board version number is odd, emmaprp() for
>> format conversion + UVC camera will be used.
>>
>> Otherwise mx2_camera and m2m-deinterlacer will be registered.
>>
>> For both cases Coda video codec is registered.
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
>> ---
>> This patch should go through the media-tree because it depends on the following
>> patches that have already made through it:
>>
>>  [PATCH v2 3/3] Visstrim M10: Add support for Coda.
>>  [PATCH 2/2] i.MX27: Visstrim_M10: Add support for deinterlacing driver.
>>
>> For this reason I've added Mauro to CC and I will need Sascha's ACK.
>>
>> Changes since v2:
>> - Remove redundant 'return' pointed out by Baruch.
>> ---
>>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   52 ++++++++++++++++++++++++---
>>  1 file changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> index 176533e..1d6830f 100644
>> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> @@ -49,6 +49,10 @@
>>  #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
>>  #define SDHC1_IRQ IRQ_GPIOB(25)
>>
>> +#define VERSION_MASK         0x7
>> +#define MOTHERBOARD_SHIFT    4
>> +#define EXPBOARD_SHIFT               0
>> +
>>  #define MOTHERBOARD_BIT2     (GPIO_PORTD + 31)
>>  #define MOTHERBOARD_BIT1     (GPIO_PORTD + 30)
>>  #define MOTHERBOARD_BIT0     (GPIO_PORTD + 29)
>> @@ -205,7 +209,7 @@ static struct mx2_camera_platform_data visstrim_camera = {
>>  static phys_addr_t mx2_camera_base __initdata;
>>  #define MX2_CAMERA_BUF_SIZE SZ_8M
>>
>> -static void __init visstrim_camera_init(void)
>> +static void __init visstrim_analog_camera_init(void)
>>  {
>>       struct platform_device *pdev;
>>       int dma;
>> @@ -442,6 +446,27 @@ static void __init visstrim_deinterlace_init(void)
>>               return;
>>  }
>>
>> +/* Emma-PrP for format conversion */
>> +static void __init visstrim_emmaprp_init(void)
>> +{
>> +     struct platform_device *pdev;
>> +     int dma;
>> +
>> +     pdev = imx27_add_mx2_emmaprp();
>> +     if (IS_ERR(pdev))
>> +             return;
>> +
>> +     /*
>> +      * Use the same memory area as the analog camera since both
>> +      * devices are, by nature, exclusive.
>> +      */
>> +     dma = dma_declare_coherent_memory(&pdev->dev,
>> +                             mx2_camera_base, mx2_camera_base,
>> +                             MX2_CAMERA_BUF_SIZE,
>> +                             DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
>> +     if (!(dma & DMA_MEMORY_MAP))
>> +             pr_err("Failed to declare memory for emmaprp\n");
>> +}
>>
>>  static void __init visstrim_m10_revision(void)
>>  {
>> @@ -467,13 +492,14 @@ static void __init visstrim_m10_revision(void)
>>       mo_version |= !gpio_get_value(MOTHERBOARD_BIT0);
>>
>>       system_rev = 0x27000;
>> -     system_rev |= (mo_version << 4);
>> -     system_rev |= exp_version;
>> +     system_rev |= (mo_version << MOTHERBOARD_SHIFT);
>> +     system_rev |= (exp_version << EXPBOARD_SHIFT);
>>  }
>>
>>  static void __init visstrim_m10_board_init(void)
>>  {
>>       int ret;
>> +     int mo_version;
>>
>>       imx27_soc_init();
>>       visstrim_m10_revision();
>> @@ -505,8 +531,24 @@ static void __init visstrim_m10_board_init(void)
>>       platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
>>                                     &iclink_tvp5150, sizeof(iclink_tvp5150));
>>       gpio_led_register_device(0, &visstrim_m10_led_data);
>> -     visstrim_deinterlace_init();
>> -     visstrim_camera_init();
>> +
>> +     /* Use mother board version to decide what video devices we shall use */
>> +     mo_version = (system_rev >> MOTHERBOARD_SHIFT) & VERSION_MASK;
>> +     if (mo_version & 0x1) {
>> +             visstrim_emmaprp_init();
>> +
>> +             /*
>> +              * Despite not being used, tvp5150 must be
>> +              * powered on to avoid I2C problems. To minimize
>> +              * power consupmtion keep reset enabled.
>> +              */
>> +             gpio_set_value(TVP5150_PWDN, 1);
>> +             ndelay(1);
>> +             gpio_set_value(TVP5150_RSTN, 0);
>> +     } else {
>> +             visstrim_deinterlace_init();
>> +             visstrim_analog_camera_init();
>> +     }
>>       visstrim_coda_init();
>>  }
>>
>> --
>> 1.7.9.5


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
