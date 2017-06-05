From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 5 Jun 2017 11:53:56 +0530
Subject: [PATCH v4 1/6] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <2668868.v3IoKk0Lz9@debian64>
References: <1496474875-7190-1-git-send-email-varada@codeaurora.org>
 <1496474875-7190-2-git-send-email-varada@codeaurora.org>
 <2668868.v3IoKk0Lz9@debian64>
Message-ID: <35ae1e44-1397-db2c-cbfc-6b72136bb230@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 6/4/2017 12:25 AM, Christian Lamparter wrote:
> On Saturday, June 3, 2017 12:57:50 PM CEST Varadarajan Narayanan wrote:
>> Add initial pinctrl driver to support pin configuration with
>> pinctrl framework for ipq8074.
>>
>> Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
>> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
>> ---
>> +- bias-disable:
>> +	Usage: optional
>> +	Value type: <none>
>> +	Definition: The specified pins should be configued as no pull.
>> +
>> +- bias-pull-down:
>> +	Usage: optional
>> +	Value type: <none>
>> +	Definition: The specified pins should be configued as pull down.
>> +
>> +- bias-pull-up:
>> +	Usage: optional
>> +	Value type: <none>
>> +	Definition: The specified pins should be configued as pull up.
>> +
>> +#define REG_SIZE 0x1000
>> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
>> +	{					        \
>> +		.name = "gpio" #id,			\
>> +		.pins = gpio##id##_pins,		\
>> +		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\
>> +		.funcs = (int[]){			\
>> +			msm_mux_gpio, /* gpio mode */	\
>> +			msm_mux_##f1,			\
>> +			msm_mux_##f2,			\
>> +			msm_mux_##f3,			\
>> +			msm_mux_##f4,			\
>> +			msm_mux_##f5,			\
>> +			msm_mux_##f6,			\
>> +			msm_mux_##f7,			\
>> +			msm_mux_##f8,			\
>> +			msm_mux_##f9			\
>> +		},				        \
>> +		.nfuncs = 10,				\
>> +		.ctl_reg = REG_SIZE * id,		\
>> +		.io_reg = 0x4 + REG_SIZE * id,		\
>> +		.intr_cfg_reg = 0x8 + REG_SIZE * id,		\
>> +		.intr_status_reg = 0xc + REG_SIZE * id,	\
>> +		.intr_target_reg = 0x8 + REG_SIZE * id,	\
>> +		.mux_bit = 2,			\
>> +		.pull_bit = 0,			\
>> +		.drv_bit = 6,			\
>> +		.oe_bit = 9,			\
>> +		.in_bit = 0,			\
>> +		.out_bit = 1,			\
>> +		.intr_enable_bit = 0,		\
>> +		.intr_status_bit = 0,		\
>> +		.intr_target_bit = 5,		\
>> +		.intr_raw_status_bit = 4,	\
>> +		.intr_polarity_bit = 1,		\
>> +		.intr_detection_bit = 2,	\
>> +		.intr_detection_width = 2,	\
>> +	}
>> +
> Hello,
> 
> Back in May, Ram Chandra Jangir posted a rather interesting patch on
> the LEDE Mailing-List:
> <https://www.mail-archive.com/lede-dev@lists.infradead.org/msg07691.html>
> |GPIO_PULL bits configurations in TLMM_GPIO_CFG register
> |differs for IPQ40xx from rest of the other qcom SoC's.
> |This change add support to configure the msm_gpio_pull
> |bits for ipq40xx, It is required to fix the proper
> |configurations of gpio-pull bits for nand pins mux.
> |
> |IPQ40xx SoC:
> |2'b10: Internal pull up enable.
> |2'b11: Unsupport
> |
> |For other SoC's:
> |2'b10: Keeper
> |2'b11: Pull-Up
> 
> This information wasn't mentioned anywhere. In fact, the special pull-up
> configuration was only discovered due to an issue with the qpic NAND on
> the Cisco Meraki MR33. So I wonder what does the gpio-pull look like for
> the IPQ8074? Is it the same as the IPQ40XX or does it follow the older 
> SoCs?
> 
> I'm asking this because I'm preparing a modified version of this patch
> that will be posted once the IPQ8074 is ready.
> 

IPQ8074 pull configuration bits are same as the older Socs. So IPQ40XX looks to
be the only exception. Having said that, the patch that you pointed out should
be posted on the lists for the kernel then.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
