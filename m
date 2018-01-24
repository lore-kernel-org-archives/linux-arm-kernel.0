From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 09:03:45 +0100
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00=2F41=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <fc54ab26-72be-1377-2ccb-72d34360c5eb@lechnology.com>
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
Message-ID: <CAMRc=Me1_i8qQE4GHeLiU2itHnp71Gt03UM6NhL=hA8Y6Pb0MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-23 21:23 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/23/2018 02:05 PM, David Lechner wrote:
>>
>> On 01/23/2018 02:01 PM, David Lechner wrote:
>>>
>>> On 01/23/2018 01:53 PM, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> In the mdio case - the problem is that devm_clk_get() doesn't fail,
>>>> but somehow the clock doesn't end up in the list of the device's
>>>> clocks - which is why it's not enabled by pm_runtime_get_sync().
>>>>
>>>
>>>
>>> Right. This is because devm_clk_get() now finds the clock via device
>>> tree instead of a clkdev lookup entry. However, I think that the PM
>>> notifier registered in arch/arm/mach-davinci/pm_domain.c only uses
>>> the clkdev lookup to match the con_id and does not use device tree.
>>> The same thing is happing in mdio, emac and lcdc.
>>>
>>
>> Minor correction: It looks like emac doesn't do this because it doesn't
>> have a con_id of "fck". But, the same clock is shared by emac and mdio, so
>> since mdio enables the clock, emac doesn't notice or care that it did
>> not enable the clock itself.
>
>
> How about using pm_clk_add_clk() in these drivers to explicitly use the
> clocks for power management instead of relying on pm_clk_add_notifier()
> to do this implicitly?

Yes, this sounds good.

Bartosz
