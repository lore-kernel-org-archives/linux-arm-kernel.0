From: s-anna@ti.com (Suman Anna)
Date: Mon, 26 Jun 2017 15:20:55 -0500
Subject: [PATCH v3 2/3] remoteproc/keystone: Add a remoteproc driver for
 Keystone 2 DSPs
In-Reply-To: <20170626200608.GG18666@tuxbook>
References: <20170613234513.7624-1-s-anna@ti.com>
 <20170613234513.7624-3-s-anna@ti.com> <20170625201545.GA26155@builder>
 <1ccd9273-0fde-4241-6d99-1d03be2f5b57@ti.com>
 <20170626200608.GG18666@tuxbook>
Message-ID: <1f8d65fc-0acc-499e-a98e-953dce60750f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2017 03:06 PM, Bjorn Andersson wrote:
> On Mon 26 Jun 08:54 PDT 2017, Suman Anna wrote:
> 
>> Hi Bjorn,
>>
>> On 06/25/2017 03:15 PM, Bjorn Andersson wrote:
>>> On Tue 13 Jun 16:45 PDT 2017, Suman Anna wrote:
>>>
>>>> +static int keystone_rproc_start(struct rproc *rproc)
>>>> +{
>>>> +	struct keystone_rproc *ksproc = rproc->priv;
>>>> +	int ret;
>>>> +
>>>> +	INIT_WORK(&ksproc->workqueue, handle_event);
>>>> +
>>>> +	ret = request_irq(ksproc->irq_ring, keystone_rproc_vring_interrupt, 0,
>>>> +			  dev_name(ksproc->dev), ksproc);
>>>> +	if (ret) {
>>>> +		dev_err(ksproc->dev, "failed to enable vring interrupt, ret = %d\n",
>>>> +			ret);
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret = request_irq(ksproc->irq_fault, keystone_rproc_exception_interrupt,
>>>> +			  0, dev_name(ksproc->dev), ksproc);
>>>> +	if (ret) {
>>>> +		dev_err(ksproc->dev, "failed to enable exception interrupt, ret = %d\n",
>>>> +			ret);
>>>> +		goto free_vring_irq;
>>>> +	}
>>>
>>> I do prefer that your request any resources during probe() and
>>> potentially enable/disable them here. If below concern about using a
>>> GPIO driver is cleared already I'll take it as is though.
>>>
>>> [..]
>>>> +static void keystone_rproc_kick(struct rproc *rproc, int vqid)
>>>> +{
>>>> +	struct keystone_rproc *ksproc = rproc->priv;
>>>> +
>>>> +	if (WARN_ON(ksproc->kick_gpio < 0))
>>>> +		return;
>>>> +
>>>> +	gpio_set_value(ksproc->kick_gpio, 1);
>>>> +}
>>>> +
>>>
>>> This doesn't sound like a gpio-controller and the GPIO maintainer did
>>> reject an attempt by me to use the GPIO framework to abstract a similar
>>> thing. Do you already have this driver upstream or have you clarified
>>> with the maintainer that the GPIO framework is an acceptable abstraction
>>> for this?
>>
>> Yeah, this has been upstream since quite some time. See commit
>> 2134cb997f2f ("gpio: syscon: reuse for keystone 2 socs").
>>
> 
> Okay, sounds good. I have merged the series.
> 
> 
> I still would like to have resources allocated at probe() time, so I
> would appreciate a follow up patch moving the request_irq()s to probe,
> per above comment (but we can take that after v4.13).

OK thanks. This is a common theme across all the remoteproc drivers
supporting rpmsg, and I definitely need to disable them in probe since
the boot or the virtio/rpmsg devices are not guaranteed to be present in
the probe.

regards
Suman
