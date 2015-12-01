From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 01 Dec 2015 10:25:46 +0100
Subject: [PATCH v2 2/4] driver core: handle -EPROBE_DEFER from
 bus_type.match()
In-Reply-To: <CAPDyKFrhWeY_2-1np72TLbibMUPJ2s+As48WMGgfbj2CS-waBw@mail.gmail.com>
References: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
 <1448542190-19498-3-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFrhWeY_2-1np72TLbibMUPJ2s+As48WMGgfbj2CS-waBw@mail.gmail.com>
Message-ID: <565D679A.6010303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-11-30 14:36, Ulf Hansson wrote:
> On 26 November 2015 at 13:49, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> Lets implementations of the match() callback in struct bus_type to
> /s/Lets/Allow
>
>> return errors and if it's -EPROBE_DEFER then queue the device for
>> deferred probing.
>>
>> This is useful to buses such as AMBA in which devices are registered
>> before their matching information can be retrieved from the HW
>> (typically because a clock driver hasn't probed yet).
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/base/dd.c      | 24 ++++++++++++++++++++++--
>>   include/linux/device.h |  2 +-
>>   2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index a641cf3..a20c119 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -490,6 +490,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>>          struct device_attach_data *data = _data;
>>          struct device *dev = data->dev;
>>          bool async_allowed;
>> +       int ret;
>>
>>          /*
>>           * Check if device has already been claimed. This may
>> @@ -500,8 +501,17 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>>          if (dev->driver)
>>                  return -EBUSY;
>>
>> -       if (!driver_match_device(drv, dev))
>> +       ret = driver_match_device(drv, dev);
>> +       if (!ret)
>>                  return 0;
>> +       else if (ret < 0) {
> Depending on what happens with the added dev_warn() below, perhaps a
> switch statement can make it a bit clearer, instead of these messy if
> clauses?

Frankly, I have no idea how to convert this to switch statement and make
the code easier to read. Please note that we have the following 4 cases:

ret > 0: positive match
ret == 0: negative match
ret == -EPROBE_DEFER: deferred probe
ret < 0: other, unknown error

Another way to encode this logic is the following code:

if (ret == 0) {
         /* no match */
         return 0;
} else if (ret == -EPROBE_DEFER) {
         dev_dbg(dev, "Device match requests probe deferral\n");
         driver_deferred_probe_add(dev);
         return ret;
} else if (ret < 0) {
         dev_dbg(dev, "Bus failed to match device: %d", ret);
         return ret;
} /* ret > 0 means positive match */


>> +               if (ret == -EPROBE_DEFER) {
>> +                       dev_dbg(dev, "Device match requests probe deferral\n");
>> +                       driver_deferred_probe_add(dev);
>> +               } else
>> +                       dev_warn(dev, "Bus failed to match device: %d", ret);
> Greg commented on this before, as it may introduce some noise [1].
>
> I started browsing various bus?s implementation of the ->match()
> callback. A quick search tells me that most implementations are
> following the Documentation/driver-model/porting.txt, which means
> returning 0 or 1. Actually I couldn't find anyone returning any other
> value, though it was a quick search.
>
> On the other hand, include/linux/device.h states a "non-zero" value is
> allowed to be return, so there's a tiny conflict between the code and
> the documentation. I guess we should fix that!?

Okay, I will update the documentation as well.

> No matter what, I realize that it could be useful to print a message
> when receiving a negative error code, maybe dev_dbg() could be
> sufficient?
>
>> +               return ret;
>> +       }
>>
>>          async_allowed = driver_allows_async_probing(drv);
>>
>> @@ -621,6 +631,7 @@ void device_initial_probe(struct device *dev)
>>   static int __driver_attach(struct device *dev, void *data)
>>   {
>>          struct device_driver *drv = data;
>> +       int ret;
>>
>>          /*
>>           * Lock device and try to bind to it. We drop the error
>> @@ -632,8 +643,17 @@ static int __driver_attach(struct device *dev, void *data)
>>           * is an error.
>>           */
>>
>> -       if (!driver_match_device(drv, dev))
>> +       ret = driver_match_device(drv, dev);
>> +       if (!ret)
>> +               return 0;
>> +       else if (ret < 0) {
>> +               if (ret == -EPROBE_DEFER) {
>> +                       dev_dbg(dev, "Device match requests probe deferral\n");
>> +                       driver_deferred_probe_add(dev);
>> +               } else
>> +                       dev_warn(dev, "Bus failed to match device: %d", ret);
>>                  return 0;
>> +       }
>>
>>          if (dev->parent)        /* Needed for USB */
>>                  device_lock(dev->parent);
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index b8f411b..d4e7d1f 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -70,7 +70,7 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
>>    * @dev_groups:        Default attributes of the devices on the bus.
>>    * @drv_groups: Default attributes of the device drivers on the bus.
>>    * @match:     Called, perhaps multiple times, whenever a new device or driver
>> - *             is added for this bus. It should return a nonzero value if the
>> + *             is added for this bus. It should return a positive value if the
>>    *             given device can be handled by the given driver.
>>    * @uevent:    Called when a device is added, removed, or a few other things
>>    *             that generate uevents to add the environment variables.
>> --
>> 1.9.2

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
