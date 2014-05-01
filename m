From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 02 May 2014 00:16:06 +0400
Subject: [PATCH] vexpress: Initialise the sysregs before setting up the
 clocks
In-Reply-To: <1398953107-29426-1-git-send-email-catalin.marinas@arm.com>
References: <1398953107-29426-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <5362AB86.2030902@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/01/2014 06:05 PM, Catalin Marinas wrote:

> Following arm64 commit bc3ee18a7a57 (arm64: init: Move of_clk_init to
> time_init()), vexpress_osc_of_setup() is called via of_clk_init() long
> before initcalls are issued. Initialising the vexpress oscillators
> requires the vespress sysregs to be already initialised, so this patch
> adds an explicit call to vexpress_sysreg_of_early_init() in vexpress
> oscillator setup function. In addition, vexpress_sysreg_init() is
> changed to a device_initcall() as the core_initcall() is no longer
> required.

    I don't see that last change in this patch...

> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Pawel Moll <pawel.moll@arm.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> ---

> Mike, I'd like to get this in for 3.15 and I'm happy to push it via the arm64
> tree. Are you ok with this? Thanks.

>   drivers/clk/versatile/clk-vexpress-osc.c | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> index a535c7bf8574..422391242b39 100644
> --- a/drivers/clk/versatile/clk-vexpress-osc.c
> +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> @@ -100,6 +100,8 @@ void __init vexpress_osc_of_setup(struct device_node *node)
>   	struct clk *clk;
>   	u32 range[2];
>
> +	vexpress_sysreg_of_early_init();
> +
>   	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
>   	if (!osc)
>   		return;

WBR, Sergei
