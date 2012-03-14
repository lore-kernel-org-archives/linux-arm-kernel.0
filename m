From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Mar 2012 08:26:17 -0500
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <20120314075930.GF21337@S2101-09.ap.freescale.net>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
 <20120314075930.GF21337@S2101-09.ap.freescale.net>
Message-ID: <4F609C79.2060307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 02:59 AM, Shawn Guo wrote:
> On Tue, Mar 13, 2012 at 06:22:24PM -0500, Rob Herring wrote:
> ...
>> +/**
>> + * of_fixed_clk_setup() - Setup function for simple fixed rate clock
>> + */
>> +void __init of_fixed_clk_setup(struct device_node *node)
>> +{
>> +	struct clk *clk;
>> +	const char *clk_name = node->name;
>> +	u32 rate;
>> +
>> +	if (of_property_read_u32(node, "clock-frequency", &rate))
>> +		return;
>> +
>> +	of_property_read_string(node, "clock-output-names", &clk_name);
>> +
>> +	clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
>> +	if (clk)
>> +		of_clk_add_provider(node, of_fixed_clk_get, clk);
>> +}
> 
> It seems my comment[1] did not get addressed in this post.
> 
> Regards,
> Shawn
> 
> [1] http://article.gmane.org/gmane.linux.drivers.devicetree/10589

I just took Grant's commit as is.

It also only works for root fixed clocks, but the common clock allows
for non-root fixed clocks. I don't think there's much use case for that
at least as a DT clock node.

Rob
