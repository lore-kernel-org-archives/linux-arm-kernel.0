From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Dec 2010 14:23:36 +0100
Subject: [PATCH 1/4] mach-s5pv210: Add platform definitions for mipi-csis
In-Reply-To: <012301cb92a1$a7020af0$f50620d0$%kim@samsung.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-2-git-send-email-s.nawrocki@samsung.com>
	<012301cb92a1$a7020af0$f50620d0$%kim@samsung.com>
Message-ID: <4CF8EF58.4000007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/03/2010 05:22 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> Added resource definitions for mipi-csis interface, naming
>> changed for consistency with s5pv310 where there are two
>> instances of the device.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-s5pv210/include/mach/irqs.h       |    2 +-
>>  arch/arm/mach-s5pv210/include/mach/map.h        |    4 ++++
>>  arch/arm/mach-s5pv210/include/mach/regs-clock.h |    5 +----
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
>> s5pv210/include/mach/irqs.h
>> index 119b95f..8b5994c 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
>> @@ -65,7 +65,7 @@
>>  #define IRQ_HSMMC0		S5P_IRQ_VIC1(26)
>>  #define IRQ_HSMMC1		S5P_IRQ_VIC1(27)
>>  #define IRQ_HSMMC2		S5P_IRQ_VIC1(28)
>> -#define IRQ_MIPICSI		S5P_IRQ_VIC1(29)
>> +#define IRQ_MIPICSI0		S5P_IRQ_VIC1(29)
> 
> Firstly don't use directly IRQ_MIPICSI0 which is used in platform device.
> Because it can be confused that there would be another MIPICSI such as
> MIPICSI1.
> In that case, just use like following. For example,
> 
> ---
> @@ -132,5 +132,6 @@
>  #define IRQ_LCD_FIFO           IRQ_LCD0
>  #define IRQ_LCD_VSYNC          IRQ_LCD1
>  #define IRQ_LCD_SYSTEM         IRQ_LCD2
> +#define IRQ_MIPI_CSIS0         IRQ_MIPICSI
> 
>  #endif /* ASM_ARCH_IRQS_H */
> ---
> 
> And I'm confused about the name of MIPI-CSI...
> Hmm...used MIPICSI or MIPI_CSI, sometimes MIPICSIS or MIPI_CSIS.

Yes, I agree it still looks a bit messy..
> 
> Maybe the meaning is Camera Serial Interface Slave...
> So...how about to use just one such as "IRQ_MIPI_CSIS" and
> "S5PV210_PA_MIPI_CSIS".
> 
> ---
> @@ -65,7 +65,7 @@
>  #define IRQ_HSMMC0             S5P_IRQ_VIC1(26)
>  #define IRQ_HSMMC1             S5P_IRQ_VIC1(27)
>  #define IRQ_HSMMC2             S5P_IRQ_VIC1(28)
> -#define IRQ_MIPICSI            S5P_IRQ_VIC1(29)
> +#define IRQ_MIPI_CSIS          S5P_IRQ_VIC1(29)
>  #define IRQ_MIPIDSI            S5P_IRQ_VIC1(30)
>  #define IRQ_ONENAND_AUDI       S5P_IRQ_VIC1(31)
> 
> @@ -132,5 +132,6 @@
>  #define IRQ_LCD_FIFO           IRQ_LCD0
>  #define IRQ_LCD_VSYNC          IRQ_LCD1
>  #define IRQ_LCD_SYSTEM         IRQ_LCD2
> +#define IRQ_MIPI_CSIS0         IRQ_MIPI_CSIS

Ok, agreed. I will incorporate that in next patch version.
IRQ_MIPI_CSIS0 for both s5pv210, s5pv310 in dev-csis?.c

> 
>  #endif /* ASM_ARCH_IRQS_H */
> ---
> 
>>  #define IRQ_MIPIDSI		S5P_IRQ_VIC1(30)
>>  #define IRQ_ONENAND_AUDI	S5P_IRQ_VIC1(31)
>>
>> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
>> s5pv210/include/mach/map.h
>> index 861d7fe..8f376f1 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/map.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
>> @@ -107,6 +107,9 @@
>>  #define S5PV210_PA_DMC0		(0xF0000000)
>>  #define S5PV210_PA_DMC1		(0xF1400000)
>>
>> +/* MIPI CSI */
> 
> No need comment.
> 
>> +#define S5PV210_PA_CSIS		0xFA600000
>> +
>>  /* compatibiltiy defines. */
>>  #define S3C_PA_UART		S5PV210_PA_UART
>>  #define S3C_PA_HSMMC0		S5PV210_PA_HSMMC(0)
>> @@ -123,6 +126,7 @@
>>  #define S5P_PA_FIMC0		S5PV210_PA_FIMC0
>>  #define S5P_PA_FIMC1		S5PV210_PA_FIMC1
>>  #define S5P_PA_FIMC2		S5PV210_PA_FIMC2
>> +#define S5P_PA_CSIS0		S5PV210_PA_CSIS
>>
> Same as above.
Ok, I am going to subsitute S5PV210_PA_CSIS with S5PV210_PA_MIPI_CSIS.
> 
>>  #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
>>  #define SAMSUNG_PA_CFCON	S5PV210_PA_CFCON
>> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> b/arch/arm/mach-
>> s5pv210/include/mach/regs-clock.h
>> index ebaabe0..4c45b74 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
>> @@ -161,7 +161,7 @@
>>  #define S5P_MDNIE_SEL		S5P_CLKREG(0x7008)
>>  #define S5P_MIPI_PHY_CON0	S5P_CLKREG(0x7200)
>>  #define S5P_MIPI_PHY_CON1	S5P_CLKREG(0x7204)
>> -#define S5P_MIPI_CONTROL	S5P_CLKREG(0xE814)
>> +#define S5P_MIPI_DPHY_CONTROL	S5P_CLKREG(0xE814)
>>
>>  #define S5P_IDLE_CFG_TL_MASK	(3 << 30)
>>  #define S5P_IDLE_CFG_TM_MASK	(3 << 28)
>> @@ -195,9 +195,6 @@
>>  #define S5P_OTHERS_RET_UART		(1 << 28)
>>  #define S5P_OTHERS_USB_SIG_MASK		(1 << 16)
>>
>> -/* MIPI */
>> -#define S5P_MIPI_DPHY_EN		(3)
>> -
> 
> Great.
> 
>>  /* S5P_DAC_CONTROL */
>>  #define S5P_DAC_ENABLE			(1)
>>  #define S5P_DAC_DISABLE			(0)
>> --

Regards,
Sylwester

-- 
Sylwester Nawrocki
Linux Platform Group
Samsung Poland R&D Center
