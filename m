From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Jan 2018 11:30:26 +0530
Subject: [PATCH] phy: work around 'phys' references to usb-phy devices
In-Reply-To: <87d12guups.fsf@anholt.net>
References: <20180108130116.80148-1-arnd@arndb.de>
 <aa02104b-d80d-8b12-4403-b5cedc23f03a@ti.com>
 <CAK8P3a0F4sK=ou8HXmSktq+0S22juYaCaY48RStDKwk8QGgviQ@mail.gmail.com>
 <6dd37865-9c71-29f9-16b4-26e51e6b1c70@ti.com>
 <CAK8P3a0NSGCR8=MzHAPqyhWMsUWAxJjtstYo8gszKcXUCaupgg@mail.gmail.com>
 <87d12guups.fsf@anholt.net>
Message-ID: <c182bf66-ff80-4e66-99b3-eed305c0b689@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thursday 11 January 2018 11:46 PM, Eric Anholt wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
>> On Thu, Jan 11, 2018 at 2:30 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> On Thursday 11 January 2018 02:27 AM, Arnd Bergmann wrote:
>>>> On Mon, Jan 8, 2018 at 7:32 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>> On Monday 08 January 2018 06:31 PM, Arnd Bergmann wrote:
>>>>>> Stefan Wahren reports a problem with a warning fix that was merged
>>>>>> ---
>>>>>> This obviously needs to be tested, I wrote this up as a reply to
>>>>>> Stefan's bug report. I'm fairly sure that I covered all usb-phy
>>>>>> driver strings here. My goal is to have a fix merged into 4.15
>>>>>> rather than reverting all the DT fixes.
>>>>>
>>>>> Shouldn't the fix be in phy consumer drivers to not return error if it's able
>>>>> to find the phy either using usb-phy or generic phy?
>>>>
>>>> Stefan has posted a patch to that effect now, but I fear that might be
>>>> a little fragile, in particular this short before the release with the
>>>> regression
>>>> in place.
>>>>
>>>> The main problem is that we'd have to change the generic
>>>> usb_add_hcd() function in addition to dwc2 and dwc3 to ignore
>>>> -EPROBE_DEFER from phy_get() whenever usb_get_phy_dev()
>>>> has already succeeded.
>>>>
>>>> If there is any HCD that relies on usb_add_hcd() to get both the
>>>> usb_phy and the phy structures, and it may need to defer probing
>>>> when the latter one isn't ready yet, that fix would break another
>>>> driver.
>>>
>>> hmm.. IMO the better thing right now would be to revert the dt patch which adds
>>> #phy-cells.
>>> We have to see if there are better fixes in order to add #phy-cells warning fix
>>> in stable tree.
>>
>> Let's see which patches that would be, I think this is the full list of
>> nodes that got an extra #phy-cells:
>>
>> c22fe696157d ARM: dts: Fix dm814x missing phy-cells property
>> f0e11ff8ff65 ARM: dts: am33xx: Add missing #phy-cells to ti,am335x-usb-phy
>> c5bbf358b790 arm: dts: nspire: Add missing #phy-cells to usb-nop-xceiv
>> 44e5dced2ef6 arm: dts: marvell: Add missing #phy-cells to usb-nop-xceiv
>> 014d6da6cb25 ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells
>> f568f6f554b8 ARM: dts: omap: Add missing #phy-cells to usb-nop-xceiv
>>
>> plus a couple in linux-next:
>>
>> d745d5f277bf ARM: dts: imx51-zii-rdu1: Add missing #phy-cells to usb-nop-xceiv
>> 915fbe59cbf2 ARM: dts: imx: Add missing #phy-cells to usb-nop-xceiv
>>
>> It's a lot of patches to revert, and I guess it would get us back to hundreds
>> of warnings in an allmodconfig build, so I'd first try to come up with
>> ways to prove that at least some of them can stay.
>>
>> Almost all the warnings are about "usb-nop-xceiv" phys, the only exceptions
>> I could find are the OMAP ones (the first two patches), which use
>> "ti,am335x-usb-phy" and are referenced from a "ti,musb-am33xx". That
>> particular driver is not affected by the bug, so we can leave that in.
>>
>> To deal with all the "usb-nop-xceiv"  references including the one that
>> Stefan reported, we could use a much simpler version of my earlier
>> patch, do you think this is any better?

yeah, this looks simpler.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

In case you want to take this patch yourself
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

(or let me know if I have to create a separate pull request for Greg)

Thanks
Kishon

>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index b4964b067aec..f056d8fb3921 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -410,6 +410,10 @@ static struct phy *_of_phy_get(struct device_node
>> *np, int index)
>>         if (ret)
>>                 return ERR_PTR(-ENODEV);
>>
>> +       /* This phy type handled by the usb-phy subsystem for now */
>> +       if (of_device_is_compatible("usb-nop-xceiv"))
>> +               return ERR_PTR(-ENODEV);
>> +
>>         mutex_lock(&phy_provider_mutex);
>>         phy_provider = of_phy_provider_lookup(args.np);
>>         if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
> 
> This seems like a nice workaround!
> 
