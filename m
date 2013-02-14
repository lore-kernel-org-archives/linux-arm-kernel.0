From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 14 Feb 2013 17:17:05 +1300
Subject: of_clk_get() / devm_clk_get()
Message-ID: <1360815425.21991.20.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have devm_clk_get() which gives a managed-resource clk (by
name), or of_clk_get() which gives an unmanaged resource clk (by id).

I just wanted to sound out everyone as to whether there is a need for a
managed version of the of_clk_get.

My personal concern about devm_clk_get is that it requires (if I
understand correctly) that the DT node have the clock-names property
(which is optional). If the optional name is not supplied, it fails.
This basically makes it 'not optional' when a driver uses devm_clk_get.
(Please correct me if I'm wrong about this).

Everything below here is irrelevant if the above is wrong :)


If the above IS correct, then couldn't we have a devm_of_clk_get which
accepts a *id (as per devm_clk_get) AND an index (as per of_clk_get),
with the *id given priority.

Something along the lines of...

struct clk *devm_of_clk_get(struct device *dev,
			    const char *id,
			    int index)
{
	struct clk **ptr, *clk = NULL;

	if (id)
		clk = devm_clk_get(dev, id);

	if (!clk || IS_ERR(clk)) {
		clk = of_clk_get(dev->of_node, index);
		if (!IS_ERR(clk)) {
			ptr = devres_alloc(devm_clk_release,
					   sizeof(*ptr),
					   GFP_KERNEL)
			if (!ptr)
				return ERR_PTR(-ENOMEM);

			*ptr = clk;
			devres_add(dev, ptr);
		}
	}

	return clk;
}

This would make clock-names optional (as intended) and give a fallback
to the index when clock-names isn't specified.

One issue (which I don't know how much of an issue it is) is that this
doesn't follow the normal pattern of normal_func -> devm_func parameter
layout.


Regards
Tony Prisk
