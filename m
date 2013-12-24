From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Tue, 24 Dec 2013 10:11:18 +0000
Subject: [PATCH] ARM: imx: improve the comment of CCM lpm SW workaround
In-Reply-To: <20131224081329.GF3872@S2101-09.ap.freescale.net>
References: <1387908047-1848-1-git-send-email-b20788@freescale.com>
 <20131224081329.GF3872@S2101-09.ap.freescale.net>
Message-ID: <68bb5c5c3b57414ca5893a26eeda4bb5@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn
	Thanks for the detail review, I think it is better to have such info in comments if we already have such hardware errata created, I will sent out V2 soon.

Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Tuesday, December 24, 2013 4:14 PM
>To: Huang Yongcai-B20788
>Cc: kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org; linux-
>kernel at vger.kernel.org
>Subject: Re: [PATCH] ARM: imx: improve the comment of CCM lpm SW workaround
>
>On Tue, Dec 24, 2013 at 01:00:47PM -0500, Anson Huang wrote:
>> Improve the comment of SW workaround for CCM lpm issue using hardware
>> errata description to avoid confusion.
>>
>> TKT194736:
>
>This is not the errata number that will be seen by people publicly.
>That's why I did not give it in the original commit d48866f (ARM: imx:
>ensure dsm_request signal is not asserted when setting LPM).  But if you check
>the log of that commit, you will find we already have the information you're
>adding here.
>
>The good thing is we have that errata publicly available now as below.
>
>ERR007265 CCM: When improper low-power sequence is used, the SoC enters low
>power mode before the ARM core executes WFI
>
>http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf?fpsp=1
>
>So if you want to make it clear, you should quote the errata info that is
>publicly available to people.
>
>Shawn
>
>> Chip will enter low power mode before ARM A9 CPU executes WFI when
>> improper low power sequence is used.
>>
>> SW workaround:
>> 1) SW will trigger irq #32(IOMUX) to be always pending manually by
>> setting IOMUX_GPR1_GINT bit,
>> 2) SW should then Unmask it in GPC before setting CCM LPM
>> 3) SW should Mask it right after CCM LPM is set (set bit0-1 of
>> CCM_CLPCR)
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>>  arch/arm/mach-imx/pm-imx6q.c |   13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/pm-imx6q.c
>> b/arch/arm/mach-imx/pm-imx6q.c index aecd9f8..8da4732 100644
>> --- a/arch/arm/mach-imx/pm-imx6q.c
>> +++ b/arch/arm/mach-imx/pm-imx6q.c
>> @@ -156,10 +156,13 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
>>  	}
>>
>>  	/*
>> -	 * Unmask the always pending IOMUXC interrupt #32 as wakeup source to
>> -	 * deassert dsm_request signal, so that we can ensure dsm_request
>> -	 * is not asserted when we're going to write CLPCR register to set LPM.
>> -	 * After setting up LPM bits, we need to mask this wakeup source.
>> +	 * TKT194736:
>> +	 * Chip will enter low power mode before ARM A9 CPU executes WFI when
>improper low power sequence is used.
>> +	 *
>> +	 * SW workaround:
>> +	 * 1) SW will trigger irq #32(IOMUXC) to be always pending manually by
>setting IOMUX_GPR1_GINT bit,
>> +	 * 2) SW should then Unmask it in GPC before setting CCM LPM
>> +	 * 3) SW should Mask it right after CCM LPM is set (set bit0-1 of
>> +CCM_CLPCR)
>>  	 */
>>  	iomuxc_irq_desc = irq_to_desc(32);
>>  	imx_gpc_irq_unmask(&iomuxc_irq_desc->irq_data);
>> @@ -219,6 +222,8 @@ void __init imx6q_pm_init(void)
>>  	WARN_ON(!ccm_base);
>>
>>  	/*
>> +	 * This is for SW workaround step #1 of TKT194736, see comments
>> +	 * in imx6q_set_lpm for details of this errata.
>>  	 * Force IOMUXC irq pending, so that the interrupt to GPC can be
>>  	 * used to deassert dsm_request signal when the signal gets
>>  	 * asserted unexpectedly.
>> --
>> 1.7.9.5
>>
>>
