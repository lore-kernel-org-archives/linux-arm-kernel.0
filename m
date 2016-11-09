From: anurupvasu@gmail.com (Anurup M)
Date: Wed, 9 Nov 2016 09:58:38 +0530
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <4657586.c5MJoh65Ux@wuerfel>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <22120038.dbaYpsQoUH@wuerfel> <5821D736.7080803@gmail.com>
 <4657586.c5MJoh65Ux@wuerfel>
Message-ID: <5822A5F6.9040806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 November 2016 08:38 PM, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 7:16:30 PM CET Anurup M wrote:
>>>>>> If these are backwards compatible, just mark them as compatible in DT,
>>>>>> e.g. hip06 can use
>>>>>>
>>>>>>     compatible = "hisilicon,hip06-cpu-djtag-v1", "hisilicon,hip05-cpu-djtag-v1";
>>>>>>
>>>>>> so you can tell the difference if you need to, but the driver only has to
>>>>>> list the oldest one here.
>>>>>>
>>>>>> What is the difference between the cpu and io djtag interfaces?
>>>> On some chips like hip06, the djtag version is different for IO die.
>>> In what way? The driver doesn't seem to care about the difference.
>> There is  a difference in djtag version of CPU and IO die (in some chips).
>> For ex: in hip06 djtag for CPU is v1 and for IO is v2.
>> so they use different readwrite handlers djtag_readwrite_(v1/2).
>>
>> +       /* for hip06(D03) cpu die */
>> +       { .compatible = "hisilicon,hip06-cpu-djtag-v1",
>> +               .data = (void *)djtag_readwrite_v1 },
>> +       /* for hip06(D03) io die */
>> +       { .compatible = "hisilicon,hip06-io-djtag-v2",
>> +               .data = (void *)djtag_readwrite_v2 },
>>
>>
>> For the same djtag version, there is no difference in handling in the
>> driver.
> Right, but my point was about the compatibility with the older chips
> using the same IP block, marking the ones as compatible that actually
> use the same interface.
>
> I also see that the compatible strings have the version included in
> them, and you can probably drop them by requiring them only in the
> fallback:
>
> 	compatible = "hisilicon,hip05-cpu-djtag", "hisilicon,djtag-v1";
> 	compatible = "hisilicon,hip05-io-djtag", "hisilicon,djtag-v1";
> 	compatible = "hisilicon,hip06-cpu-djtag", "hisilicon,djtag-v1";
> 	compatible = "hisilicon,hip06-io-djtag", "hisilicon,djtag-v2";
> 	compatible = "hisilicon,hip07-cpu-djtag", "hisilicon,djtag-v2";
> 	compatible = "hisilicon,hip07-io-djtag", "hisilicon,djtag-v2";
>
> We want to have the first entry be as specific as possible, but
> the last (second) entry is the one that can be used by the driver
> for matching. When a future hip08/hip09/... chip uses an existing
> interface, you then don't have to update the driver.
Thanks. I had a similar thought on this. So as I have the version string 
in the
second entry "-v(1/2)".
I can use it in driver for matching. So i think  I will change it as below.
Please correct me if my understanding is wrong.

  static const struct of_device_id djtag_of_match[] = {
-       /* for hip05(D02) cpu die */
-       { .compatible = "hisilicon,hip05-cpu-djtag-v1",
+       /* for hisi djtag-v1 cpu die */
+       { .compatible = "hisilicon,hisi-cpu-djtag-v1",
                 .data = djtag_readwrite_v1 },
-       /* for hip05(D02) io die */
-       { .compatible = "hisilicon,hip05-io-djtag-v1",
+       /* for hisi djtag-v1 io die */
+       { .compatible = "hisilicon,hisi-io-djtag-v1",
                 .data = djtag_readwrite_v1 },
-       /* for hip06(D03) cpu die */
-       { .compatible = "hisilicon,hip06-cpu-djtag-v1",
-               .data = djtag_readwrite_v1 },
-       /* for hip06(D03) io die */
-       { .compatible = "hisilicon,hip06-io-djtag-v2",
-               .data = djtag_readwrite_v2 },
-       /* for hip07(D05) cpu die */
-       { .compatible = "hisilicon,hip07-cpu-djtag-v2",
+       /* for hisi djtag-v2 cpu die */
+       { .compatible = "hisilicon,hisi-cpu-djtag-v2",
                 .data = djtag_readwrite_v2 },
-       /* for hip07(D05) io die */
-       { .compatible = "hisilicon,hip07-io-djtag-v2",
+       /* for hisi djtag-v2 io die */
+       { .compatible = "hisilicon,hisi-io-djtag-v2",
                 .data = (djtag_readwrite_v2 },
         {},
  };

Thanks,
Anurup
> 	Arnd
