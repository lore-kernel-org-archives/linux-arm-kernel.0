From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 18 Jun 2010 19:25:02 +0900
Subject: [PATCH] S5PV210 Correct clock source control register properties
In-Reply-To: <005401cb0ecb$c3f16c00$4bd44400$%kim@samsung.com>
References: <1276766116-6839-1-git-send-email-myungjoo.ham@samsung.com>
	<005401cb0ecb$c3f16c00$4bd44400$%kim@samsung.com>
Message-ID: <AANLkTim1psO4ZeZGAgNteJp_ytRhzoPlu4D3VblPgz6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 6:50 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> The clock source controls (struct clksrc_clk) have been often accessing
>> CLK_GATE_IPx, which are for clock gating and are accessed by each clock
>> as well as the clock source. This duplicated clock issue may incur
>> lockup problems when there are two modules accessing the same clock with
>> different names.
>>
> Could you please explain further about the above the statement " accessed by
> each clock as well as the clock source"

For example, "CLK_GATE_IP2[16:19]" is accessed by "hsmmc" of struct
clk (a clock) and "sclk_mmc" of struct clksrc_clk's struct clk (a
clock source's clk representation).

>
>> Besides, the clock source control is supposed to control (setting values
>> of MASK, SRC, DIV), not to turn on/off individual clock.
>>
> That is not quite true. Only S5PV210/S5PC110 have the gate for the clock mux.
> S5P6440 and S5PC100, for instance, do not have a gate for the output for
> _just_ the clock mux. And the reason why the Clock Mux Gate is provide for
> the mux is explained in Section 3.4 of the user manual.

In cases where clock mux gating is not available and we have each
clock (supplied by this cluck mux) defined separatedly with .enable
and .ctrlbit, we'd better omit .enable/.ctrlbit from struct
clksrc_clk's struct clk.

>
>> Another point is that there are registers (CLK_SRC_MASK0/1) specialized
>> for masking clock source control in S5PV210/S5PC110 according to the
>> user manual (rev 20100201).
>>
>> Therefore, accessing CLK_SRC_MASK0/1 (rather than accessing
>> CLK_GATE_IPx) for the clock source control is safer and fits to the
>> semantics of S5PV210/S5PC110 registers. And fortuneatly, each clock
>> source defined in clock.c has corresponding bit at CLK_SRC_MASK0/1
>> except for MFC, G2D, and G3D.
>>
> Can you please explain how the use CLK_SRC_MASKx makes it safer. The reason
> why MFC, G2D and G3D do not have a corresponding bit in CLK_SRC_MASKx is
> mentioned in Section 3.4 of the user manual.
>
> Let me know your opinion.
>

It's "EXCEPT FOR MFC, G2D, G3D". I'm not saying that using
CLK_SRC_MASKx is safer for these three. For other cases, I guess the
lock up example should be fine.

However, in most cases, this lockup issue does not make visible problem because:
1. normally, drivers use both clksrc_clk's clk and clk at the same
time. for example
"mmc_bus".clk_enable;
"hsmmc".clk_enable;
 blahblah
"hsmmc".clk_disable;
"mmc_bus".clk_disable;
or
2. drivers sharing the same clock uses only one side of the two.
or
3. the execution block between clk_enable and clk_disable is extremely short.

Nevertheless, this potential lockup issue is critical and we'd better
address it.


>> In this patch,
>>
>> - DAC, HDMI, AUDIO 0/1/2, UCLK(uart) 0/1/2/3, MIXER, FIMC 0/1/2,
>> FIMC, MMC 0/1/2/3, CSIS, SPI 0/1, PWI, and PWM clock sources are
>> modified to use CLK_SRC_MASK0/1, which were using CLK_GATE_IPx.
>>
>> - CAM 0/1 did not have enable/disable control. They now access
>> ? CLK_SRC_MASK0.
>>
>> - MFC, G3D, G2D were using CLK_GATE_IPx. However, as there are no clocks
>> ? defined to control MFC, G3D, and G2D, we kept them to access
>> CLK_GATE_IPx. These may need to be modified (erase .enable, .ctrlbit
>> from sclk_mfc, sclk_g2d, sclk_g3d and create clocks: g3d, g2d, mfc)
>> later.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/clock.c | ?101
> ++++++++++++++++++++++-------------------
>> ?1 files changed, 55 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index ec5ad8c..08c1063 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>
> (snip)
>
> Thanks.
>
> Best regards,
> Kgene.
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



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
