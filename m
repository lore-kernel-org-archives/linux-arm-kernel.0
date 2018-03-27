From: arvind.yadav.cs@gmail.com (arvindY)
Date: Tue, 27 Mar 2018 08:00:50 +0530
Subject: [PATCH] coresight: use put_device() instead of kfree()
In-Reply-To: <CANLsYkymOF2oG7TmKbRTakYKw0ECN_DXfkX5b8WjmS0Lz0sfig@mail.gmail.com>
References: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
 <CANLsYkymOF2oG7TmKbRTakYKw0ECN_DXfkX5b8WjmS0Lz0sfig@mail.gmail.com>
Message-ID: <5AB9ACDA.9090207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 27 March 2018 03:16 AM, Mathieu Poirier wrote:
> drivers/hwtracing/coresight/coresight.c
> On 18 March 2018 at 01:38, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> Never directly free @dev after calling device_register(), even
>> if it returned an error. Always use put_device() to give up the
>> reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/hwtracing/coresight/coresight.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
>> index 389c4ba..132dfbc 100644
>> --- a/drivers/hwtracing/coresight/coresight.c
>> +++ b/drivers/hwtracing/coresight/coresight.c
>> @@ -1026,8 +1026,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>          dev_set_name(&csdev->dev, "%s", desc->pdata->name);
>>
>>          ret = device_register(&csdev->dev);
>> -       if (ret)
>> -               goto err_device_register;
>> +       if (ret) {
>> +               put_device(&csdev->dev);
>> +               goto err_kzalloc_csdev;
>> +       }
>>
>>          mutex_lock(&coresight_mutex);
>>
>> @@ -1038,8 +1040,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>
>>          return csdev;
>>
>> -err_device_register:
>> -       kfree(conns);
> Apologies for the late reply, I was travelling.
>
> I suggest to simply replace kfree() with put_device() in order to
> concentrate the error handling code in the same area and make sure
> that memory allocated for @conns and @refcnts is freed.
>
> Thanks,
> Mathieu

If you will see the comment for device_register(drivers/base/core.c)
there is mentioned that 'NOTE: _Never_ directly free @dev
after calling this function, even if it returned an error!
Always use put_device() to give up the reference initialized
in this function instead.
Here  put_device() will decrement the last reference and then
free the memory by calling dev->release.  Internally
put_device() -> kobject_put() -> kobject_cleanup() which is
responsible to call 'dev -> release' and also free other kobject
resources. we should always avoid kfree() if device_register()
returned an error. Otherwise it'll not do clean up of other
kobject resources.

~arvind
>>   err_kzalloc_conns:
>>          kfree(refcnts);
>>   err_kzalloc_refcnts:
>> --
>> 2.7.4
>>
