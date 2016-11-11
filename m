From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 11 Nov 2016 15:53:45 +0530
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <4812554.ng09YGQfZ9@wuerfel>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <4657586.c5MJoh65Ux@wuerfel> <5822A5F6.9040806@gmail.com>
 <4812554.ng09YGQfZ9@wuerfel>
Message-ID: <58259C31.7030009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 10 November 2016 03:10 AM, Arnd Bergmann wrote:
> On Wednesday, November 9, 2016 9:58:38 AM CET Anurup M wrote:
>>> I also see that the compatible strings have the version included in
>>> them, and you can probably drop them by requiring them only in the
>>> fallback:
>>>
>>>        compatible = "hisilicon,hip05-cpu-djtag", "hisilicon,djtag-v1";
>>>        compatible = "hisilicon,hip05-io-djtag", "hisilicon,djtag-v1";
>>>        compatible = "hisilicon,hip06-cpu-djtag", "hisilicon,djtag-v1";
>>>        compatible = "hisilicon,hip06-io-djtag", "hisilicon,djtag-v2";
>>>        compatible = "hisilicon,hip07-cpu-djtag", "hisilicon,djtag-v2";
>>>        compatible = "hisilicon,hip07-io-djtag", "hisilicon,djtag-v2";
>>>
>>> We want to have the first entry be as specific as possible, but
>>> the last (second) entry is the one that can be used by the driver
>>> for matching. When a future hip08/hip09/... chip uses an existing
>>> interface, you then don't have to update the driver.
>> Thanks. I had a similar thought on this. So as I have the version string
>> in the
>> second entry "-v(1/2)".
>> I can use it in driver for matching. So i think  I will change it as below.
>> Please correct me if my understanding is wrong.
>>
>>    static const struct of_device_id djtag_of_match[] = {
>> -       /* for hip05(D02) cpu die */
>> -       { .compatible = "hisilicon,hip05-cpu-djtag-v1",
>> +       /* for hisi djtag-v1 cpu die */
>> +       { .compatible = "hisilicon,hisi-cpu-djtag-v1",
>>                   .data = djtag_readwrite_v1 },
>> -       /* for hip05(D02) io die */
>> -       { .compatible = "hisilicon,hip05-io-djtag-v1",
>> +       /* for hisi djtag-v1 io die */
>> +       { .compatible = "hisilicon,hisi-io-djtag-v1",
>  From the code it looks like "hisilicon,hisi-io-djtag-v1" and
> "hisilicon,hisi-cpu-djtag-v1" have the same register-level interface,
> so we just need one compatible string for them to match the driver.
>
> 	Arnd
The djtag versions in CPU die and IO die can be different in the same chip.
For example in hip06, the CPU die has djtag-v1 whereas IO die has djtag-v2.
So I think it need two different compatible string

for hip06 chip CPU DIE "hisilicon,hisi-cpu-djtag-v1"
for hip06 chip IO DIE "hisilicon,hisi-io-djtag-v2"

Thanks,
Anurup
