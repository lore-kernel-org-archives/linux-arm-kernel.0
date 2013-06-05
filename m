From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Jun 2013 10:55:58 +0530
Subject: [PATCH v6 1/9] drivers: phy: add generic PHY framework
In-Reply-To: <51ADEEF6.1030200@samsung.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
 <1367229812-30574-2-git-send-email-kishon@ti.com>
 <51ADBF9B.5060403@samsung.com> <51ADDCD9.8080400@ti.com>
 <51ADEEF6.1030200@samsung.com>
Message-ID: <51AECBE6.9090400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 04 June 2013 07:13 PM, Sylwester Nawrocki wrote:
> Hi,
>
> On 06/04/2013 02:26 PM, Kishon Vijay Abraham I wrote:
>>>> +static inline int phy_init(struct phy *phy)
>>>> +{
>>>> +	pm_runtime_get_sync(&phy->dev);
>>>
>>> Hmm, no need to check return value here ? Also it looks a bit unexpected to
>>
>> I purposely dint check the return values in order to support platforms
>> that don?t enable pm_runtime.
>
> Then I guess this should be called conditionally and any errors returned
> if runtime PM is enabled ? Not sure if pm_runtime_enabled() would be
> helpful such situation.
Indeed. I think it can be used.
>
>>> possibly have runtime_resume callback of a PHY device called before ops->init()
>>> call ? It seems a bit unclear what the purpose of init() callback is.
>>
>> Not really. Anything that is used to initialize the PHY (internal
>> configuration) can go in phy_init. Usually in runtime_resume callback,
>> optional functional clocks are enabled and also in some cases context
>> restore is done. So it really makes sense to enable clocks/module
>> (pm_runtime_get_sync) before doing a PHY configuration (phy_init).
>
> OK, that makes sense. All PHY device resources must be prepared anyway
> before a PHY object is registered with the PHY core.
>
>>>> +	if (phy->ops->init)
>>>> +		return phy->ops->init(phy);
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +
>>>> +static inline int phy_exit(struct phy *phy)
>>>> +{
>>>> +	int ret = -EINVAL;
>>>> +
>>>> +	if (phy->ops->exit)
>>>> +		ret = phy->ops->exit(phy);
>>>> +
>>>> +	pm_runtime_put_sync(&phy->dev);
>>>> +
>>>> +	return ret;
>>>> +}
>>>
>>> Do phy_init/phy_exit need to be mandatory ? What if there is really
>>
>> No. phy_init/phy_exit is not mandatory at all.
>>> nothing to do in those callbacks ? Perhaps -ENOIOCTLCMD should be
>>> returned if a callback is not implemented, so PHY users can recognize
>>> such situation and proceed ?
>>
>> So currently these APIs return -EINVAL if these callbacks are not
>> populated which is good enough IMHO.
>
> But -EINVAL could be well returned from the callback function. Perhaps
> ENOTSUPP could be used instead ?

hmm.. could be..

Thanks
Kishon
