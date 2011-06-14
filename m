From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 14 Jun 2011 14:07:53 +0800
Subject: [PATCH v4 2/5] mmc: support sdhci-pxav2.c
In-Reply-To: <0059AEB1-3536-4540-924A-A95C7F3AD21A@marvell.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
	<1307526121-12059-3-git-send-email-zhangfei.gao@marvell.com>
	<0059AEB1-3536-4540-924A-A95C7F3AD21A@marvell.com>
Message-ID: <BANLkTimeb-Ax99rQDYckLsVSncxhrh7amg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
>> +{
>> + ? ? struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
>> + ? ? struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>> +
>> + ? ? if (mask == SDHCI_RESET_ALL) {
>> + ? ? ? ? ? ? u16 tmp = 0;
>> +
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* tune timing of read data/command when crc error happen
>> + ? ? ? ? ? ? ?* no performance impact
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? if (pdata->clk_delay_sel == 1) {
>> + ? ? ? ? ? ? ? ? ? ? tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>> +
>> + ? ? ? ? ? ? ? ? ? ? tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? << SDCLK_DELAY_SHIFT;
>> + ? ? ? ? ? ? ? ? ? ? tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? tmp |= (1 & SDCLK_SEL_MASK) << SDCLK_SEL_SHIFT;
>> +
>> + ? ? ? ? ? ? ? ? ? ? writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>> + ? ? ? ? ? ? }
>
> There are 3 possible value for clk_delay_sel.
>
> 0 ?== do not use clk_delay_cycles
> 1 == use programmed clk_delay_cycles value (the code above)
> all other values use the sd_clk which was used to drive the output
>
> The code about only handles 2 of the 3 cases

pxa910/920 only require two cases.
1, clk_delay_sel = 1 with delay value.
2, use default setting and directly use sd_clk. clk_delay_sel = 3.

>
> suggest
>
> ? ? ? ?(if (pdata->clk_delay_sel) {
>> + ? ? ? ? ? ? if (pdata->clk_delay_sel == 1) {
>> + ? ? ? ? ? ? ? ? ? ? tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>> +
>> + ? ? ? ? ? ? ? ? ? ? tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? << SDCLK_DELAY_SHIFT;
>> + ? ? ? ? ? ? ? ? ? ? tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? tmp |= 1 << SDCLK_SEL_SHIFT;
>> +
>> + ? ? ? ? ? ? ? ? ? ? writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>> + ? ? ? ? ? ? } else {
>
>> + ? ? ? ? ? ? ? ? ? ? tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>> + ? ? ? ? ? ? ? ? ? ? tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? tmp |= 2 ?<< SDCLK_SEL_SHIFT;
>> + ? ? ? ? ? ? ? ? ? ? writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
The else is default setting on pxa910 after reset.
> ? ? ? ? ? ? ? ? ? }
> ? ? ? ? }
>
> Philip and Mark
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
