From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jun 2010 19:49:14 +0900
Subject: [PATCH v5] ARM: S5PV210: Correct clock register properties
In-Reply-To: <1277873811-2823-1-git-send-email-myungjoo.ham@samsung.com>
References: <1277873811-2823-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <017001cb1841$e43d8910$acb89b30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
Hi MyungJoo,

Didn't check my previous reply?
Would be helpful to me if you could reply at that time about your any
problem or other opinion.

Actually, already applied your updated v4 patch.

> 1. Corrected shift values of I2S and UART clocks (CLK_GATE_IP3), which
were
> defined incorrectly.
> 
> 2. Corrected shift values of sclk_audio, uclk1, sclk_fimd, sclk_mmc,
> sclk_spi, sclk_pwm, which had duplicated .enable/.ctrlbit with their
> twins defined in struct clk init_clocks_disable[] and struct clk
> init_clocks[]. We've changed their .enable/.ctrlbit to use CLK_SRC_MASK
> register to avoid the duplicated clock problem described below.
> 
> 
> What is Duplicated Clock Problem?
> 
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
> 
> 3. Corrected other sclk_* shift values and access registers.
> 
> 
> Note that becuase UART clocks are properly disabled at boot time with
> this patch, UART drivers or somebody else should turn on the clock
> to read the console; otherwise, JIG willl not show any message.
> 
Please check my previous reply.
> 
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Note that this patch revises and merges the two previous patches:
> [PATCH] S5PV210 Correct clock register properties
> [PATCH] S5PV210 Correct clock source control register properties
> And follows the previous patch
> [PATCH v2] S5PV210 Correct clock register properties
> [PATCH v3] S5PV210 Correct clock register properties
> [PATCH v4] S5PV210 Correct clock register properties
> v5 revises comments only from v4.
>  arch/arm/mach-s5pv210/clock.c |  115
++++++++++++++++++++++-------------------
>  1 files changed, 62 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 154bca4..b3d156c 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
