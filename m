From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 16:51:31 -0600
Subject: [RFC 4/5] clk: per-user clock accounting for debug
In-Reply-To: <53ADF3C8.2060702@wwwdotorg.org>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
 <1403855872-14749-5-git-send-email-tomeu.vizoso@collabora.com>
 <53ADF3C8.2060702@wwwdotorg.org>
Message-ID: <53ADF573.8000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 04:44 PM, Stephen Warren wrote:
> On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
>> From: Rabin Vincent <rabin.vincent@stericsson.com>
>>
>> When a clock has multiple users, the WARNING on imbalance of
>> enable/disable may not show the guilty party since although they may
>> have commited the error earlier, the warning is emitted later when some
>> other user, presumably innocent, disables the clock.
>>
>> Provide per-user clock enable/disable accounting and disabler tracking
>> in order to help debug these problems.

>> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
>> index 91659b2..9657fc8 100644
>> --- a/include/linux/clk-private.h
>> +++ b/include/linux/clk-private.h
>> @@ -56,7 +56,11 @@ struct clk_core {
>>  };
>>  
>>  struct clk {
>> -	struct clk_core clk;
>> +	struct clk_core	*core;
>> +	unsigned int	enable_count;
>> +	const char	*dev_id;
>> +	const char	*con_id;
> 
> Why not just store the "struct device *" there instead of pulling the
> name out of it, so ...

Oh, perhaps I'm confused here. These are the names that are used to look
up the clock, not the name of the device that looked it up.

It might still be nice to store the "struct device *" as well as the
clock name parameters.
