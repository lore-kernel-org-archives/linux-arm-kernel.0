From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 9 Nov 2010 20:19:55 +0800
Subject: [PATCH 6/9] ARM: pxa: support pxa95x
In-Reply-To: <AANLkTi=DGe-GEsVAD-xX_gQGzm5sMghJxj4o-N-yM4OJ@mail.gmail.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTi=DGe-GEsVAD-xX_gQGzm5sMghJxj4o-N-yM4OJ@mail.gmail.com>
Message-ID: <AANLkTi=51VOnCwbOfy8VLCJYU+=0vOLYT4qp0dwuiT5C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 1:00 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Mon, Nov 8, 2010 at 8:37 PM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
>> The core of PXA955 is PJ4. Add new PJ4 support. And add new macro
>> CONFIG_PXA95x. Support PXA955 on Marvell Saarb handheld platform.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> ---
>> +config MACH_SAARB
>> + ? ? ? bool "PXA955 Handheld Platform (aka SAARB)"
>> + ? ? ? depends on !(CPU_XSCALE || CPU_XSC3)
>> + ? ? ? select CPU_PXA955
>> +
>
> It would be better to separte the introduction of saarb board support
> into another patch.
>
OK

>> +config CPU_PXA955
>> + ? ? ? bool
>> + ? ? ? select PXA95x
>> ? ? ? ?help
>> - ? ? ? ? PXA950 (codename Tavor-PV2)
>> + ? ? ? ? PXA955 (codename MG1)
>
> Wondering how much difference is the PXA955 from PXA95x.
>
Actually, I prefer to call it MG1 and MGx directly. Since the next
chip will be called PXA96x, but it's the same family of PXA955.

>
> The above changes seem to be moved their positions in the file, and is
> not necessary, could you check again?
>
Sure. I'll check it.

>>
>> ?/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
>> ?* See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
>> diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
>> index 0ff785e..3c9e426 100644
>> --- a/arch/arm/mach-pxa/generic.c
>> +++ b/arch/arm/mach-pxa/generic.c
>> @@ -37,8 +37,10 @@ void clear_reset_status(unsigned int mask)
>> ? ? ? ? ? ? ? ?pxa2xx_clear_reset_status(mask);
>> ? ? ? ?else if (cpu_is_pxa3xx())
>> ? ? ? ? ? ? ? ?pxa3xx_clear_reset_status(mask);
>> - ? ? ? else
>> + ? ? ? else if (cpu_is_pxa93x())
>> ? ? ? ? ? ? ? ?pxa93x_clear_reset_status(mask);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? pxa95x_clear_reset_status(mask);
>> ?}
>
> I think it's better to have 'clear_arsr_reset_status' in generic.c and make
> that common for all pxa3xx/pxa93x/pxa95x instead of introducing the same
> code all around?
>
OK.
>>
>> diff --git a/arch/arm/mach-pxa/pxa93x.c b/arch/arm/mach-pxa/pxa93x.c
>> index b3cc821..a2d51cb 100644
>> --- a/arch/arm/mach-pxa/pxa93x.c
>> +++ b/arch/arm/mach-pxa/pxa93x.c
>> @@ -316,21 +316,21 @@ static struct clk clk_dummy = {
>> ? ? ? ?.ops ? ? ? ? ? ?= &clk_dummy_ops,
>> ?};
>>
>> -static DEFINE_PXA9_CK(pxa93x_lcd, LCD, &clk_pxa93x_hsio_ops);
>> -static DEFINE_PXA9_CK(pxa93x_camera, CAMERA, &clk_pxa93x_hsio_ops);
>> -static DEFINE_PXA9_CKEN(pxa93x_ffuart, FFUART, 14857000, 1);
>> -static DEFINE_PXA9_CKEN(pxa93x_btuart, BTUART, 14857000, 1);
>> -static DEFINE_PXA9_CKEN(pxa93x_stuart, STUART, 14857000, 1);
>> -static DEFINE_PXA9_CKEN(pxa93x_i2c, I2C, 32842000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_keypad, KEYPAD, 32768, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_ssp1, SSP1, 13000000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_ssp2, SSP2, 13000000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_ssp3, SSP3, 13000000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_ssp4, SSP4, 13000000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_pwm0, PWM0, 13000000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_pwm1, PWM1, 13000000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_mmc1, MMC1, 19500000, 0);
>> -static DEFINE_PXA9_CKEN(pxa93x_mmc2, MMC2, 19500000, 0);
>> +static DEFINE_PXA93_CK(pxa93x_lcd, LCD, &clk_pxa93x_hsio_ops);
>> +static DEFINE_PXA93_CK(pxa93x_camera, CAMERA, &clk_pxa93x_hsio_ops);
>> +static DEFINE_PXA93_CKEN(pxa93x_ffuart, FFUART, 14857000, 1);
>> +static DEFINE_PXA93_CKEN(pxa93x_btuart, BTUART, 14857000, 1);
>> +static DEFINE_PXA93_CKEN(pxa93x_stuart, STUART, 14857000, 1);
>> +static DEFINE_PXA93_CKEN(pxa93x_i2c, I2C, 32842000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_keypad, KEYPAD, 32768, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_ssp1, SSP1, 13000000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_ssp2, SSP2, 13000000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_ssp3, SSP3, 13000000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_ssp4, SSP4, 13000000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_pwm0, PWM0, 13000000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_pwm1, PWM1, 13000000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_mmc1, MMC1, 19500000, 0);
>> +static DEFINE_PXA93_CKEN(pxa93x_mmc2, MMC2, 19500000, 0);
>
> Maybe this change could be done in earlier pxa93x separation from pxa3xx patch?
>
OK.
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index a0a2928..674aba5 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -382,6 +382,13 @@ config CPU_FEROCEON_OLD_ID
>> ? ? ? ? ?for which the CPU ID is equal to the ARM926 ID.
>> ? ? ? ? ?Relevant for Feroceon-1850 and early Feroceon-2850.
>>
>> +# Marvell PJ4
>> +config CPU_PJ4
>> + ? ? ? bool
>> + ? ? ? select CPU_V7
>> + ? ? ? select CPU_32v6K
>> + ? ? ? select ARM_THUMBEE
>
> I doubt we need to introduce CONFIG_CPU_PJ4 at this stage, as it's fully
> compatible so far with ARMv7. CPU_32v6K will be selected by CPU_V7 except
> for OMAP2, and ARM_THUMBEE depends on CPU_V7 and is optional (selectable).
>
We still need CPU_PJ4 because of dependancy of iwmmx and tauros cache.
PXA955 need both iwmmx and tauros cache.
