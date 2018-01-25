From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 25 Jan 2018 18:23:23 +0530
Subject: =?UTF-8?Q?Re:_[PATCH_v6_00/41]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
In-Reply-To: <CAMRc=Me1_i8qQE4GHeLiU2itHnp71Gt03UM6NhL=hA8Y6Pb0MA@mail.gmail.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <CAMRc=MexJTMiD=URw1bv-qfGaTntZRXgfsSb_beYGkvO+LrpgQ@mail.gmail.com>
 <d819e18f-7d74-d8c4-8056-bfc545f4d4e9@lechnology.com>
 <CAMRc=McVNJqsO4+j=XkyNWuKqF-S-hQAw9XxHx6GC47UudgMYw@mail.gmail.com>
 <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
 <615bc302-e129-1501-63be-fa701f5ecaad@lechnology.com>
 <CAHCN7xLW=RjHHBjvDto=DRrNfNsQrsaGb0zmsRrwdc+7Wbhaxg@mail.gmail.com>
 <CAMRc=MdyGx3PFiryYybB2fCGx=AP=e7kkdd-DUL29pT+St9u1g@mail.gmail.com>
 <5f836454-5de7-c51d-d262-2c2dbc26e438@lechnology.com>
 <CAMRc=Mcw8wWNo7Q3KnHNv81UGuHxEqmOs0he7MKxmaxDjwao+A@mail.gmail.com>
 <aaeb7d73-bd3b-9c85-88c5-c60da6ca3733@lechnology.com>
 <CAMRc=Me8HefZJYTkprqL2vpq_nLym4r6p-du7hoKwVk8kSCR8w@mail.gmail.com>
 <cafb3712-08eb-18f7-b3b6-debba2298b49@lechnology.com>
 <f28601f6-d6f1-9a55-f3cf-62543412bd36@lechnology.com>
 <fc54ab26-72be-1377-2ccb-72d34360c5eb@lechnology.com>
 <CAMRc=Me1_i8qQE4GHeLiU2itHnp71Gt03UM6NhL=hA8Y6Pb0MA@mail.gmail.com>
Message-ID: <597caa1a-a790-3629-3186-5d2152f45e06@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 January 2018 01:33 PM, Bartosz Golaszewski wrote:
> 2018-01-23 21:23 GMT+01:00 David Lechner <david@lechnology.com>:
>> On 01/23/2018 02:05 PM, David Lechner wrote:
>>>
>>> On 01/23/2018 02:01 PM, David Lechner wrote:
>>>>
>>>> On 01/23/2018 01:53 PM, Bartosz Golaszewski wrote:
>>>>>
>>>>>
>>>>> In the mdio case - the problem is that devm_clk_get() doesn't fail,
>>>>> but somehow the clock doesn't end up in the list of the device's
>>>>> clocks - which is why it's not enabled by pm_runtime_get_sync().
>>>>>
>>>>
>>>>
>>>> Right. This is because devm_clk_get() now finds the clock via device
>>>> tree instead of a clkdev lookup entry. However, I think that the PM
>>>> notifier registered in arch/arm/mach-davinci/pm_domain.c only uses
>>>> the clkdev lookup to match the con_id and does not use device tree.
>>>> The same thing is happing in mdio, emac and lcdc.
>>>>
>>>
>>> Minor correction: It looks like emac doesn't do this because it doesn't
>>> have a con_id of "fck". But, the same clock is shared by emac and mdio, so
>>> since mdio enables the clock, emac doesn't notice or care that it did
>>> not enable the clock itself.
>>
>>
>> How about using pm_clk_add_clk() in these drivers to explicitly use the
>> clocks for power management instead of relying on pm_clk_add_notifier()
>> to do this implicitly?
> 
> Yes, this sounds good.

Looking at how pm_clk_notify() in clock_ops.c uses con_id[] list, right 
now pm_runtime() will work only for clocks which have con_id (from the 
list above) mentioned in DT. Since clk_find() mandates con_id match when 
its available, NULL con_id does not match.

For simple devices like DaVinci which uses just one clock for power 
management per device (multiple devices might share a clock, but not 
other way around as far as I recall, anyway I will double check this 
assertion), the attached patch should make EMAC work.

That still leaves why lcdc does not work. One difference is it uses 
PSC1. Are there other devices in PSC1 which work (just to rule out any 
thing wrong with PSC1 handling).

Thanks,
Sekhar

---8<---
diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index 78eac2c0c146..0dce7397856d 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -23,7 +23,6 @@ static struct dev_pm_domain davinci_pm_domain = {
 
 static struct pm_clk_notifier_block platform_bus_notifier = {
 	.pm_domain = &davinci_pm_domain,
-	.con_ids = { "fck", "master", "slave", NULL },
 };
 
 static int __init davinci_pm_runtime_init(void)


  
