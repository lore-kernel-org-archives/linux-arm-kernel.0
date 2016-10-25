From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 10:53:12 -0500
Subject: [PATCH/RFT v2 02/17] ARM: davinci: da8xx: Add CFGCHIP syscon
 platform declaration.
In-Reply-To: <758f206c-d0bd-6f70-da1e-42c88d6dd1f0@ti.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-3-ahaslam@baylibre.com>
 <7f9efe9d-0912-e10a-3e45-24c5d2b455ab@ti.com>
 <CAKXjFTOVuWRL+yuk6sARa2PAd6j-V4Ej5AmPGz7F7JXKidvJrg@mail.gmail.com>
 <758f206c-d0bd-6f70-da1e-42c88d6dd1f0@ti.com>
Message-ID: <c3af8517-c452-ae8c-6840-dd8a684e4ab2@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 10/25/2016 05:17 AM, Sekhar Nori wrote:
> On Tuesday 25 October 2016 03:07 PM, Axel Haslam wrote:
>> Hi Sekar,
>>
>> On Tue, Oct 25, 2016 at 10:10 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>>> On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
>>>> From: David Lechner <david@lechnology.com>
>>>>
>>>> The CFGCHIP registers are used by a number of devices, so using a syscon
>>>> device to share them. The first consumer of this will by the phy-da8xx-usb
>>>> driver.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>> [Axel: minor fix: change id to -1]
>>>
>>> Can you please clarify this change? There could be other syscon devices
>>> on the chip for other common registers. Why use the singular device-id?
>>>
>>
>> in the case of non DT boot, the phy driver is looking for "syscon" :
>>
>> d_phy->regmap = syscon_regmap_lookup_by_pdevname("syscon");
>>
>> if we register the syscon driver with id = 0, the actual name of the syscon
>> device will be "syscon.0" and the phy driver will fail to probe, because
>> the strncmp match in the syscon driver (syscon_match_pdevname)
>> will fail.
>>
>> should i change the phy driver instead?
>
> Yes, please. Forcing only one syscon region for the whole chip will be
> too restrictive, I am pretty sure.
>
> Thanks,
> Sekhar
>

In the previous review, you requested that this be changed to -1 [1].

If we change it back to 0, it will also require reverting a patch to the 
phy driver that has already been merged[2].

[1]: http://www.gossamer-threads.com/lists/linux/kernel/2435807?page=last
[2]: http://www.gossamer-threads.com/lists/linux/kernel/2518804
