From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 22 Nov 2012 09:21:20 +0100
Subject: [PATCH v3 1/3] ARM: imx27_visstrim_m10: Do not reserve VPU DMA
 pool on board file
In-Reply-To: <20121122081421.GZ10369@pengutronix.de>
References: <1353334027-30009-1-git-send-email-fabio.estevam@freescale.com>
 <20121122081421.GZ10369@pengutronix.de>
Message-ID: <CACKLOr3Bi82E3bKZ=mJ5eK1PeTzFxmq5=ZAyH9vhjgSqVAmTWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22 November 2012 09:14, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Javier,
>
> Are you ok with this patch?

I don't fully agree with it.

> Sascha
>
> On Mon, Nov 19, 2012 at 12:07:05PM -0200, Fabio Estevam wrote:
>> Do not reserve VPU DMA pool on board file as this can be done via CMA.
>>
>> The motivation for doing this is to allow to register the VPU driver via a common
>> SoC file instead of per board.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v2:
>> - No changes. Newly introduced on this series
>>
>>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   21 ++-------------------
>>  1 file changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> index b744226..801b797 100644
>> --- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
>> @@ -264,7 +264,7 @@ static void __init visstrim_camera_init(void)
>>  static void __init visstrim_reserve(void)
>>  {
>>       /* reserve 4 MiB for mx2-camera */
>> -     mx2_camera_base = arm_memblock_steal(3 * MX2_CAMERA_BUF_SIZE,
>> +     mx2_camera_base = arm_memblock_steal(2 * MX2_CAMERA_BUF_SIZE,
>>                       MX2_CAMERA_BUF_SIZE);
>>  }

You can't reduce the size of the reserved memory pool without removing
every reference to (mx2_camera_base + 2 * MX2_CAMERA_BUF_SIZE) in
dma_declare_coherent_memory() calls. Otherwise we'll be trying to use
memory outside the pool.

Alternatively, and provided CMA works properly in i.MX27, which is
something I have not tested, you could just remove visstrim_reserve()
callback and every reference to dma_declare_coherent_memory().

>> @@ -434,23 +434,6 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
>>       .flags                  = IMX_SSI_DMA | IMX_SSI_SYN,
>>  };
>>
>> -/* coda */
>> -
>> -static void __init visstrim_coda_init(void)
>> -{
>> -     struct platform_device *pdev;
>> -     int dma;
>> -
>> -     pdev = imx27_add_coda();
>> -     dma = dma_declare_coherent_memory(&pdev->dev,
>> -                                       mx2_camera_base + MX2_CAMERA_BUF_SIZE,
>> -                                       mx2_camera_base + MX2_CAMERA_BUF_SIZE,
>> -                                       MX2_CAMERA_BUF_SIZE,
>> -                                       DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
>> -     if (!(dma & DMA_MEMORY_MAP))
>> -             return;
>> -}
>> -
>>  /* DMA deinterlace */
>>  static struct platform_device visstrim_deinterlace = {
>>       .name = "m2m-deinterlace",
>> @@ -548,7 +531,7 @@ static void __init visstrim_m10_board_init(void)
>>       gpio_led_register_device(0, &visstrim_m10_led_data);
>>       visstrim_deinterlace_init();
>>       visstrim_camera_init();
>> -     visstrim_coda_init();
>> +     imx27_add_coda();
>>  }
>>
>>  static void __init visstrim_m10_timer_init(void)
>> --
>> 1.7.9.5
>>
>>
>>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
