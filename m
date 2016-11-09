From: minyard@acm.org (Corey Minyard)
Date: Wed, 9 Nov 2016 10:04:02 -0600
Subject: [PATCH 3/3] ipmi/bt-bmc: add a sysfs file to configure a maximum
 response time
In-Reply-To: <aa4804b0-4084-6d34-c1db-68bdb5efb20a@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-4-git-send-email-clg@kaod.org>
 <3a1f8e6d-c935-3404-ffa0-81b19d170731@acm.org>
 <aa4804b0-4084-6d34-c1db-68bdb5efb20a@kaod.org>
Message-ID: <7e7e5cde-341a-ecca-9c9c-b41695703b08@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2016 08:42 AM, C?dric Le Goater wrote:
> On 11/07/2016 07:37 PM, Corey Minyard wrote:
>> Sorry, I was at Plumbers and extra busy with other stuff.  Just getting around to reviewing this.
>>
>> On 11/02/2016 02:57 AM, C?dric Le Goater wrote:
>>> We could also use an ioctl for that purpose. sysfs seems a better
>>> approach.
>>>
>>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>>> ---
>>>    drivers/char/ipmi/bt-bmc.c | 31 +++++++++++++++++++++++++++++++
>>>    1 file changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
>>> index e751e4a754b7..d7146f0e900e 100644
>>> --- a/drivers/char/ipmi/bt-bmc.c
>>> +++ b/drivers/char/ipmi/bt-bmc.c
>>> @@ -84,6 +84,33 @@ struct bt_bmc {
>>>      static atomic_t open_count = ATOMIC_INIT(0);
>>>    +static ssize_t bt_bmc_show_response_time(struct device *dev,
>>> +                     struct device_attribute *attr,
>>> +                     char *buf)
>>> +{
>>> +    struct bt_bmc *bt_bmc = dev_get_drvdata(dev);
>>> +
>>> +    return snprintf(buf, PAGE_SIZE - 1, "%d\n", bt_bmc->response_time);
>>> +}
>>> +
>>> +static ssize_t bt_bmc_set_response_time(struct device *dev,
>>> +                    struct device_attribute *attr,
>>> +                    const char *buf, size_t count)
>>> +{
>>> +    struct bt_bmc *bt_bmc = dev_get_drvdata(dev);
>>> +    unsigned long val;
>>> +    int err;
>>> +
>>> +    err = kstrtoul(buf, 0, &val);
>>> +    if (err)
>>> +        return err;
>>> +    bt_bmc->response_time = val;
>>> +    return count;
>>> +}
>>> +
>>> +static DEVICE_ATTR(response_time, 0644,
>>> +           bt_bmc_show_response_time, bt_bmc_set_response_time);
>>> +
>>>    static u8 bt_inb(struct bt_bmc *bt_bmc, int reg)
>>>    {
>>>        return ioread8(bt_bmc->base + reg);
>>> @@ -572,6 +599,10 @@ static int bt_bmc_probe(struct platform_device *pdev)
>>>        bt_bmc_config_irq(bt_bmc, pdev);
>>>          bt_bmc->response_time = BT_BMC_RESPONSE_TIME;
>>> +    rc = device_create_file(&pdev->dev, &dev_attr_response_time);
>>> +    if (rc)
>>> +        dev_warn(&pdev->dev, "can't create response_time file\n");
>>> +
>> You added an extra space here.
> yes. I will remove it in the next version.
>
> The patch raises a few questions on the "BT Interface Capabilities" :
>
>   - should we use sysfs or a specific ioctl to configure the driver ?

I should probably say sysfs, but really I don't care.  The hard part about
ioctls is the compat, and there shouldn't be any compat issues with this
interface.  An ioctl is probably easier, especially if you add an ioctl for
the header size thing I talked about in the previous email.

The only thing that matters to the driver is the timeout.  If you want to
make the timeout per fd, then it will have to be an ioctl.

>   - should the driver handle directly the response to the "Get BT
>     Interface Capabilities" command ?

That probably belongs in userspace.  The only reason I can think of
to have it in the driver would be so the host driver can fetch it if the
BMC userspace is down, but I can't see how that's a good idea.

Hope my wishy-washy answer helps :-).

-corey

> What is your opinion ?
>
> Thanks,
>
> C.
>
>>>          if (bt_bmc->irq) {
>>>            dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>>
