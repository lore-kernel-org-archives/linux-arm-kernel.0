From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 14:55:37 +0530
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
In-Reply-To: <20120413085627.GD27730@b20223-02.ap.freescale.net>
References: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
 <20120413085627.GD27730@b20223-02.ap.freescale.net>
Message-ID: <4F87F111.6060400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added you question from both threads here :) ]

On 4/13/2012 2:47 PM, Richard Zhao wrote:
> On Fri, Apr 13, 2012 at 02:40:12PM +0530, Viresh Kumar wrote:
>> On 4/13/2012 2:29 PM, Mark Brown wrote:
>>> Or we need to dump the arguments into a struct.
>>
>> Then we would end up creating too many structures in our mach/clock.c
>> files. That will look bad. May perform better. :)
> or pass struct clk_lookup* ? For non-leaf clks, it's NULL.

Non leaf nodes may also need to have clk_lookups, if you want to do
clk_get*() on them, to set their rate or parents.

On 4/13/2012 2:26 PM, Richard Zhao wrote:
>> >  struct clk *clk_register(struct device *dev, const char *name,
>> >  		const struct clk_ops *ops, struct clk_hw *hw,
>> > -		const char **parent_names, u8 num_parents, unsigned long flags)
>> > +		const char **parent_names, u8 num_parents, unsigned long flags,
>> > +		struct clk_lookup **cl, const char *dev_id, const char *con_id)
> 10 arguments. It worths to use a struct ? 

I am not saying no here.

But, with that we pass structs all clk_register_*() routines too. So, we will
create a lot of structures in our mach clock.c file.

Because in most cases this is one time stuff, only at boot, i vote for the
current implementation. :)

I am not an expert but, with my logic i feel with more args system will not
be slower. Performance wise, both should be same. As all args would always be
read from memory and not registers. In case of struct, only address of struct
will be read from cpu registers.

-- 
viresh
