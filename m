From: rob.jones@codethink.co.uk (Rob Jones)
Date: Wed, 09 Jul 2014 13:48:29 +0100
Subject: [PATCH 1/5] gpiolib: devres: Introduce the function
 devm_request_gpio_array
In-Reply-To: <alpine.DEB.2.10.1407091351530.2375@hadrien>
References: <cover.1404665589.git.himangi774@gmail.com>
 <1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com>
 <53BD2509.6070803@codethink.co.uk>
 <alpine.DEB.2.10.1407091351530.2375@hadrien>
Message-ID: <53BD3A1D.8060401@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/07/14 12:52, Julia Lawall wrote:
>
>
> On Wed, 9 Jul 2014, Rob Jones wrote:
>
>> Please note that I submitted a patch on 02/07/14 to create this
>> function which was acked by Linus Walleij on 05/07/14.
>>
>> Great minds think alike, and all that.
>>
>> However, I think that the version I submitted better replicates the
>> original (non devm) functionality, see below.

<snip>

>>> +int devm_gpio_request_array(struct device *dev, const struct gpio *array,
>>> +			    size_t num)
>>> +{
>>> +	int i, err;
>>> +
>>> +	for (i = 0; i < num; i++, array++) {
>>> +		err = devm_gpio_request_one(dev, array->gpio, array->flags,
>>> +					    array->label);
>>> +		if (err)
>>> +			return err;
>>
>> The failure path in the version I submitted frees up any already
>> allocated gpios on the first failure.
>
> Himangi first proposed doing that, but I thought it was not really in the
> spirit of devm functions, which is to leave that implicit.  No strong
> opinion on the matter, though.
>

Interestingly, we came at it from the other direction: I originally
didn't have the unwind in and our internal review guys suggested that
it was in the original function so putting it in would:

1. make this a better analogue of the original
2. help avoid deadlocks
3. allow the driver to retry, perhaps requesting reduced functionality.

> julia
>

<snip>

-- 
Rob Jones
Codethink Ltd
mailto:rob.jones at codethink.co.uk
tel:+44 161 236 5575
