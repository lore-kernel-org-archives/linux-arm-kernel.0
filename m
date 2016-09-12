From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 12 Sep 2016 10:32:44 -0700
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <CAFBinCDnMd0rtrvTMX-D_WNXHpVD8F=8Xn35jcK5jTUCre9ebA@mail.gmail.com>
 (Martin Blumenstingl's message of "Sun, 11 Sep 2016 15:44:03 +0200")
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-5-martin.blumenstingl@googlemail.com>
 <m260q6jibf.fsf@baylibre.com>
 <CAFBinCA4Yvw5pbOFmJ8SqyOASADavyEPmHywSdOiUazcqe_Zmg@mail.gmail.com>
 <e3b1f611-d6f6-c98b-a53b-98e94ef5bd96@codethink.co.uk>
 <m2eg4ui0nl.fsf@baylibre.com>
 <ffdd0188-72bc-4575-f997-e8547f4c31d2@codethink.co.uk>
 <CAFBinCC4gkMrJtertYevg_hXDLJEZ0PqfKKLL5UKXo8B=SXsPw@mail.gmail.com>
 <m2sht9gkau.fsf@baylibre.com>
 <CAFBinCDohOoFP_3GC+=tt6S7sPS308ao-yf+oGhdfwo-N-JnAA@mail.gmail.com>
 <CAFBinCDnMd0rtrvTMX-D_WNXHpVD8F=8Xn35jcK5jTUCre9ebA@mail.gmail.com>
Message-ID: <7hpoo9qb0j.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Fri, Sep 9, 2016 at 10:36 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> On Fri, Sep 9, 2016 at 5:33 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>>
>>>> On Thu, Sep 8, 2016 at 10:53 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>>> On 08/09/16 21:42, Kevin Hilman wrote:
>>>>>>
>>>>>> Ben Dooks <ben.dooks@codethink.co.uk> writes:
>>>>>>
>>>>>>> On 08/09/16 20:52, Martin Blumenstingl wrote:
>>>>>>>>
>>>>>>>> On Thu, Sep 8, 2016 at 9:35 PM, Kevin Hilman <khilman@baylibre.com>
>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> +     phy = devm_phy_create(&pdev->dev, NULL, &phy_meson_usb2_ops);
>>>>>>>>>> +     if (IS_ERR(phy)) {
>>>>>>>>>> +             dev_err(&pdev->dev, "failed to create PHY\n");
>>>>>>>>>> +             return PTR_ERR(phy);
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>> +     if (usb_reset_refcnt++ == 0) {
>>>>>>>>>> +             ret = device_reset(&pdev->dev);
>>>>>>>>>> +             if (ret) {
>>>>>>>>>> +                     dev_err(&phy->dev, "Failed to reset USB PHY\n");
>>>>>>>>>> +                     return ret;
>>>>>>>>>> +             }
>>>>>>>>>> +     }
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The ref count + reset here looks like something that could/should be
>>>>>>>>> handled in a runtime PM callback.
>>>>>>>>
>>>>>>>> Unfortunately that doesn't work (as Jerome found out) because both
>>>>>>>> PHYs are sharing the same reset line.
>>>>>>>> So if the second PHY would call device_reset then it would also reset
>>>>>>>> the first PHY!
>>>>>>>>
>>>>>>>> There's a comment above the declaration of usb_reset_refcnt which
>>>>>>>> tries to explain this:
>>>>>>>> "The PHYs are sharing a common reset line -> we are only allowed to
>>>>>>>> reset once for all PHYs."
>>>>>>>> Maybe I should move this comment to the "if (usb_reset_refcnt++ == 0)
>>>>>>>> {" line to make it easier to see?
>>>>>>>>
>>>>>>>
>>>>>>> pm-runtime has refcounting in it. When one of the nodes turns on,
>>>>>>> the pm-runtime will call your driver to say there is a user when
>>>>>>> this first use turns up.
>>>>>>>
>>>>>>> If all the sub-phys turn off and drop their refcount then the driver
>>>>>>> is called to say there are no more users and you can go to sleep.
>>>>>>
>>>>>>
>>>>>> After a chat w/Martin on IRC, It turns out runtime PM wont help here.
>>>>>>
>>>>>> The reason is because there are physically two PHY devices[1].  Those 2
>>>>>> devices will be treated independely by runtime PM, and have separate
>>>>>> use-counting, which means doing what I proposed would cause a reset to
>>>>>> happen when either device was probed.
>>>>>>
>>>>>> So, I think it's OK as it is.
>>>>>
>>>>>
>>>>> Surely you can do pm_runtime_get/put on the phy's parent platform
>>>>> device and do it that way?
>>>> could you please be more specific with that (do you mean pdev->dev.parent)?
>>>> so we would use pm_runtime_{get_sync,put} with the parent, while we
>>>> would still define the runtime_resume in our driver.
>>>
>>> You'd also need to do get/put on the children, but yes, that's what Ben
>>> is suggesting.
>>>
>>> However, the problem with all of the solutions proposed (runtime PM ones
>>> included) is that we're forcing a board-specific design issue (2 devices
>>> sharing a reset line) into a driver that should not have any
>>> board-specific assumptions in it.
>>>
>>> For example, if this driver is used on another platform where different
>>> PHYs have different reset lines, then one of them (the unlucky one who
>>> is not probed first) will never get reset.  So any form of per-device
>>> ref-counting is not a portable solution.
>> indeed, so in simple words we would need something like
>> reset_control_do_once(rstc, RESET/ASSERT/DEASSERT) which would
>> remember internally if any action has already been executed: if not it
>> does a _reset, _assert or _deassert and otherwise it does nothing.
> for now I've implemented something less hacky: I made the reset
> optional and only specified it for phy0.

That's slightly better, but could misbehave if devices are probed/loaded
in different order?  But, that shouldn't be a blocker for the driver.

> During Jerome's tests the reset was not needed, while on my board it's
> required to bring both PHYs up.
> Additionally the USB PHY reference driver does not have any reset
> logic for newer SoCs (GXL), so making the reset optional doesn't sound
> that bad to me.

Agreed.

Kevin
