From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 8 Nov 2016 19:16:30 +0530
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <22120038.dbaYpsQoUH@wuerfel>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <58217871.6050609@huawei.com> <582180F7.5060100@gmail.com>
 <22120038.dbaYpsQoUH@wuerfel>
Message-ID: <5821D736.7080803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 November 2016 05:13 PM, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 1:08:31 PM CET Anurup M wrote:
>   
>> On Tuesday 08 November 2016 12:32 PM, Tan Xiaojun wrote:
>>> On 2016/11/7 21:26, Arnd Bergmann wrote:
>>>> On Wednesday, November 2, 2016 11:42:46 AM CET Anurup M wrote:
>>>>> From: Tan Xiaojun <tanxiaojun@huawei.com>
>>>>> +	/* ensure the djtag operation is done */
>>>>> +	do {
>>>>> +		djtag_read32_relaxed(regs_base, SC_DJTAG_MSTR_START_EN_EX, &rd);
>>>>> +
>>>>> +		if (!(rd & DJTAG_MSTR_START_EN_EX))
>>>>> +			break;
>>>>> +
>>>>> +		udelay(1);
>>>>> +	} while (timeout--);
>>>> This one is obviously not performance critical at all, so use a non-relaxed
>>>> accessor. Same for the other two in this function.
>>>>
>>>> Are these functions ever called from atomic context? If yes, please document
>>>> from what context they can be called, otherwise please consider changing
>>>> the udelay calls into sleeping waits.
>>>>
>>> Yes, this is not reentrant.
>> The read/write functions shall also be called from irq handler (for
>> handling counter overflow).
>> So need to use udelay calls. Shall Document it in v2.
> Ok.
>
>>>>> +static const struct of_device_id djtag_of_match[] = {
>>>>> +	/* for hip05(D02) cpu die */
>>>>> +	{ .compatible = "hisilicon,hip05-cpu-djtag-v1",
>>>>> +		.data = (void *)djtag_readwrite_v1 },
>>>>> +	/* for hip05(D02) io die */
>>>>> +	{ .compatible = "hisilicon,hip05-io-djtag-v1",
>>>>> +		.data = (void *)djtag_readwrite_v1 },
>>>>> +	/* for hip06(D03) cpu die */
>>>>> +	{ .compatible = "hisilicon,hip06-cpu-djtag-v1",
>>>>> +		.data = (void *)djtag_readwrite_v1 },
>>>>> +	/* for hip06(D03) io die */
>>>>> +	{ .compatible = "hisilicon,hip06-io-djtag-v2",
>>>>> +		.data = (void *)djtag_readwrite_v2 },
>>>>> +	/* for hip07(D05) cpu die */
>>>>> +	{ .compatible = "hisilicon,hip07-cpu-djtag-v2",
>>>>> +		.data = (void *)djtag_readwrite_v2 },
>>>>> +	/* for hip07(D05) io die */
>>>>> +	{ .compatible = "hisilicon,hip07-io-djtag-v2",
>>>>> +		.data = (void *)djtag_readwrite_v2 },
>>>>> +	{},
>>>>> +};
>>>> If these are backwards compatible, just mark them as compatible in DT,
>>>> e.g. hip06 can use
>>>>
>>>> 	compatible = "hisilicon,hip06-cpu-djtag-v1", "hisilicon,hip05-cpu-djtag-v1";
>>>>
>>>> so you can tell the difference if you need to, but the driver only has to
>>>> list the oldest one here.
>>>>
>>>> What is the difference between the cpu and io djtag interfaces?
>> On some chips like hip06, the djtag version is different for IO die.
> In what way? The driver doesn't seem to care about the difference.
There is  a difference in djtag version of CPU and IO die (in some chips).
For ex: in hip06 djtag for CPU is v1 and for IO is v2.
so they use different readwrite handlers djtag_readwrite_(v1/2).

+	/* for hip06(D03) cpu die */
+	{ .compatible = "hisilicon,hip06-cpu-djtag-v1",
+		.data = (void *)djtag_readwrite_v1 },
+	/* for hip06(D03) io die */
+	{ .compatible = "hisilicon,hip06-io-djtag-v2",
+		.data = (void *)djtag_readwrite_v2 },


For the same djtag version, there is no difference in handling in the 
driver.

Thanks,
Anurup
> 	Arnd
>
