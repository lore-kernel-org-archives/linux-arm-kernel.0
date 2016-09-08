From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 8 Sep 2016 21:53:24 +0100
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <m2eg4ui0nl.fsf@baylibre.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-5-martin.blumenstingl@googlemail.com>
 <m260q6jibf.fsf@baylibre.com>
 <CAFBinCA4Yvw5pbOFmJ8SqyOASADavyEPmHywSdOiUazcqe_Zmg@mail.gmail.com>
 <e3b1f611-d6f6-c98b-a53b-98e94ef5bd96@codethink.co.uk>
 <m2eg4ui0nl.fsf@baylibre.com>
Message-ID: <ffdd0188-72bc-4575-f997-e8547f4c31d2@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 21:42, Kevin Hilman wrote:
> Ben Dooks <ben.dooks@codethink.co.uk> writes:
>
>> On 08/09/16 20:52, Martin Blumenstingl wrote:
>>> On Thu, Sep 8, 2016 at 9:35 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>>>> +     phy = devm_phy_create(&pdev->dev, NULL, &phy_meson_usb2_ops);
>>>>> +     if (IS_ERR(phy)) {
>>>>> +             dev_err(&pdev->dev, "failed to create PHY\n");
>>>>> +             return PTR_ERR(phy);
>>>>> +     }
>>>>> +
>>>>> +     if (usb_reset_refcnt++ == 0) {
>>>>> +             ret = device_reset(&pdev->dev);
>>>>> +             if (ret) {
>>>>> +                     dev_err(&phy->dev, "Failed to reset USB PHY\n");
>>>>> +                     return ret;
>>>>> +             }
>>>>> +     }
>>>>
>>>> The ref count + reset here looks like something that could/should be
>>>> handled in a runtime PM callback.
>>> Unfortunately that doesn't work (as Jerome found out) because both
>>> PHYs are sharing the same reset line.
>>> So if the second PHY would call device_reset then it would also reset
>>> the first PHY!
>>>
>>> There's a comment above the declaration of usb_reset_refcnt which
>>> tries to explain this:
>>> "The PHYs are sharing a common reset line -> we are only allowed to
>>> reset once for all PHYs."
>>> Maybe I should move this comment to the "if (usb_reset_refcnt++ == 0)
>>> {" line to make it easier to see?
>>>
>>
>> pm-runtime has refcounting in it. When one of the nodes turns on,
>> the pm-runtime will call your driver to say there is a user when
>> this first use turns up.
>>
>> If all the sub-phys turn off and drop their refcount then the driver
>> is called to say there are no more users and you can go to sleep.
>
> After a chat w/Martin on IRC, It turns out runtime PM wont help here.
>
> The reason is because there are physically two PHY devices[1].  Those 2
> devices will be treated independely by runtime PM, and have separate
> use-counting, which means doing what I proposed would cause a reset to
> happen when either device was probed.
>
> So, I think it's OK as it is.

Surely you can do pm_runtime_get/put on the phy's parent platform
device and do it that way?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
