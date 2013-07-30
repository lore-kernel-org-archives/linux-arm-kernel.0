From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 18:02:00 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <6809706.cRofzbG9CV@thinkpad>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <6809706.cRofzbG9CV@thinkpad>
Message-ID: <51F70278.1020002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 04:20 PM, Tomasz Figa wrote:
> On Monday 29 of July 2013 15:47:55 Stephen Warren wrote:
>> On 07/28/2013 06:21 PM, Tomasz Figa wrote:

...
>> Other content restrictions might be:
>>
>> * List must contain (at least) these entries/values.
>>
>> * List can't contain any other entries/values not specified here.
>>
>> * List must be in this order vs. any order.
>>
>> * List logical length (in entries, not bytes/cells) must match the
>> logical length of another cell (consider clocks/clock-names).
>>
>> * Ordering of one property must match ordering of another property
>> (again consider clocks/clock-names), although it'd be difficult to tell
>> whether this condition was met, perhaps we can at least document it.
>>
>> I'm sure there will be many more criteria to validate that we're
>> forgetting. This is possible the most complex area?
> 
> Right. Still, this is about the granularity of checks we really need. Do we 
> need to check for all those restrictions?

I think all/most of those bullets actually exist in various binding
documents, and I think we want any schema to be able to represent any
restrictions we already impose. So, yes, I do think we want to be able
to validate all of that.

Now, that's not saying that a system which didn't validate that, but
perhaps only validated that certain properties were present, and no
other properties were present. However, I'd still hope that such a
system was just a first step towards the complete system.

>>> As for subnodes, I think we need to define following constraints:
>>>  - node name (or node name format, e.g. regex),
>>
>> I don't think node names are supposed to convey any semantic meaning, so
>> they probably shouldn't be restricted (much?) by schema.
> 
> There are bindings currently that require specific node names. Since 
> of_match_node() can do matching by names as well, I think we should care about 
> node names too,

Hopefully we can discourage this through review though, since I've
definitely been told not to semantically interpret node names.

...
>> Equally, I'm not sure there's any difference between:
>>
>> prop = <&node>;
>> prop = <0x23648689>;
>>
>> ... in the DTB, except that the value just *happens* to match another
>> node's phandle value, which could end up leading to false positive
>> matches if only applied on the raw values not the syntax?
> 
> This is a good point. From driver's perspective it doesn't matter how you 
> specify value of some property, as long as it can be parsed using the same 
> code. As a more trivial example, consider following dts code:
> 
> 	array-prop = <0>, <1>, <2>;
> 	array-prop-2 = <0 1 2>;
> 
> Both array props contain the same data and can be parsed using the same code, 
> but from reader's perspective they mean something slightly different - an array 
> with 1 cell per element and a single entry of 3 cells.

I can certainly understand those two pieces of syntax being interpreted
that way. I've always thought of the above being 100% equivalent, even
though there may be a logical distinction. I not sure that such a
distinction is actually present in all extant DT source files. Perhaps
it's fine as part of the schema effort to re-write the DTs along these
lines though.
