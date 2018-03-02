From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 2 Mar 2018 18:51:58 +0000
Subject: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to Q6AFE
In-Reply-To: <20180302175451.GB3482@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <20180301205940.GR12864@sirena.org.uk>
 <66d37327-b8ea-0da5-3e05-435cec5d84ab@linaro.org>
 <20180302175451.GB3482@sirena.org.uk>
Message-ID: <22154699-66f4-34fb-ea60-f3e88a922ce4@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review comments,


On 02/03/18 17:54, Mark Brown wrote:
> On Fri, Mar 02, 2018 at 01:13:17PM +0000, Srinivas Kandagatla wrote:
>> On 01/03/18 20:59, Mark Brown wrote:
>>> On Tue, Feb 13, 2018 at 04:58:17PM +0000, srinivas.kandagatla at linaro.org wrote:
> 
>>>> +static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>>>> +	[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
>>>> +				AFE_PORT_HDMI_RX, 1, 1},
>>>> +};
> 
>>> Is this not device specific in any way?  It looks likely to be.
> 
>> It is specific to Audio firmware build.
>> AFAIK, DSP port IDs are consistent across a given range of AVS firmware
>> builds. So far I have seen them not change in any of the B family SoCs.
>> However on older A family SOCs these are very different numbers. Which is
>> where ADSP version info would help select correct map.
> 
> Can we have some documentation of this in the code please?
> 
Sure, I will add documentation in next version.

>>>> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
>>>> +{
>>>> +	struct q6afe_port *p = NULL;
>>>> +
>>>> +	spin_lock(&afe->port_list_lock);
>>>> +	list_for_each_entry(p, &afe->port_list, node)
>>>> +		if (p->token == token)
>>>> +			break;
>>>> +
>>>> +	spin_unlock(&afe->port_list_lock);
> 
>>> Why do we need to lock the port list, what are we protecting it against?
> 
>> This is just to protect the list from anyone deleting this.
> 
>> Its very rare but the use case could be somelike the adsp is up and we are
>> in the middle of finding a port and then adsp went down or crashed we would
>> delete an entry in the list.
> 
> If that's what we're protecting against then this also needs to do
> something to ensure that the port we looked up doesn't get deallocated
> before or while we look at it.
Yes, I will take closer look at all possible paths before sending next 
version.
> 
>>>> +int q6afe_port_start(struct q6afe_port *port)
>>>> +{
>>>> +	return afe_port_start(port, &port->port_cfg);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(q6afe_port_start);
> 
>>> This is the third level of wrapper for the port start command in this
>>> file.  Do we *really* need all these wrappers?
> 
>> Intention here is that we have plans to support different version of ADSP,
>> on A family this command is different, so having this wrapper would help
>> tackle this use-case.
> 
> Why not just take out the level of wrapper for now then add it in when
> there's actually an abstraction in there?  The code might end up looking
> different anyway.
Okay, I can do that, will remove extra abstraction layer.

thanks,
srini
> 
