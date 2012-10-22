From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 22 Oct 2012 22:32:45 +0800
Subject: [PATCH v4] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <1350911721-3184-1-git-send-email-linus.walleij@stericsson.com>
References: <1350911721-3184-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121022143244.GA2180@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 03:15:21PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> It has been brought to my knowledge that the .setup()/.stop()
> function pair in the SMP TWD is going to be called from atomic
> contexts for CPUs coming and going, and then the
> clk_prepare()/clk_unprepare() calls cannot be called
> on subsequent .setup()/.stop() iterations. This is however
> just the tip of an iceberg as the function pair is not
> designed to be reentrant at all.
> 
> This change makes the SMP_TWD clock .setup()/.stop() pair reentrant
> by splitting the .setup() function in three parts:
> 
> - One COMMON part that is executed the first time the first CPU
>   in the TWD cluster is initialized. This will fetch the TWD
>   clk for the cluster and prepare+enable it. If no clk is
>   available it will calibrate the rate instead.
> 
> - One part that is executed the FIRST TIME a certain CPU is
>   brought on-line. This initializes and sets up the clock event
>   for a certain CPU.
> 
> - One part that is executed on every subsequent .setup() call.
>   This will re-initialize the clock event. This is augmented
>   to call the clk_enable()/clk_disable() pair properly.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Reported-by: Peter Chen <peter.chen@freescale.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Shawn Guo <shawn.guo@linaro.org>
