From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 11 Jan 2011 12:11:29 +0800
Subject: Locking in the clk API
In-Reply-To: <20110111031552.GJ3760@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
Message-ID: <201101111211.30172.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> This looks like a complete disaster, and is also completely inconsistent
> with how the API is being used by the vast majority of users today.

I've been basing this on the mxc clock code, which acquires a mutex for all 
clk_enable()s. This may not be representative of the majority of clock usage.

>From a quick search there are a few other cases of non-atomic clock usage:

tcc:		clk_enable() acquires a global clocks_mutex
tegra:	has a clk_enable_cansleep()
davinci: clk_set_parent() aquires a global clocks_mutex

Excluding the davinci code (we won't worry about set_parent for now...), if we 
can port mxc and tcc to a sleepable clk_enable, perhaps we could just go with 
purely atomic operations.

We'd still need some method of using sleeping clocks though. How about making 
clk_enable() BUG if the clock is not atomic, and add clk_enable_cansleep() for 
the cases where clk->ops.enable may sleep.

Do we need something similar for other parts of the API? (clk_set_rate?)

Cheers,


Jeremy
