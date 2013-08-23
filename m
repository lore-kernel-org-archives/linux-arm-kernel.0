From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Aug 2013 16:41:29 +0200
Subject: [PATCH v2 1/4] clk: add common __clk_get(),
 __clk_put()	implementations
In-Reply-To: <20130820203034.GC17845@n2100.arm.linux.org.uk>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-2-git-send-email-s.nawrocki@samsung.com>
 <20130820203034.GC17845@n2100.arm.linux.org.uk>
Message-ID: <52177499.4020703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 10:30 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 20, 2013 at 07:34:20PM +0200, Sylwester Nawrocki wrote:
>> +int __clk_get(struct clk *clk)
>> +{
>> +	if (WARN_ON((!clk)))
>> +		return 0;
> 
> This changes the behaviour of clk_get()

My bad, will remove that.

>> +
>> +	if (!try_module_get(clk->owner))
>> +		return 0;
> 
> If you want this to be safe against NULL pointers, just do this:
> 
> 	if (clk && !try_module_get(clk->owner))
> 		return 0;

Ok, that should work too.

>> +
>> +	return 1;
>> +}
>> +EXPORT_SYMBOL(__clk_get);
>> +
>> +void __clk_put(struct clk *clk)
>> +{
>> +	if (!clk || IS_ERR(clk))
>> +		return;
>> +
>> +	module_put(clk->owner);
> 
> Calling clk_put() with an error-pointer should be a Bad Thing and something
> that shouldn't be encouraged, so trapping it is probably unwise.  So, just
> do here:
> 
> 	if (clk)
> 		module_put(clk->owner);
> 
> If we do have some callers of this with ERR pointers, then we could add:
> 
> 	if (WARN_ON_ONCE(IS_ERR(clk)))
> 		return;
> 
> and remove it after a full kernel cycle or so.

I wouldn't be surprised to see some callers with ERR pointers, since
clk_put() has been mostly a no op. I'm inclined to leave such a check
temporarily, let's see if it catches any issues.

Thanks for review of the other patches.
