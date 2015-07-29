From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 29 Jul 2015 14:15:09 +0200
Subject: [PATCH v2 04/22] of/platform: add of_platform_device_find()
In-Reply-To: <CAAObsKD9BN7dsEiNB=OvJkoOQPwxwnP794w=X4AwtYz3oxEJqw@mail.gmail.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_JsqJGhFXDKuayuKc2E58X5A7ZGN=uYCVDLnXw_t3_auBg+w@mail.gmail.com>
 <CAAObsKBfRLdPc0gs55ARfa+qZJAOEyEgRyTf8krZnQMb6-j03g@mail.gmail.com>
 <CAL_Jsq+RqGAxHE5-ocD-htddBHckG24oZNqfgmMF3Jak6wDXBQ@mail.gmail.com>
 <CAAObsKA+vMsgiC52jReJckeDjXhdd=_NBocFbMapdwFReiY1SQ@mail.gmail.com>
 <CAAObsKD9BN7dsEiNB=OvJkoOQPwxwnP794w=X4AwtYz3oxEJqw@mail.gmail.com>
Message-ID: <CAAObsKD0cpeMQa8mFGGtEaYUGn==o0q-n95+g-Mx17M3_94Qfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 13:20, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 29 July 2015 at 08:14, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> On 28 July 2015 at 17:31, Rob Herring <robherring2@gmail.com> wrote:
>>> On Tue, Jul 28, 2015 at 8:54 AM, Tomeu Vizoso
>>> <tomeu.vizoso@collabora.com> wrote:
>>>> On 28 July 2015 at 15:39, Rob Herring <robherring2@gmail.com> wrote:
>>>>> On Tue, Jul 28, 2015 at 8:19 AM, Tomeu Vizoso
>>>>> <tomeu.vizoso@collabora.com> wrote:
>>>>>> From an arbitrary node in the tree, find the enclosing node that
>>>>>> corresponds to a platform device, as registered by
>>>>>> of_platform_populate().
>>>>>>
>>>>>> This can be used to find out what device needs to be probed so the
>>>>>> dependency described by a given node is made available.
>>>>>>
>>>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Move the logic for finding a platform device from its firmware node to
>>>>>>   of/platform.c as it's not needed for ACPI nodes.
>>>>>>
>>>>>>  drivers/of/platform.c       | 60 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  include/linux/of_platform.h |  1 +
>>>>>>  2 files changed, 61 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>>>> index ff27494cda8c..89c5cd513027 100644
>>>>>> --- a/drivers/of/platform.c
>>>>>> +++ b/drivers/of/platform.c
>>>>>> @@ -501,6 +501,66 @@ void of_platform_depopulate(struct device *parent)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(of_platform_depopulate);
>>>>>>
>>>>>> +static bool of_is_platform(struct device_node *np)
>>>>>> +{
>>>>>> +       int count;
>>>>>> +
>>>>>> +       count = of_property_count_strings(np, "compatible");
>>>>>> +
>>>>>> +       /* The node has to have a compatible string */
>>>>>> +       if (!count)
>>>>>> +               return false;
>>>>>> +
>>>>>> +       /* But it cannot be just a simple memory-mapped bus */
>>>>>> +       if (count == 1 && of_match_node(of_default_bus_match_table, np))
>>>>>> +               return false;
>>>>>> +
>>>>>> +       /* But AMBA devices aren't platform devices */
>>>>>> +       if (of_device_is_compatible(np, "arm,primecell"))
>>>>>> +               return false;
>>>>>> +
>>>>>> +       /* Node is immediately below root */
>>>>>> +       if (!np->parent || !np->parent->parent)
>>>>>> +               return true;
>>>>>> +
>>>>>> +       /* If it's a node in a simple memory-mapped bus */
>>>>>> +       if (of_match_node(of_default_bus_match_table, np->parent))
>>>>>> +               return true;
>>>>>
>>>>> This seems really fragile.
>>>>
>>>> I think this finding logic matches the logic for registering platform
>>>> devices in of_platform_populate and also what is documented in
>>>> Documentation/devicetree/usage-model.txt.
>>>
>>> Right. So now we have that logic in 2 places. One is descending from
>>> the root and one is walking up from the child. That's an opportunity
>>> for some mismatch.
>>
>> Definitely.
>>
>>>>> What about platform devices which are
>>>>> children of MFDs but are not "simple-mfd"?
>>>>
>>>> This code should deal fine with those (the boards I tested with do
>>>> have them). It probes the mfd master, and that in turn will call
>>>> mfd_add_devices causing the target device to be probed.
>>>
>>> I don't see how this function would ever return true in this case
>>> unless you put the MFD at the root level. The only other way to return
>>> true is matching on of_default_bus_match_table for the parent (i.e.
>>> the MFD).
>>
>> Oops, you are right.
>>
>>>>> Does of_find_device_by_node not work for you?
>>>>
>>>> Well, the dependencies aren't always platform devices, that's why I
>>>> need to go up the tree until I find a node that corresponds to a
>>>> platform device that I can query and probe.
>>>>
>>>> If I had a way to get, say, a i2c device from its fwnode then I would
>>>> just need to make sure that a device's parent is probed before probing
>>>> it and everything would be cleaner in the OF case.
>>>
>>> If you have the struct device from the device_node, then you should be
>>> able to do this, right?
>>
>> Yes, if I could go back from the device_node to the struct device that
>> was registered from it, for all buses, then all this would be much
>> simpler and more robust. It would basically work like in the ACPI
>> case.
>>
>> I will play with this idea.
>>
>>>>> That is probably not the
>>>>> most efficient search, but we could fix that. We could add struct
>>>>> device ptr to struct device_node and check without searching for
>>>>> example.
>>>>
>>>> That would be great, but I thought there was an issue with a OF node
>>>> being able to be related to more than one struct device (but I haven't
>>>> found this myself yet).
>>>
>>> I think it pretty much should be one to one. I'm not aware of any
>>> examples where that is not the case. This function would already be
>>> broken if you could have more than one struct device.
>>
>> Well, for platform devices we currently know that there can only be
>> one struct device for a given device_node, but that's not so clear for
>> other devices.
>
> Just found this case:
>
> http://lxr.free-electrons.com/source/drivers/spi/spi-tegra114.c#L1124
>
> Looks like SPI master devices point to the same device_node as the
> platform device that registers them.

And finally found the email that warned me against it:

http://lkml.kernel.org/g/20140514140534.897F8C4153D at trevor.secretlab.ca

Regards,

Tomeu

> Regards,
>
> Tomeu
>
>>> There is an issue where you could have 2 drivers match the same node,
>>> but on different compatible strings. But that's a different issue.
>>
>> Yup.
>>
>> Thanks,
>>
>> Tomeu
>>
>>> Rob
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
