From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 May 2012 21:42:45 +0200
Subject: [PATCH] clk: Fix race conditions between clk_set_parent() and
 clk_enable()
In-Reply-To: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
Message-ID: <20120515194245.GO30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravana,

On Fri, May 11, 2012 at 09:59:56PM -0700, Saravana Kannan wrote:
> Without this patch, the following race conditions are possible.
> 
> Race condition 1:
> * clk-A has two parents - clk-X and clk-Y.
> * All three are disabled and clk-X is current parent.
> * Thread A: clk_set_parent(clk-A, clk-Y).
> * Thread A: <snip execution flow>
> * Thread A: Grabs enable lock.
> * Thread A: Sees enable count of clk-A is 0, so doesn't enable clk-Y.
> * Thread A: Releases enable lock.
> * Thread B: Calls clk_enable(clk-A), which in turn enables clk-X.
> * Thread A: Switches clk-A's parent to clk-Y in hardware.
> 
> clk-A is now enabled in software, but not clocking in hardware.
> 
> Race condition 2:
> * clk-A has two parents - clk-X and clk-Y.
> * All three are disabled and clk-X is current parent.
> * Thread A: clk_set_parent(clk-A, clk-Y).
> * Thread A: <snip execution flow>
> * Thread A: Switches parent in hardware to clk-Y.
> * Thread A: Grabs enable lock.
> * Thread A: Sees enable count of clk-A is 0, so doesn't disable clk-X.
> * Thread A: Releases enable lock.
> * Thread B: Calls clk_enable(clk-A)
> * Thread B: Software state still says parent is clk-X.
> * Thread B: So, enables clk-X and then itself.
> * Thread A: Updates parent in software state to clk-Y.

Had a look at this and I can follow your reasoning and you patch seems
to fix this. However, there is a problem,

>  
>  	/* migrate prepare and enable */
> @@ -1092,23 +1098,23 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
>  
>  	/* FIXME replace with clk_is_enabled(clk) someday */
>  	spin_lock_irqsave(&enable_lock, flags);
> +
>  	if (clk->enable_count)
>  		__clk_enable(parent);
> -	spin_unlock_irqrestore(&enable_lock, flags);
>  
>  	/* change clock input source */
>  	ret = clk->ops->set_parent(clk->hw, i);

You call ->set_parent while holding a spinlock. This won't work with i2c
clocks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
