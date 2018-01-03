From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:26:20 +0000
Subject: [RESEND PATCH v2 02/15] soc: qcom: add support to APR bus driver
In-Reply-To: <20180101232932.GK478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-3-srinivas.kandagatla@linaro.org>
 <20180101232932.GK478@tuxbook>
Message-ID: <cb7bfd2e-9240-8aff-adf7-b6e25d3eb53e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank Bjorn for the Review.


On 01/01/18 23:29, Bjorn Andersson wrote:
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index b81374bb6713..1daa39925dd4 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -97,4 +97,12 @@ config QCOM_WCNSS_CTRL
>>   	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
>>   	  firmware to a newly booted WCNSS chip.
>>   
>> +config QCOM_APR
>> +	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
>> +	depends on (RPMSG_QCOM_SMD || RPMSG_QCOM_GLINK_RPM)
> 
> The actual dependency you have is RPMSG. Specifying the individual
> transports here causes additional restrictions in how you can mix and
> match modules vs builtin (e.g. glink being builtin to get regulators
> early and smd built as a module forces apr to be built as a module)
> 
I agree, Will fix this in next version.

>> +++ b/drivers/soc/qcom/apr.c
>> @@ -0,0 +1,395 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> +* Copyright (c) 2011-2016, The Linux Foundation
>> +* Copyright (c) 2017, Linaro Limited
>> +*/
> 
> For some tooling reason the SPDX line should be // commented, i.e this
> should be:
> 
> // SPDX-License-Identifier: GPL-2.0
> /*
>   * Copyright (c) 2011-2016, The Linux Foundation
>   * Copyright (c) 2017, Linaro Limited
>   */
> 
Yep, this was also considered for next version.
>> +
...
>> +
>> +/* Static CORE service on the ADSP */
>> +static const struct apr_device_id core_svc_device_id =
>> +		ADSP_AUDIO_APR_DEV("CORE", APR_SVC_ADSP_CORE);
> 
> How does this work out when we want to use APR for the modem services?
> 
So the plan is, If the modem service can be queried using AVCS core 
commands then it would be added dynamically from q6core driver else we 
can add is as static service into this list.

>> +
>> +/**
>> + * apr_send_pkt() - Send a apr message from apr device
>> + *
>> + * @adev: Pointer to previously registered apr device.
>> + * @buf: Pointer to buffer to send
>> + *
>> + * Return: Will be an negative on packet size on success.
>> + */
>> +int apr_send_pkt(struct apr_device *adev, uint32_t *buf)
> 
> So buf here is a struct apr_hdr followed by arbitrary data. Passing a
> reference to an arbitrary chunk of data should be done with a void *.
> But you could turn struct apr_hdr into struct apr_packet by adding a
> flexible array member at the end of the struct and having this function
> take that data type. This would make the prototype self-documenting.
> 
> 
> I do, however, not fancy the asymmetry of the send/callback interface
> exposed to the client. One takes the raw packet, as it sits in the
> transport and the other creates an abstract representation of the same.
> 
> Can't you in the callback verify the data and then just pass the same
> object up to the client?

