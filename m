From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 25 Oct 2011 00:56:53 +0200
Subject: [PATCH] of: Add a reg-names property to name reg entries
In-Reply-To: <20111024221916.GF4394@ponder.secretlab.ca>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
	<20111024221916.GF4394@ponder.secretlab.ca>
Message-ID: <4EA5ED35.7000806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2011 12:19 AM, Grant Likely wrote:
> On Mon, Oct 24, 2011 at 05:54:57PM +0200, Benoit Cousson wrote:

[...]

>> @@ -551,7 +551,11 @@ static int __of_address_to_resource(struct device_node *dev,
>>   		r->end = taddr + size - 1;
>>   	}
>>   	r->flags = flags;
>> -	r->name = dev->full_name;
>> +	if (name)
>> +		r->name = name;
>> +	else
>> +		r->name = dev->full_name;
>
> This form please:
> 	r->name = name ? name : dev->full_name;

Much better, indeed.

> In general, I'm inclined to accept this patch as we talked about at
> plumbers.  However, this particular hunk gives me pause as there is
> still the objection that Russell raised about the (ab)use of r->name
> for insert the resource name.
>
> So, no I won't reject this patch, but I first what to have some idea
> of what the plan is to migrate away from using r->name.  Perhaps we
> can talk about this tomorrow.

OK, sure, let's discuss about that.
But I still think that Russell's concern is not related at all with this 
patch. That means that it should be fixed separately if needed. It can 
be done before or after, but this is somehow orthogonal to the DT 
reg-names support problem.

>>   	return 0;
>>   }
>>
>> @@ -569,11 +573,19 @@ int of_address_to_resource(struct device_node *dev, int index,
>>   	const __be32	*addrp;
>>   	u64		size;
>>   	unsigned int	flags;
>> +	const char	*name = NULL;
>> +	int		name_cnt;
>>
>>   	addrp = of_get_address(dev, index,&size,&flags);
>>   	if (addrp == NULL)
>>   		return -EINVAL;
>> -	return __of_address_to_resource(dev, addrp, size, flags, r);
>> +
>> +	/* Get "reg-names" property to add a name to a resource */
>> +	name_cnt = of_property_count_strings(dev, "reg-names");
>> +	if (name_cnt>  0)
>> +		of_property_read_string_index(dev, "reg-names",	index,&name);
>
> Why not simply:
> 	of_property_read_string_index(dev, "reg-names", index,&name);
>
> If it fails, then name remains NULL and everything works.

Good point, that API is already taking care of that.

Thanks,
Benoit
