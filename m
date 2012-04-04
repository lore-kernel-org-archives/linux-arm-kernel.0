From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Apr 2012 09:22:58 -0600 (MDT)
Subject: [PATCH] OMAP: clock: fix race in disable all clocks
In-Reply-To: <1331835871-13328-1-git-send-email-nm@ti.com>
References: <1331835871-13328-1-git-send-email-nm@ti.com>
Message-ID: <alpine.DEB.2.00.1204040922140.8000@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc Todd

On Thu, 15 Mar 2012, Nishanth Menon wrote:

> clk_disable_unused is invoked when CONFIG_OMAP_RESET_CLOCKS=y.
> Since clk_disable_unused is called as lateinitcall, there can
> be more than a few workqueues executing off secondary CPU(s).
> The current code does the following:
> a) checks if clk is unused
> b) holds lock
> c) disables clk
> d) unlocks
> 
> Between (a) and (b) being executed on CPU0, It is possible to
> have a driver executing on CPU1 which could do a get_sync->clk_get
> (and increase the use_count) of the clock which was just about
> to be disabled by clk_disable_unused.
> 
> We ensure instead that the entire list traversal is protected by
> the lock allowing for parent child clock traversal which could be
> potentially be done by runtime operations to be safe as well.
> 
> Reported-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> To confirm this in reality happens, I setup a trap as follows:
>   @@ -450,6 +450,8 @@ static int __init clk_disable_unused(void)
>   			continue;
>   
>   		spin_lock_irqsave(&clockfw_lock, flags);
>  +		WARN(ck->usecount, "XXXX->RACECONDITION FOR CLOCK %s\n",
>  +			ck->name);
>   		arch_clock->clk_disable_unused(ck);
>   		spin_unlock_irqrestore(&clockfw_lock, flags);
>   	}
> Resultant log: http://pastebin.pandaboard.org/index.php/view/66400792

Thanks Nishanth & Todd, queued for 3.4-rc.


- Paul
