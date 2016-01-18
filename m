From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Mon, 18 Jan 2016 19:35:38 +0800
Subject: [PATCH v2 next-next] net: hns: enet specifies a reference to dsaf
In-Reply-To: <1452764635.2521.28.camel@linux.intel.com>
References: <1452654880-28980-1-git-send-email-yankejian@huawei.com>
 <56970F48.9060504@huawei.com> <1452764635.2521.28.camel@linux.intel.com>
Message-ID: <569CCE0A.5010005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/14 17:43, Andy Shevchenko wrote:
> On Thu, 2016-01-14 at 11:00 +0800, Yisen Zhuang wrote:
>> ? 2016/1/13 11:14, Kejian Yan ??:
>>> This patch replace the assoication between dsaf and enet from
>>> string
>>> matching to object reference. It requires the DTS to be updated
>>> within
>>> BIOS. Thanks god it can be done for all released boards.
>>>
>> Hi kejian,
>>
>> This patch is fine to me.
> There are few thing below.
>
>>  
>>> --- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
>>> @@ -847,6 +847,7 @@ static struct hnae_ae_ops hns_dsaf_ops = {
>>>  int hns_dsaf_ae_init(struct dsaf_device *dsaf_dev)
>>>  {
>>>  	struct hnae_ae_dev *ae_dev = &dsaf_dev->ae_dev;
>>> +	static atomic_t id = ATOMIC_INIT(-1);
>>>  
>>>  	switch (dsaf_dev->dsaf_ver) {
>>>  	case AE_VERSION_1:
>>> @@ -858,6 +859,9 @@ int hns_dsaf_ae_init(struct dsaf_device
>>> *dsaf_dev)
>>>  	default:
>>>  		break;
>>>  	}
>>> +
>>> +	snprintf(ae_dev->name, AE_NAME_SIZE, "%s%d",
>>> DSAF_DEVICE_NAME,
>>> +		 (int)atomic_inc_return(&id));
> If you bind/unbind device enough times you may get an overflow and end
> up with name of existing device (if you have 1+ of them in the system).
>
> To avoid such situation better to use IDA/IDR framework.

thanks

Best Regards
Kejian Yan

>>>  
>>> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
>>> @@ -1802,7 +1802,7 @@ static int hns_nic_try_get_ae(struct
>>> net_device *ndev)
>>>  	int ret;
>>>  
>>>  	h = hnae_get_handle(&priv->netdev->dev,
>>> -			    priv->ae_name, priv->port_id, NULL);
>>> +			    priv->ae_node, priv->port_id, NULL);
>>>  	if (IS_ERR_OR_NULL(h)) {
>>>  		ret = PTR_ERR(h);
>>>  		dev_dbg(priv->dev, "has not handle, register
>>> notifier!\n");
>>> @@ -1880,9 +1880,12 @@ static int hns_nic_dev_probe(struct
>>> platform_device *pdev)
>>>  	else
>>>  		priv->enet_ver = AE_VERSION_2;
>>>  
>>> -	ret = of_property_read_string(node, "ae-name", &priv-
>>>> ae_name);
>>> -	if (ret)
>>> -		goto out_read_string_fail;
> (1)
>
>>> +	priv->ae_node = (void *)of_parse_phandle(node, "ae-
>>> handle", 0);
>>> +	if (IS_ERR_OR_NULL(priv->ae_node)) {
>>> +		ret = PTR_ERR(priv->ae_node);
>>> +		dev_err(dev, "not find ae-handle\n");
>>> +		goto out_read_handle_fai;
> (2)
>
>>> +	}
>>>  
>>>  	ret = of_property_read_u32(node, "port-id", &priv-
>>>> port_id);
>>>  	if (ret)
>>> @@ -1945,6 +1948,8 @@ static int hns_nic_dev_probe(struct
>>> platform_device *pdev)
>>>  
>>>  out_notify_fail:
>>>  	(void)cancel_work_sync(&priv->service_task);
>>> +out_read_handle_fai:
>>> +
> Redundant line
>
>>>  out_read_string_fail:
> Leftover? (see (1) and (2) )

thanks.

Best Regards
Kejian Yan
