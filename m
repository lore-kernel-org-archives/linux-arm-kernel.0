From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 17 May 2018 10:03:41 +0000
Subject: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
In-Reply-To: <20180516203240.GB24496@piout.net>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
 <20180516203240.GB24496@piout.net>
Message-ID: <18a9abfc-a67c-509e-7f9b-af666ada52ae@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 10:32 PM, Alexandre Belloni wrote:
> On 09/05/2018 17:46:10+0200, Amelie Delaunay wrote:
>>   struct stm32_rtc_registers {
>> @@ -86,6 +98,9 @@ struct stm32_rtc_registers {
>>   	u8 prer;
>>   	u8 alrmar;
>>   	u8 wpr;
>> +	u8 sr;
>> +	u8 scr;
>> +	u16 verr;
> 
> All those offsets should probably be u16 or u32...
>

OK, those offsets will be all u16 in v3, the maximum STM32 RTC register 
offset value being 0x3FC.

>> +	if (regs.verr != UNDEF_REG) {
> 
> ...else, this is not working, as reported by kbuild
> 

Yes, in v3, UNDEF_REG will be the maximum u16 value (0xFFFF) instead of ~0.

>> +		u32 ver = readl_relaxed(rtc->base + regs.verr);
>> +
>> +		dev_info(&pdev->dev, "registered rev:%d.%d\n",
>> +			 (ver >> STM32_RTC_VERR_MAJREV_SHIFT) & 0xF,
>> +			 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
>> +	}
>> +
> 

Thanks,
Amelie
