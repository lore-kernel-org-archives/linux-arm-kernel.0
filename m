From: robherring2@gmail.com (Rob Herring)
Date: Tue, 01 Feb 2011 16:42:34 -0600
Subject: [RFC PATCH 3/5] of: add clock providers
In-Reply-To: <20110126044416.16410.68942.stgit@localhost6.localdomain6>
References: <20110126043338.16410.75019.stgit@localhost6.localdomain6>
	<20110126044416.16410.68942.stgit@localhost6.localdomain6>
Message-ID: <4D488C5A.7020107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On 01/25/2011 10:44 PM, Grant Likely wrote:
> +struct clk *of_clk_get(struct device *dev, const char *id)

It would help if this took a struct device_node rather than struct 
device. This would allow using of_clk_get directly for cases where you 
don't have a struct device. This is fairly common in core platform core 
which are not full drivers. The case I have run into is the timer init 
code. To make clk_get work, I would have to create a dummy struct device.

Alternatively, an of_clk_get_sys function is needed.

 > +{
> +	struct device_node *provnode;
> +	u32 provhandle;
> +	int sz;
> +	struct clk *clk;
> +	char prop_name[32]; /* 32 is max size of property name */
> +	const void *prop;
> +
> +	dev_dbg(dev, "Looking up %s-clock from device tree\n", id);
> +
> +	snprintf(prop_name, 32, "%s-clock", id ? id : "bus");

Many times a module just has 1 clock and id will be NULL. Is "bus-clock" 
really the best choice of name? A bus clock may exist, but be 
transparent to s/w. How about allowing "clock" or "%s-clock"?

If bus-clock is the default, then you should add this to the clock 
binding wiki page.

Rob
