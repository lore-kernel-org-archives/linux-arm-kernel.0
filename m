From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 28 Oct 2016 10:08:59 -0700
Subject: [PATCH v6 4/5] ARM: DTS: da850: Add cfgchip syscon node
In-Reply-To: <09eb61b9-d66e-838e-2411-d787fda65096@ti.com> (Sekhar Nori's
 message of "Fri, 28 Oct 2016 13:51:03 +0530")
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-5-git-send-email-david@lechnology.com>
 <b9bfc4aa-ef52-53c4-dc7e-c0bc1c5969fb@lechnology.com>
 <09eb61b9-d66e-838e-2411-d787fda65096@ti.com>
Message-ID: <m2fungcses.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> On Wednesday 26 October 2016 09:38 PM, David Lechner wrote:
>> On 10/25/2016 10:06 PM, David Lechner wrote:
>>> Add a syscon node for the SoC CFGCHIPn registers. This is needed for
>>> the new usb phy driver.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>  arch/arm/boot/dts/da850.dtsi | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>> index f79e1b9..6bbf20d 100644
>>> --- a/arch/arm/boot/dts/da850.dtsi
>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>> @@ -188,6 +188,10 @@
>>>              };
>>>
>>>          };
>>> +        cfgchip: cfgchip at 1417c {
>> 
>> I wonder if there is a more generic name instead of cfgchip at . Is there a
>> preferred generic name for syscon nodes?
>
> I did not find anything in ePAPR, but chip-controller might be more
> appropriate.
>
>> 
>>> +            compatible = "ti,da830-cfgchip", "syscon";
>
> Looks like we need "simple-mfd" too in the compatible list?
>
> I think we can also fold patch 5/5 into this patch and add the cfgchip
> along with USB phy child node included.
>
> If you respin the patch, I can drop 4/5 and 5/5 that I have queued and
> included the updated patch instead.

Sekhar, what's your opinion of having this syscon just for CFGCHIP* vs 
a single syscon for the whole SYSCFG0 region.

The drivers/bus driver from Bartosz is also using SYSCFG0 registers, and
proposing a sysconf ro this region, but it will need to exclude the
CFGCHIPn registers if we also have this syscon.

I tend to think we should just have one for the whole SYSCFG0 which
this series could use.

Unfortunately, the PHY driver is already merged and it references the
syscon by compatible.  The PHY driver should probably be fixed to find
its syscon by phandle, and then maybe we could move to a single syscon
for SYSCFG0?

Let us know your preference, I don't have a very strong feeling either
way, but since we're already part way down the path of the CFGCHIP
syscon, we should keep it and later migrate it to one for all of
SYSCFG0.

Kevin
