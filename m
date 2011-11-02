From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 19:45:55 +0000
Subject: [RFC PATCH 02/34] msm: clock: Always use an array to iterate
	over clocks
In-Reply-To: <1320258991-22325-3-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
	<1320258991-22325-3-git-send-email-davidb@codeaurora.org>
Message-ID: <20111102194555.GE12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 11:35:59AM -0700, David Brown wrote:
> If the array of clk_lookups contains aliases for the same struct
> clk, msm_clock_init() will add the clock to the clocks list
> twice.  This would cause list corruption so let's just remove the
> clocks list and any associated code and iterate over the array
> instead.

Hmm...

> @@ -158,13 +152,13 @@ void __init msm_clock_init(struct clk_lookup *clock_tbl, unsigned num_clocks)
>   */
>  static int __init clock_late_init(void)
>  {
> +	unsigned i, count = 0;
>  	unsigned long flags;
> -	struct clk *clk;
> -	unsigned count = 0;
>  
>  	clock_debug_init();
> -	mutex_lock(&clocks_mutex);
> -	list_for_each_entry(clk, &clocks, list) {
> +	for (i = 0; i < msm_num_clocks; i++) {
> +		struct clk *clk = msm_clocks[i].clk;
> +
>  		clock_debug_add(clk);

This means you'll end up calling clock_debug_add() twice for the same
struct clk - this sounds like a bad idea in itself.  It looks like
there's no protection within that function against it being called
twice with the same struct clk.

Are you sure this is safe?
