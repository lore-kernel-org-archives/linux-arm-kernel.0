From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 1 Dec 2015 13:57:54 +0100
Subject: [PATCH v2 2/4] driver core: handle -EPROBE_DEFER from
 bus_type.match()
In-Reply-To: <565D679A.6010303@samsung.com>
References: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
 <1448542190-19498-3-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFrhWeY_2-1np72TLbibMUPJ2s+As48WMGgfbj2CS-waBw@mail.gmail.com>
 <565D679A.6010303@samsung.com>
Message-ID: <CAPDyKFqTkNe+OrhmgontJXuayfUH_z_YRWaX7SGnZsFSOHEAPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> @@ -500,8 +501,17 @@ static int __device_attach_driver(struct
>>> device_driver *drv, void *_data)
>>>          if (dev->driver)
>>>                  return -EBUSY;
>>>
>>> -       if (!driver_match_device(drv, dev))
>>> +       ret = driver_match_device(drv, dev);
>>> +       if (!ret)
>>>                  return 0;
>>> +       else if (ret < 0) {
>>
>> Depending on what happens with the added dev_warn() below, perhaps a
>> switch statement can make it a bit clearer, instead of these messy if
>> clauses?
>
>
> Frankly, I have no idea how to convert this to switch statement and make

You are right!

I was thinking that "1" was the only supported positive value,
according to the documentation.

> the code easier to read. Please note that we have the following 4 cases:
>
> ret > 0: positive match
> ret == 0: negative match
> ret == -EPROBE_DEFER: deferred probe
> ret < 0: other, unknown error
>
> Another way to encode this logic is the following code:
>
> if (ret == 0) {
>         /* no match */
>         return 0;
> } else if (ret == -EPROBE_DEFER) {
>         dev_dbg(dev, "Device match requests probe deferral\n");
>         driver_deferred_probe_add(dev);
>         return ret;
> } else if (ret < 0) {
>         dev_dbg(dev, "Bus failed to match device: %d", ret);
>         return ret;
> } /* ret > 0 means positive match */

Okay! To me this looks better!

[...]

Kind regards
Uffe
