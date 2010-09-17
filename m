From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 17 Sep 2010 08:24:34 +0800
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <AANLkTi=vaOzRcoGM9AnJ+17e0-97b76F5DW964fC3Wwp@mail.gmail.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<1284522014.517347.33297989274.1.gpush@pororo>
	<AANLkTi=vaOzRcoGM9AnJ+17e0-97b76F5DW964fC3Wwp@mail.gmail.com>
Message-ID: <1284683074.3350.73.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> I am not sure about the scope of your assumed task, but I would still
> like to bring
> to your notice some points.
> 
> IMHO any clock api that aims to be used by multiple platforms should be generic
> more than this one. Let me explain.

None of my patches change the clock API itself. The clock API is already
in use on ARM (ie, multiple platforms) and seems to work for most cases.

> Clocks that are simply output of MUX'es inherit the rate of the parent
> clock - they do have
> rate yet this API would return 0 (IIRUIC).

The proposed clock infrastructure does not provide implementations for
the clock operation functions (like get_rate, which you're referring to
here). The behaviour of the clocks is dictated by each implementation of
struct clk. For MUXes, the callback for clk->ops.get_rate would be
something like:

unsigned long clk_mux_get_rate(struct clk *clk)
{
	return clk_get_rate(to_clk_mux(clk)->parent);
}

- so it just returns the rate of the parent (not 0). However, if the
clock implementation has a reason to return 0, it is free to do so.

> Another scenario could have a source clock parenting more than one
> child clock via
> different MUX'es. It would be nice to be able to set rate of that
> parent clock (after ensuring
> other siblings won't complain) and have some mechanism to notify other
> siblings of the change.
> Or some better solution.

Again, these patches don't change the API itself; if we want to
implement clock-change notifications, that would best be done in a
separate discussion.

Cheers,


Jeremy