I can try it and see how it looks.
> 
>> +{

...

>> +
>> +static int qcom_rpmsg_q6_callback(struct rpmsg_device *rpdev, void *buf,
>> +				  int len, void *priv, u32 addr)
>> +{
>> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
>> +	struct apr_client_data data;
>> +	struct apr_device *p, *c_svc = NULL;
>> +	struct apr_driver *adrv = NULL;
>> +	struct apr_hdr *hdr;
>> +	uint16_t hdr_size;
>> +	uint16_t msg_type;
>> +	uint16_t ver;
>> +	uint16_t src;
>> +	uint16_t svc;
>> +
>> +	if (!buf || len <= APR_HDR_SIZE) {
> 
> rpmsg should never call you with buf = NULL, so no reason to check for
> that.

Yep!

> 
>> +		dev_err(apr->dev, "APR: Improper apr pkt received:%p %d\n",
>> +			buf, len);
>> +		return -EINVAL;
>> +	}
...
>> +
>> +	if (hdr->src_domain >= APR_DOMAIN_MAX ||
>> +			hdr->dest_domain >= APR_DOMAIN_MAX ||
>> +			hdr->src_svc >= APR_SVC_MAX ||
>> +			hdr->dest_svc >= APR_SVC_MAX) {
>> +		dev_err(apr->dev, "APR: Wrong APR header\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	svc = hdr->dest_svc;
>> +	src = apr->data->get_data_src(hdr);
> 
> Couldn't we just use src_domain here instead of maintaining this mapping
> table in the driver?
Yes, we can do that too, I will give that a go.
> 
> Also, looking at the send function, isn't this src just c_svc->svc_id?
> 
src here represents mapping between domain and dest id. It is not same 
as svc_id.
> 
>> +	if (src == APR_DEST_MAX)
>> +		return -EINVAL;
>> +
>> +	spin_lock(&apr->svcs_lock);
>> +	list_for_each_entry(p, &apr->svcs, node) {
>> +		if (svc == p->svc_id) {
>> +			c_svc = p;
>> +			if (c_svc->dev.driver)
>> +				adrv = to_apr_driver(c_svc->dev.driver);
>> +			break;
>> +		}
>> +	}
> 
> Keep your services in a idr, keyed by svc_id. This will make the search
> O(log(n)), but more importantly it would replace this loop with a single
> idr_find().
> 
I will try it and see how it looks!

>> +	spin_unlock(&apr->svcs_lock);
>> +
>> +	if (!adrv) {
>> +		dev_err(apr->dev, "APR: service is not registered\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	data.payload_size = hdr->pkt_size - hdr_size;
>> +	data.opcode = hdr->opcode;
>> +	data.src = src;
>> +	data.src_port = hdr->src_port;
>> +	data.dest_port = hdr->dest_port;
>> +	data.token = hdr->token;
>> +	data.msg_type = msg_type;
>> +
>> +	if (data.payload_size > 0)
>> +		data.payload = (char *)hdr + hdr_size;
> 
> Using buf + hdr_size probably makes even more sense, and saves you from
> the typecast.
> 
Agree!

>> +
>> +	adrv->callback(c_svc, &data);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct apr_device_id *apr_match(const struct apr_device_id *id,
>> +					       const struct apr_device *adev)
>> +{
>> +	while (id->domain_id != 0 || id->svc_id != 0) {
>> +		if (id->domain_id == adev->domain_id &&
>> +		    id->svc_id == adev->svc_id &&
>> +		    id->client_id == adev->client_id)
> 
> Is the client_id significant here? As far as I can tell it's a
> identifier of the local "function". Are there multiple client drivers
> that would "attach" to the same remote service?

No. svc id is unique per client id, so it redundant check as you said.

> 
>> +			return id;
>> +		id++;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static int apr_device_match(struct device *dev, struct device_driver *drv)
>> +{
>> +	struct apr_device *adev = to_apr_device(dev);
>> +	struct apr_driver *adrv = to_apr_driver(drv);
>> +
>> +	return !!apr_match(adrv->id_table, adev);
> 
> If this remain the only caller of apr_match() you could just inline the
> loop here.
Makes sense.
> 
>> +}
>> +
>> +static int apr_device_probe(struct device *dev)
>> +{
>> +	struct apr_device	*adev;
>> +	struct apr_driver	*adrv;
> 
> You don't indent things elsewhere.
Yep.
> 
>> +	int ret = 0;
>> +
>> +	adev = to_apr_device(dev);
>> +	adrv = to_apr_driver(dev->driver);
>> +
>> +	ret = adrv->probe(adev);
> 
> Drop ret and just return adrv->probe()
> 
yep

>> +
>> +	return ret;
>> +}
>> +
...
>> +
>> +/**
>> + * apr_add_device() - Add a new apr device
>> + *
>> + * @dev: Pointer to apr device.
>> + * @id: Pointer to apr device id to add.
>> + *
>> + * Return: Will be an negative on error or a zero on success.
>> + */
>> +int apr_add_device(struct device *dev, const struct apr_device_id *id)
>> +{
>> +	struct apr *apr = dev_get_drvdata(dev);
> 
> It's not obvious which dev this is, but it has to be the rpmsg device or
> this would dereference the drvdata of the wrong type and things would be
> very bad.
> 
> How about making this more explicit by just taking a struct apr * as
> first argument, and then provide a helper for clients to acquire the
> struct apr * from the parent dev, if this is needed.
> 
Yep, that makes it much cleaner, will do it in next version.

>> +	struct apr_device *adev = NULL;
>> +
>> +	if (!apr)
>> +		return -EINVAL;
>> +
>> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>> +	if (!adev)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&adev->lock);
>> +
>> +	adev->svc_id = id->svc_id;
>> +	adev->dest_id = apr->dest_id;
>> +	adev->client_id = id->client_id;
>> +	adev->domain_id = id->domain_id;
> 
> Wouldn't this always be the domain of the apr? (or we're adding a device
> to the wrong apr)
> 
Yes, it is.

>> +	adev->version = id->svc_version;
>> +
>> +	adev->dev.bus = &aprbus_type;
>> +	adev->dev.parent = dev;
>> +	adev->dev.release = apr_dev_release;
>> +	adev->dev.driver = NULL;
>> +
>> +	dev_set_name(&adev->dev, "apr:%s:%x:%x:%x", id->name, id->domain_id,
>> +				 id->svc_id, id->client_id);
>> +
>> +	spin_lock(&apr->svcs_lock);
>> +	list_add_tail(&adev->node, &apr->svcs);
>> +	spin_unlock(&apr->svcs_lock);
> 
> This causes svcs to contain entries related to devices that has not been
> matched and probed yet (e.g. implementation is in a kernel module not
> loaded). I think you should move this to apr_device_probe().
> 
Yep!
>> +
>> +	return device_register(&adev->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(apr_add_device);
>> +
...
>> +static int apr_v2_get_data_src(struct apr_hdr *hdr)
>> +{
>> +	if (hdr->src_domain == APR_DOMAIN_MODEM)
>> +		return APR_DEST_MODEM;
>> +	else if (hdr->src_domain == APR_DOMAIN_ADSP)
>> +		return APR_DEST_QDSP6;
>> +
>> +	return APR_DEST_MAX;
> 
> The idiomatic return value here would be -EINVAL.
> 
yep!, I try it this would also change logic at caller side.

>> +}
>> +
>> +/*
>

>> +
>> +static const struct apr_data apr_v2_data = {
>> +	.get_data_src = apr_v2_get_data_src,
>> +	.dest_id = APR_DEST_QDSP6,
>> +};
>> +
>> +static const struct of_device_id qcom_rpmsg_q6_of_match[] = {
>> +	{ .compatible = "qcom,apr-msm8996", .data = &apr_v2_data},
> 
> The dest_id of apr_v2_data and the use of "q6" in the name indicates
> that this is the "msm8996 adsp apr", what's your plan to support other
> apr remotes?

We would need one more entry for modem case, like db410c cases, Will add 
this as we move on.

> How about making the domain id a property of the apr in DT and then just
> list the clients as nodes with svc_id, svc_version and client_id? You
> can still match by device_id (compatible can be optional), but that
> would allow you to describe either the adsp or modem apr link, of any
> platform (of that apr version), with the same compatible.
> 

This will work too!

Current design I had in mind was to get the q6core service up and this 
can query what AVCS static services are available on remote side and 
then add apr devices.

If we go with dt approch we might not need q6core driver, but on the 
other hand we need to be aware of svc major and minor version, which 
might be specific to the dsp firmware running on. Also we might endup 
talking on services without querying the dsp state.

May be we should do some offline disussion on this!


>> +	{}
>> +};
>> +
>> +static struct rpmsg_driver qcom_rpmsg_q6_driver = {
>> +	.probe = qcom_rpmsg_q6_probe,
>> +	.remove = qcom_rpmsg_q6_remove,
>> +	.callback = qcom_rpmsg_q6_callback,
>> +	.drv = {
>> +		.name = "qcom_rpmsg_q6",
>> +		.owner = THIS_MODULE,
> 
> Drop the owner.
> 
Yep!

>> +		.of_match_table = qcom_rpmsg_q6_of_match,
>> +		},
> 
> Indentation.

Sure!
> 
>> +};
>> +
>> +static int __init apr_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = register_rpmsg_driver(&qcom_rpmsg_q6_driver);
>> +	if (!ret)
>> +		return bus_register(&aprbus_type);
> 
> Register the bus first, then the rpmsg driver.

yep!

> 
>> +
>> +	return ret;
>> +}
>> +
...

>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index abb6dc2ebbf8..068d215c3be6 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -452,6 +452,19 @@ struct spi_device_id {
>>   	kernel_ulong_t driver_data;	/* Data private to the driver */
>>   };
>>   
>> +
> 
> One newline is enough.
yep

> 
>> +#define APR_NAME_SIZE	32
>> +#define APR_MODULE_PREFIX "apr:"
>> +
>> +struct apr_device_id {
>> +	char name[APR_NAME_SIZE];
> 
> Does this name has any meaning? As far as I can see we're matching on
> the other parameters and use the name only to name the device.
No, it just to give the device a usefull name.
> 
>> +	__u32 domain_id;
>> +	__u32 svc_id;
>> +	__u32 client_id;
>> +	__u32 svc_version;
>> +	kernel_ulong_t driver_data;	/* Data private to the driver */
>> +};
>> +
>>   #define SPMI_NAME_SIZE	32
>>   #define SPMI_MODULE_PREFIX "spmi:"
>>   
>> diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
>> new file mode 100644
>> index 000000000000..8620289c34ab
>> --- /dev/null
>> +++ b/include/linux/soc/qcom/apr.h

...

>> +
>> +#define APR_DL_SMD    0
>> +#define APR_DL_MAX    1
> 
> Unused.
will remove it.
> 
>> +
...
>> +#define APR_HDR_SIZE sizeof(struct apr_hdr)
>> +#define APR_SEQ_CMD_HDR_FIELD APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD, \
>> +					    APR_HDR_LEN(APR_HDR_SIZE), \
>> +					    APR_PKT_VER)
> 
> So for the tx path these macros are to be used by the client and for the
> rx path they are to be used by the apr driver. Better make the api
> symmetrical.
Will try that in next version.

> 
> One possible path is to use an sk_buf for the tx-path and reserve space
> for the header, then pass the abstract version of the packet and let the
> apr driver fill out the header.
> 
In some cases like q6asm the apr header port numbers are much more 
specific to the service and they change depening on stream and session 
ids within the service.

>> +

>> +struct apr_client_data {
> 
> Perhaps name this apr_client_message or similar, to indicate that this
> is not a per-client thing, but a description of a message/packet.

make sense, Will change it to apr_client_message.
> 
>> +	uint16_t payload_size;
...
>> +	void *payload;
>> +};
>> +
> 
> Regards,
> Bjorn
> 
