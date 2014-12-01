From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Dec 2014 22:50:57 +0000
Subject: [PATCH] ARM: rockchip: Convert resume code to C
In-Reply-To: <1417461694-5129-1-git-send-email-dianders@chromium.org>
References: <1417461694-5129-1-git-send-email-dianders@chromium.org>
Message-ID: <20141201225057.GA11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 11:21:34AM -0800, Doug Anderson wrote:
> We convert the existing assembly resume code into C as proof that this
> works and to prepare for linking in SDRAM reinit code.

...

> base my patch atop them.  Why?
                            ^^^^

That's a very good question...

> +static void __noreturn rk3288_resume_c(void)
> +{
> +	if (rk3288_resume_params.l2ctlr_f)
> +		asm("mcr p15, 1, %0, c9, c0, 2" : :
> +			"r" (rk3288_resume_params.l2ctlr));

Assembly...

> +static void __naked __noreturn rk3288_resume(void)
> +{
> +	/* Make sure we're on CPU0, no IRQs and get a stack setup */
> +	asm volatile (
> +			"msr	cpsr_cxf, %0\n"
> +
> +			/* Only cpu0 continues to run, the others halt here */
> +			"mrc	p15, 0, r1, c0, c0, 5\n"
> +			"and	r1, r1, #0xf\n"
> +			"cmp	r1, #0\n"
> +			"beq	cpu0run\n"
> +		"secondary_loop:\n"
> +			"wfe\n"
> +			"b	secondary_loop\n"
> +
> +		"cpu0run:\n"
> +			"mov	sp, %1\n"
> +		:
> +		: "i" (INIT_CPSR), "r" (&__stack_start)
> +		: "cc", "r1", "sp");

Big load of assembly.

What I see here is a load of complexity which achieves very little.
The result doesn't get rid of much assembly, but it does make stuff
more complicated.  And the diffstat speaks volumes about this:

 10 files changed, 275 insertions(+), 94 deletions(-)                           

There's a lot of words in the description, but it's missing the most
important bit: why do we want to take this approach - what benefits
does it bring?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
