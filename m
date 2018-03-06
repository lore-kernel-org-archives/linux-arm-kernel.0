From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 6 Mar 2018 09:26:42 +0000
Subject: [PATCH v3 07/25] ASoC: qcom: qdsp6: Add support to Q6ADM
In-Reply-To: <20180301212402.GT12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
 <20180301212402.GT12864@sirena.org.uk>
Message-ID: <bb87bd34-ab81-e297-3bd4-3e52f6859e34@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review,

On 01/03/18 21:24, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:19PM +0000, srinivas.kandagatla at linaro.org wrote:
> 
>> +static struct copp *adm_find_copp(struct q6adm *adm, int port_idx,
>> +				  int copp_idx)
>> +{
>> +	struct copp *c;
>> +
>> +	spin_lock(&adm->copps_list_lock);
>> +	list_for_each_entry(c, &adm->copps_list, node) {
>> +		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx)) {
>> +			spin_unlock(&adm->copps_list_lock);
>> +			return c;
>> +		}
>> +	}
>> +
>> +	spin_unlock(&adm->copps_list_lock);
> 
> We've again got this use of spinlocks here but no IRQ safety - what
> exactly is going on with the locking?  In general all of the locking in
> this stuff is raising very serious alarm bells with me, I don't
> understand what is being protected against what and there's some very
> obvious bugs.  We could probably use some documentation about what the
> locking is supposed to be doing.
> 
I agree, there are locking issues here, Am revisiting them all before I 
send a next version.

>> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {
> 
>> +		copp->id = open->copp_id;
>> +		wake_up(&copp->wait);
>> +	}
>> +	break;
>> +	default:
> 
> This indentation is confusing.
> 
I agree, will fix such instances in next version.

thanks,
srini
