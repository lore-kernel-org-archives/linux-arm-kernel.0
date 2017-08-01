From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 1 Aug 2017 10:49:36 -0500
Subject: [PATCH v3 1/2] gpio: davinci: Add keystone-k2g compatible
In-Reply-To: <20799238-a72b-c6e7-5898-3de23f91a9ed@ti.com>
References: <1501051524-5990-1-git-send-email-j-keerthy@ti.com>
 <5aa0d273-8e05-a5ff-7931-b9a94acade36@ti.com>
 <8021c424-460c-def4-3a67-ed760997193d@ti.com>
 <2eeaeea5-9476-8631-8680-7db3322151bf@ti.com>
 <da92fe60-d70b-6a37-6b88-2ac95dd67b6a@ti.com>
 <90337754-8670-6df7-5421-7100e31755b1@ti.com>
 <65ab0098-ef1b-3bec-1d2a-768e478fa413@ti.com>
 <20799238-a72b-c6e7-5898-3de23f91a9ed@ti.com>
Message-ID: <779826e7-0c48-d24f-c3ad-76039f7fdf7e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2017 09:30 AM, Suman Anna wrote:
> On 08/01/2017 01:12 AM, Vignesh R wrote:
>>
>>
>> On Monday 31 July 2017 07:14 PM, Keerthy wrote:
>>>
>>>
>>> On Wednesday 26 July 2017 07:50 PM, Suman Anna wrote:
>>>> On 07/26/2017 08:36 AM, Keerthy wrote:
>>>>>
>>>>> On Wednesday 26 July 2017 06:57 PM, Franklin S Cooper Jr wrote:
>>>>>>
>>>>>>
>>>>>> On 07/26/2017 08:00 AM, Suman Anna wrote:
>>>>>>> Hi Keerthy,
>>>>>>>
>>>>>>> On 07/26/2017 01:45 AM, Keerthy wrote:
>>>>>>>> The patch adds keystone-k2g compatible, specific properties and
>>>>>>>> an example.
>>>>>>
>> [...]
>>>>>>>
>>>>>>
>>>>>> What about power-domain property?
>>>>
>>>> The correct name is "power-domains".
>>>>
>>>>> Driver has no pm_runtime implemented yet.
>>>>
>>>> True, not yet, but this is in general a required property on K2G SoCs to
>>>> automatically enable clocks through runtime_pm. Clock properties on K2G
>>>> nodes should only be truly required if a driver is using clk API
>>>> (ideally to control optional clocks or for adjusting clock frequencies).
>>>> When the gpio-davinci driver gets updated to use pm_runtime, the clock
>>>> properties will be rendered obsolete for K2G.
>>>>
>>>> Rob,
>>>> Any suggestions on how we need to handle this? Should we be adding the
>>>> property now or later when we adapt the driver for runtime_pm? This
>>>> would be a common theme for K2G nodes that are reusing Davinci drivers.
>>>>
>>>> My take on this would be to add the property now, and mark the clock
>>>> properties obsolete when the driver gets converted.
>>>
>>
>> I don't think SoC wide properties are put into device specific binding
>> documentation, for example pinctrl bindings are not put into device
>> documentation.
> 
> I wouldn't compare this to pinctrl bindings exactly but more similar to
> clocks or the ti,hwmods on OMAP/AM platforms. I see lot of other
> bindings documenting the power-domains property just as well.

The issue is that 66AK2G utilizes drivers from both Keystone/Davinci and
OMAP SoC architectures that handles clock and pm in different ways. So
for various reasons some drivers just need the power-domain property
which is new and unique to 66AK2G and other drivers just need the clocks
property while others may also need the clock-names property. This lack
of consistency makes properly documenting things important. Also 66AK2G
will never used hwmod property so avoiding that confusion will also be
helpful if the current bindings document does include references to hwmod.

> 
> regards
> Suman
> 
>>
>>> Rob,
>>>
>>> Any comments on this?
>>>
>>
>> [...]
>>
> 
