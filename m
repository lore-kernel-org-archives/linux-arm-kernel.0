From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Dec 2011 22:38:26 +0100
Subject: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
In-Reply-To: <CAJOA=zP1CAsCqJERvXC6tTh_gs_boGYnO3MUC5=Vgiiw=0Vs_w@mail.gmail.com>
References: <20111212194757.GB12131@lunn.ch>
 <CAJOA=zP1CAsCqJERvXC6tTh_gs_boGYnO3MUC5=Vgiiw=0Vs_w@mail.gmail.com>
Message-ID: <20111212213826.GH13600@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I don't like this approach.  If the bool for a particular clk is
> statically defined then it could be wrong (bootloader/kernel
> mismatch).
> 
> I've been thinking of adding a clk->ops->init callback in clk_init,
> which is defined for a platform to use however the author sees fit.
> There have been a few cases where it would be nice to "init" a clk
> only once, when it is registered.  That code could also handle
> detecting if a clk is enabled or not.
> 
> On the other hand we already have a .get_parent callback which is only
> good for figuring out which parent a mux clk is using... maybe a
> .is_enabled or .get_enabled would be a good idea which also served the
> purpose of dynamically determining whether a clk is disabled or
> running.
> 
> In general though I think we should try to keep the solution in the
> core code, not by having platform code pass in a bool.

Hi Mike

How about simply reading the bit in the control register? You are
already doing a read/modify/write when enabling/disabling the clock,
so it seems reasonably safe to assume the read gives you the current
state. For those platforms which this does not work, you could add
another flag disabling this read to get the initial state.

	Andrew
