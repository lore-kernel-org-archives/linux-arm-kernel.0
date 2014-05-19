From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 19 May 2014 08:09:07 +0530
Subject: [PATCH v4 4/4] clk: samsung: exynos5420: Setup clocks before
 system suspend
In-Reply-To: <53752F30.70206@gmail.com>
References: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
 <1399982522-27928-5-git-send-email-a.kesavan@samsung.com>
 <53752F30.70206@gmail.com>
Message-ID: <CAM4voakhmxKqpB9GODSGub-of0Y_rmy5B0QsHBFJEZtE4U3_nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Fri, May 16, 2014 at 2:48 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Abhilash,
>
> On 13.05.2014 14:02, Abhilash Kesavan wrote:
>> Prior to suspending the system, we need to ensure that certain
>> clock source and gate registers are unmasked.
>>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c |   25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index e576456..dd509d1 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -28,6 +28,7 @@
>>  #define GATE_BUS_CPU         0x700
>>  #define GATE_SCLK_CPU                0x800
>>  #define CLKOUT_CMU_CPU               0xa00
>> +#define SRC_MASK_CPERI               0x4300
>>  #define GATE_IP_G2D          0x8800
>>  #define CPLL_LOCK            0x10020
>>  #define DPLL_LOCK            0x10030
>> @@ -66,6 +67,8 @@
>>  #define SRC_TOP10            0x10280
>>  #define SRC_TOP11            0x10284
>>  #define SRC_TOP12            0x10288
>> +#define SRC_MASK_TOP0                0x10300
>> +#define SRC_MASK_TOP1                0x10304
>>  #define SRC_MASK_TOP2                0x10308
>>  #define SRC_MASK_TOP7                0x1031c
>>  #define SRC_MASK_DISP10              0x1032c
>> @@ -73,6 +76,7 @@
>>  #define SRC_MASK_FSYS                0x10340
>>  #define SRC_MASK_PERIC0              0x10350
>>  #define SRC_MASK_PERIC1              0x10354
>> +#define SRC_MASK_ISP         0x10370
>>  #define DIV_TOP0             0x10500
>>  #define DIV_TOP1             0x10504
>>  #define DIV_TOP2             0x10508
>> @@ -91,6 +95,7 @@
>>  #define DIV2_RATIO0          0x10590
>>  #define DIV4_RATIO           0x105a0
>>  #define GATE_BUS_TOP         0x10700
>> +#define GATE_BUS_DISP1               0x10728
>>  #define GATE_BUS_GEN         0x1073c
>>  #define GATE_BUS_FSYS0               0x10740
>>  #define GATE_BUS_FSYS2               0x10748
>> @@ -115,6 +120,7 @@
>>  #define GATE_TOP_SCLK_MAU    0x1083c
>>  #define GATE_TOP_SCLK_FSYS   0x10840
>>  #define GATE_TOP_SCLK_PERIC  0x10850
>> +#define GATE_IP_PERIC                0x10950
>>  #define TOP_SPARE2           0x10b08
>>  #define BPLL_LOCK            0x20010
>>  #define BPLL_CON0            0x20110
>> @@ -222,11 +228,30 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
>>       DIV_KFC0,
>>  };
>>
>> +static const struct samsung_clk_reg_dump exynos5420_set_clksrc[] = {
>> +     { .offset = SRC_MASK_CPERI,             .value = 0xffffffff, },
>> +     { .offset = SRC_MASK_TOP0,              .value = 0x11111111, },
>> +     { .offset = SRC_MASK_TOP1,              .value = 0x11101111, },
>> +     { .offset = SRC_MASK_TOP2,              .value = 0x11111110, },
>> +     { .offset = SRC_MASK_TOP7,              .value = 0x00111100, },
>> +     { .offset = SRC_MASK_DISP10,            .value = 0x11111110, },
>> +     { .offset = SRC_MASK_MAU,               .value = 0x10000000, },
>> +     { .offset = SRC_MASK_FSYS,              .value = 0x11111110, },
>> +     { .offset = SRC_MASK_PERIC0,            .value = 0x11111110, },
>> +     { .offset = SRC_MASK_PERIC1,            .value = 0x11111100, },
>> +     { .offset = SRC_MASK_ISP,               .value = 0x11111000, },
>> +     { .offset = GATE_BUS_DISP1,             .value = 0xffffffff, },
>> +     { .offset = GATE_IP_PERIC,              .value = 0xffffffff, },
>> +};
>> +
>>  static int exynos5420_clk_suspend(void)
>>  {
>>       samsung_clk_save(reg_base, exynos5420_save,
>>                               ARRAY_SIZE(exynos5420_clk_regs));
>>
>> +     samsung_clk_restore(reg_base, exynos5420_set_clksrc,
>> +                             ARRAY_SIZE(exynos5420_set_clksrc));
>> +
>>       return 0;
>>  }
>
> Don't you also need to add those registers to normal suspend/resume
> list, so the values before setting the pre-suspend values are saved on
> suspend and then restored on resume?
Yes, I should do that. Will fix and re-send.

Regards,
Abhilash
>
> Otherwise looks good.
>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
