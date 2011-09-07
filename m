From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 7 Sep 2011 12:01:36 +0530
Subject: [PATCH 4/5] ARM: S5P64X0: Fix incorrect serial clock name
In-Reply-To: <000401cc6d23$a044d410$e0ce7c30$%kim@samsung.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
	<1313144787-30666-5-git-send-email-a.kesavan@samsung.com>
	<000401cc6d23$a044d410$e0ce7c30$%kim@samsung.com>
Message-ID: <CAM4voamoMFp8VeRtWUU2KSJZTupV7xJMHSmTHUPKNd4sxieTrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mr Kim,

On Wed, Sep 7, 2011 at 11:31 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Abhilash Kesavan wrote:
>>
>> The S3C6400 serial glue driver(used by S5P64X0) needs the clock name to be
>> pclk or uclk1. Correct the clock name in init.c to pclk and source pclk
>> from pclk_low to get the correct rate.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>> ?arch/arm/mach-s5p64x0/clock-s5p6440.c | ? ?2 +-
>> ?arch/arm/mach-s5p64x0/clock-s5p6450.c | ? ?2 +-
>> ?arch/arm/mach-s5p64x0/init.c ? ? ? ? ?| ? ?2 +-
>> ?3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-
>> s5p64x0/clock-s5p6440.c
>> index 0e9cd30..4b594a4 100644
>> --- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
>> +++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
>> @@ -554,7 +554,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
>>
>> ? ? ? clk_f.rate = fclk;
>> ? ? ? clk_h.rate = hclk;
>> - ? ? clk_p.rate = pclk;
>> + ? ? clk_p.rate = pclk_low;
>
> As you know, HCLK and PCLK are connected to IPs which are included in high
> frequency domain and HCLK_LOW and PCLK_LOW are connected to IPs which are
> included in low frequency domain. I wonder what value is the ARM clock on
> your SMDK64X0? 533MHz or 667MHz?
Mine is at 533MHz
>
> Originally, the "struct clk clk_p" means PCLK not PCLK_LOW. So I think, the
> rate of clk_p should be pclk
OK
>
>>
>> ? ? ? for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
>> ? ? ? ? ? ? ? s3c_set_clksrc(&clksrcs[ptr], true);
>> diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-
>> s5p64x0/clock-s5p6450.c
>> index d9dc16c..eca9a57 100644
>> --- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
>> +++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
>> @@ -613,7 +613,7 @@ void __init_or_cpufreq s5p6450_setup_clocks(void)
>>
>> ? ? ? clk_f.rate = fclk;
>> ? ? ? clk_h.rate = hclk;
>> - ? ? clk_p.rate = pclk;
>> + ? ? clk_p.rate = pclk_low;
>
> Same as above.
>
>>
>> ? ? ? for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
>> ? ? ? ? ? ? ? s3c_set_clksrc(&clksrcs[ptr], true);
>> diff --git a/arch/arm/mach-s5p64x0/init.c b/arch/arm/mach-s5p64x0/init.c
>> index 79833ca..ee25e28 100644
>> --- a/arch/arm/mach-s5p64x0/init.c
>> +++ b/arch/arm/mach-s5p64x0/init.c
>> @@ -25,7 +25,7 @@
>>
>> ?static struct s3c24xx_uart_clksrc s5p64x0_serial_clocks[] = {
>> ? ? ? [0] = {
>> - ? ? ? ? ? ? .name ? ? ? ? ? = "pclk_low",
>> + ? ? ? ? ? ? .name ? ? ? ? ? = "pclk",
>
> According to data sheet, should be pclk_low. Or if required for serial
> driver, uclk1 can be used here.
The serial glue driver does a string comparison with either pclk or uclk*;
You'd rather I add a uclk1 instance ?
Thanks for the review.
>
>> ? ? ? ? ? ? ? .divisor ? ? ? ?= 1,
>> ? ? ? ? ? ? ? .min_baud ? ? ? = 0,
>> ? ? ? ? ? ? ? .max_baud ? ? ? = 0,
>> --
>> 1.7.4.1
>
>
>
> Thanks.
>
> Best regards,
> Kgene.
Abhilash
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
