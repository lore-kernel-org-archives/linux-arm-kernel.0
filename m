From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jun 2010 10:16:38 +0100
Subject: [PATCH v3] S5PV210 Correct clock register properties
In-Reply-To: <1277283688-4542-1-git-send-email-myungjoo.ham@samsung.com>
References: <1277283688-4542-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100623091638.GA17436@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 06:01:28PM +0900, MyungJoo Ham wrote:
> --- Duplicated Clock Problem ---
> Please note that each clock definition should access different control
> register; otherwise, the system may suffer lockups. For example, if we
> have two clock definitions "a" and "b" which access the same register
> (and the shift value). Then, when we do:
> 
> 	module A
> 	clk = clk_get("a");
> 	clk->clk_enable(clk);
> 
> 	module B (context switch)
> 	clk = clk_get("b");
> 	clk->clk_enable(clk);
> 	do something with clk.
> 	clk->clk_disable(clk);
> 
> 	module A (context switch)
> 	do something with clk
> 	* At this point, the system may hang.
> 
> Therefore, there should be no clock definitions with the same contol
> register/shift. If we need to create "aliases", then, creating child
> clocks sharing the clock should be fine.

Absolutely right, and the clk API has always allowed for this.  clk_get()
is supposed to translate a struct device + _clock_ _consumer_ _name_ to
the relevant struct clk, which may be the same struct clk which was
returned by clk_get for a completely different struct device & _clock_
_consumer_ _name_.

clkdev provides an easy way to do this by providing a tabular lookup
mechanism, which lists the device, clock consumer name and the struct
clk to return for that combination.
