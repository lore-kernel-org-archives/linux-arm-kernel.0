From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Jul 2015 10:27:31 -0500
Subject: [PATCH v2 04/22] of/platform: add of_platform_device_find()
In-Reply-To: <CAAObsKD9BN7dsEiNB=OvJkoOQPwxwnP794w=X4AwtYz3oxEJqw@mail.gmail.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_JsqJGhFXDKuayuKc2E58X5A7ZGN=uYCVDLnXw_t3_auBg+w@mail.gmail.com>
 <CAAObsKBfRLdPc0gs55ARfa+qZJAOEyEgRyTf8krZnQMb6-j03g@mail.gmail.com>
 <CAL_Jsq+RqGAxHE5-ocD-htddBHckG24oZNqfgmMF3Jak6wDXBQ@mail.gmail.com>
 <CAAObsKA+vMsgiC52jReJckeDjXhdd=_NBocFbMapdwFReiY1SQ@mail.gmail.com>
 <CAAObsKD9BN7dsEiNB=OvJkoOQPwxwnP794w=X4AwtYz3oxEJqw@mail.gmail.com>
Message-ID: <CAL_Jsq+2b4+pf9G1ynWSkDgyC1agmS-TdTVjzdfQKNBWuuOHgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 6:20 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
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

[...]

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

I don't think this is a problem. The device ptr would only point to
the platform device. Nothing else is going to know about the ptr,
modify it nor expect that it points to the same struct device that
contains the of_node ptr.

So I think any instances of struct device like this are ones you don't
care about for purposes of probe dependencies.

Rob
