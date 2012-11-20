From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 13:38:42 -0700
Subject: [PATCH V3 1/2] clocksource: add common of_clksrc_init() function
In-Reply-To: <20121120201026.GF6280@kryptos>
References: <1353439206-1654-1-git-send-email-swarren@wwwdotorg.org>
 <20121120201026.GF6280@kryptos>
Message-ID: <50ABEA52.6070405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 01:10 PM, Josh Cartwright wrote:
> On Tue, Nov 20, 2012 at 12:20:05PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> It is desirable to move all clocksource drivers to drivers/clocksource,
>> yet each requires its own initialization function. We'd rather not
>> pollute <linux/> with a header for each function. Instead, create a
>> single of_clksrc_init() function which will determine which clocksource
>> driver to initialize based on device tree.
>>
>> Inspired by a similar patch for drivers/irqchip by Thomas Petazzoni.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> v3: Use a linker section to replace manually maintained table.
>> v2: New patch.
>>
> [..]
>> --- /dev/null
>> +++ b/drivers/clocksource/clksrc-of.c

>> +void __init clocksource_of_init(void)
...
>> +	for ( ; table < stop; table++) {
>> +		for_each_matching_node(np, *table) {
>> +			match = of_match_node(*table, np);
>> +			init_func = match->data;
>> +			init_func();
> 
> Hmm.  Am I crazy, or does this for_each_matching_node()/of_match_node()
> pattern end up walking the match table twice, unnecessarily?

Yes, that's true.

> I'm wondering if we can come up with a for_each_matching_node_id() macro
> that also provides a pointer to the matching of_device_id...

Good idea; I'll do that.
