From: ahaslam@baylibre.com (Axel Haslam)
Date: Wed, 26 Oct 2016 22:05:32 +0200
Subject: [PATCH] ARM: davinci: register the usb20_phy clock on the DT file
In-Reply-To: <48fa5315-74db-cf33-1f34-86764f0e2c1c@lechnology.com>
References: <20161026194916.14546-1-ahaslam@baylibre.com>
 <f2aeafb1-38f4-9b1e-c3fd-a2984333d00f@lechnology.com>
 <48fa5315-74db-cf33-1f34-86764f0e2c1c@lechnology.com>
Message-ID: <CAKXjFTNyNEykVn3+mxiaQionxuzrp812nfdD=9uNgrbddv939Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 10:03 PM, David Lechner <david@lechnology.com> wrote:
> On 10/26/2016 03:01 PM, David Lechner wrote:
>>
>> On 10/26/2016 02:49 PM, ahaslam at baylibre.com wrote:
>>>
>>> From: Axel Haslam <ahaslam@baylibre.com>
>>>
>>> The usb20_phy clock needs to be registered for the driver to be able
>>> to get and enable a clock. Currently the usb phy clocks are registered
>>> form board files, which will not be called during a device tree based
>>> boot.
>>>
>>> To be able to probe correctly usb form a device tree boot, register
>>> the usb phy clocks form the DT specific init.
>>>
>>> Unfourtunatly, davinci does not have proper clock support on device tree
>>> yet, so by registering the clock form de DT specific file we are
>>> forced to hardcode the parent clock, and cannot select refclkin as
>>> parent for any of the phy clocks of the da850 family.
>>>
>>> As none of the current da850 based boards currently in mainline use
>>> refclkin as source. I guess we can live with this limitation until clocks
>>> are correctly represented through CCF/device tree.
>>>
>>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>>> ---
>>>
>>> This patch depends on David's series for usb clocks:
>>>
>>> currently:
>>> [PATCH v6 0/5] da8xx USB PHY platform devices and clocks
>>> https://lkml.org/lkml/2016/10/25/867
>>>
>>>  arch/arm/mach-davinci/da8xx-dt.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-davinci/da8xx-dt.c
>>> b/arch/arm/mach-davinci/da8xx-dt.c
>>> index c9f7e92..7947267 100644
>>> --- a/arch/arm/mach-davinci/da8xx-dt.c
>>> +++ b/arch/arm/mach-davinci/da8xx-dt.c
>>> @@ -45,6 +45,8 @@
>>>
>>>  static void __init da850_init_machine(void)
>>>  {
>>> +    da8xx_register_usb20_phy_clk(false);
>>> +    da8xx_register_usb11_phy_clk(false);
>>>      of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
>>>  }
>>>
>>>
>>
>>
>> You should check for error on return and print a warning if there is an
>> error. Like this: https://patchwork.kernel.org/patch/9395635/
>>
>> (I actually just had to make this change a few minutes ago to
>> troubleshoot a problem that I am working on.
>> da8xx_register_usb11_phy_clk() is failing for some reason that I have
>> not figured out yet.)
>
>
>
> And actually, since my patch that provides these functions has not been
> accepted yet, why don't I just add this change to that series?

Ok, sure, if you are planing on sending another version.

Regards
Axel
