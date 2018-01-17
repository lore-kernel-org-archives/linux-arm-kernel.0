From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 16:30:08 +0900
Subject: [PATCH v2 11/13] iommu/rockchip: Use OF_IOMMU to attach devices
 automatically
In-Reply-To: <5A5EF94E.7010806@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-12-jeffy.chen@rock-chips.com>
 <CAAFQd5C=SM21CmL8J334HseJ6SJH1wAVzKhrsk_cXMmpf8mK8g@mail.gmail.com>
 <5A5EF94E.7010806@rock-chips.com>
Message-ID: <CAAFQd5AOZ797dNEvr5TbuWK-rw=dTCArUZM53t4_gNRugBd=sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:20 PM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
>
> On 01/17/2018 01:44 PM, Tomasz Figa wrote:
>>
>> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com>
>> wrote:
>>>
>>> Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
>>> which allows attaching master devices to their IOMMUs automatically
>>> according to DT properties.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>   drivers/iommu/rockchip-iommu.c | 116
>>> +++++++++++------------------------------
>>>   1 file changed, 31 insertions(+), 85 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c
>>> b/drivers/iommu/rockchip-iommu.c
>>> index 51e4f982c4a6..c2d3ac82184e 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>>
>> [snip]
>>>
>>> +static int rk_iommu_of_xlate(struct device *dev,
>>> +                            struct of_phandle_args *args)
>>> +{
>>> +       struct platform_device *iommu_dev;
>>> +
>>> +       iommu_dev = of_find_device_by_node(args->np);
>>> +       if (!iommu_dev) {
>>> +               dev_err(dev, "iommu %pOF not found\n", args->np);
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       dev->archdata.iommu = platform_get_drvdata(iommu_dev);
>>
>>
>> This will work only if that iommu was already probed. Do we have any
>> guarantees that this callback is not called earlier?
>
> in of_iommu.c, the of_iommu_xlate would check for fwnode before calling
> this.

Right, looks like deferred probe is handled there.

>
> but it's possible the probe failed after calling iommu_device_set_fwnode, so
> i'll try to add some checks here, and maybe adjust probe() to prevent it
> too.

I think iommu_device_set_fwnode() is not enough for of_iommu_xlate()
to find the IOMMU. The IOMMU is actually added to the IOMMU list by
iommu_device_register(), which is last in the sequence, so I guess we
should be fine.

Best regards,
Tomasz
