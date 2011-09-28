From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 28 Sep 2011 16:26:46 +0530
Subject: [PATCH 8/9] regulator: helper to extract regulator node based
	on supply name
In-Reply-To: <20110927185913.GU4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-9-git-send-email-rnayak@ti.com>
	<20110927122155.GE4289@opensource.wolfsonmicro.com>
	<4E81E281.505@ti.com>
	<20110927185913.GU4289@opensource.wolfsonmicro.com>
Message-ID: <4E82FD6E.6030606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011 12:29 AM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 08:19:37PM +0530, Rajendra Nayak wrote:
>> On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
>>> On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:
>
>>>> +	if (!dev)
>>>> +		return NULL;
>
>>> So how do we handle CPUs?  cpufreq is one of the most active users of
>>> regulators...
>
>> Hmm, never thought of it :(
>> Maybe I should associate a supply name with all
>> regulators and then lookup from the global registered
>> list.
>
> I'm not sure how this should work in a device tree world, I'd *hope*
> we'd get a device tree node for the CPU and could then just make this a
> regular consumer thing but then the cpufreq drivers would need to be
> updated to make use of it.  The only reason we allow null devices right
> now is the fact that cpufreq doesn't have a struct device it can use.
>
>>>> +	snprintf(prop_name, 32, "%s-supply", supply);
>>>> +
>>>> +	prop = of_get_property(dev->of_node, prop_name,&sz);
>>>> +	if (!prop || sz<   4)
>>>> +		return NULL;
>
>>> sz<   4?  Magic!  :)
>
>> Its the valid phandle size.
>> I guess I need a sz != 4
>
> I think we need an of_get_phandle(), it'd be clearer what the check is,
> more type safe and would avoid needing to replicate the check.

Yes, there already seems to be one, of_parse_phandle() which I should
have used. thanks.
