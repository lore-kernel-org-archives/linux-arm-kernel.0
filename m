From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 17 May 2018 18:10:49 +0100
Subject: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
In-Reply-To: <20180517065544.GO20254@sirena.org.uk>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
Message-ID: <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On 17/05/18 07:55, Mark Brown wrote:
> On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:
> 
>> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
>> +{
>> +	struct q6afe_port *p = NULL;
>> +	struct q6afe_port *ret = NULL;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&afe->port_list_lock, flags);
>> +	list_for_each_entry(p, &afe->port_list, node)
>> +		if (p->token == token) {
>> +			ret = p;
>> +			break;
>> +		}
>> +
>> +	spin_unlock_irqrestore(&afe->port_list_lock, flags);
>> +	return ret;
> 
> This lock only protects the list, it does nothing to ensure that the
> port we look up is still valid by the time we return to the caller.
> That means we won't crash during list traversal but does nothing to
> ensure we won't crash immediately afterwards if the port is deallocated
> just after we look it up.  What stops that happening?

Each port is allocated and de-allocated in dai probe and remove calls 
respectively.

Lets say... So for this case to happen the dai has to be removed (unload 
module) at the same time when the interrupt callback happens due to 
delayed response from previous commands.

This case would be almost impossible because all the calls to afe 
service are synchronous with timeouts, if any of the previous calls 
times out the respective caller would get an error, this should prevent 
him from unloading the module in the first place.


thanks,
srini

> 
