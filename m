From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Feb 2015 11:04:39 +0000
Subject: [PATCH 1/2] regmap: Add range check in _regmap_raw_read()
In-Reply-To: <20150219102750.GC3198@finisterre.sirena.org.uk>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150219102750.GC3198@finisterre.sirena.org.uk>
Message-ID: <54E5C347.9070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/02/15 10:27, Mark Brown wrote:
> On Thu, Feb 19, 2015 at 08:40:39AM +0000, Srinivas Kandagatla wrote:
>
>> +	/* Check for readable registers before we start */
>> +	for (i = 0; i < count; i++)
>> +		if (!regmap_readable(map, reg + (i * map->reg_stride)))
>> +			return -EINVAL;
>
> That's starting to look pretty expensive especially if what we're
> looking for is just max_register really...  This is one of the reasons
Yes, I totally agree, this call would be expensive.

Initially I had some thing like this, and it works for me.

+       if (map->max_register &&
+                       (reg > map->max_register ||
+                       ((reg + (count - 1) * map->reg_stride)  > 
map->max_register)))
+               return -EINVAL;


> we're not religious about checking for readability everywhere, and
> obviously even if we avoid triggering this particular thing we still
> have to cope with both the caller and devices that didn't specify
> readability.  A cheaper check for just max_register would be less
> concerning but it feels like we're trying to paper over a symptom with
> this rather than fix a problem.
Yes, just checking max_register would solve the issue for me, I think I 
over done the patch.. I will resend with just max_register check.


>
