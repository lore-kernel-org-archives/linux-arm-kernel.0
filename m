From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 08 Oct 2010 15:00:47 +0200
Subject: [PATCH v2] i.MX35: use the correct IIM register to get
	CPU	revision
In-Reply-To: <20101008123102.GH29673@pengutronix.de>
References: <1286524957-30218-1-git-send-email-eric@eukrea.com>
	<1286525909-30956-1-git-send-email-eric@eukrea.com>
	<20101008123102.GH29673@pengutronix.de>
Message-ID: <4CAF15FF.6040404@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 08/10/2010 14:31, Uwe Kleine-K?nig a ?crit :
>> diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
>> index 85884c7..f7cec59 100644
>> --- a/arch/arm/mach-mx3/clock-imx35.c
>> +++ b/arch/arm/mach-mx3/clock-imx35.c
>> @@ -535,6 +535,7 @@ int __init mx35_clocks_init()
>>   	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
>>   	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
>>
>> +	clk_enable(&iim_clk);
>>   	mx35_read_cpu_rev();
>
> Do you let the clock running on purpose?
>
same as on i.MX31 : the iim clock is kept on.

>>   	mxc_timer_init(&gpt_clk,
>> diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
>> index db7af50..d00a754 100644
>> --- a/arch/arm/mach-mx3/cpu.c
>> +++ b/arch/arm/mach-mx3/cpu.c
>> @@ -59,31 +59,26 @@ void __init mx31_read_cpu_rev(void)
>>   unsigned int mx35_cpu_rev;
>>   EXPORT_SYMBOL(mx35_cpu_rev);
>>
>> -#define MX35_ROM_SI_REV		0x40
>> -
>>   void __init mx35_read_cpu_rev(void)
>>   {
>> -	void __iomem *rom = ioremap(MX35_IROM_BASE_ADDR, MX35_IROM_SIZE);
>>   	u32 rev;
>>   	char *srev = "unknown";
>>
>> -	if (!rom)
>> -		return;
>> -
>> -	rev = readl(rom + MX35_ROM_SI_REV);
>> +	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
>>   	switch (rev) {
>> -	case 0x1:
>> -		mx35_cpu_rev = MX35_CHIP_REV_1_0;
>> +	case 0x00:
>> +		mx35_cpu_rev = MX3x_CHIP_REV_1_0;
>>   		srev = "1.0";
>>   		break;
>> -	case 0x2:
>> -		mx35_cpu_rev = MX35_CHIP_REV_2_0;
>> +	case 0x10:
>> +		mx35_cpu_rev = MX3x_CHIP_REV_2_0;
>>   		srev = "2.0";
>>   		break;
>> +	case 0x11:
>> +		mx35_cpu_rev = MX3x_CHIP_REV_2_1;
>> +		srev = "2.1";
>> +		break;
> Would it make sense here to do:
>
> 	mx35_cpu_rev = 0x10 + rev;
>
> ?
>
we don't know how future chip will be numbered !

Eric
