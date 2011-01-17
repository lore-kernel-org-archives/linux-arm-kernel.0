From: charu@ti.com (Varadarajan, Charulatha)
Date: Mon, 17 Jan 2011 13:37:41 +0530
Subject: [PATCH 7/7] arm: omap2: clksel: fix compile warning
In-Reply-To: <1295238680-26738-8-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
	<1295238680-26738-8-git-send-email-balbi@ti.com>
Message-ID: <AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 10:01, Felipe Balbi <balbi@ti.com> wrote:
> Fix the following compile warning:
> arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval':
> arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
> used uninitialized in this function
>
> While at that, also add a check to avoid using max_clkr while NULL.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> ?arch/arm/mach-omap2/clkt_clksel.c | ? ?5 ++++-
> ?1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
> index a781cd6..baf0b6b 100644
> --- a/arch/arm/mach-omap2/clkt_clksel.c
> +++ b/arch/arm/mach-omap2/clkt_clksel.c
> @@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?u32 *field_val)
> ?{
> ? ? ? ?const struct clksel *clks;
> - ? ? ? const struct clksel_rate *clkr, *max_clkr;
> + ? ? ? const struct clksel_rate *clkr, *max_clkr = NULL;
> ? ? ? ?u8 max_div = 0;
>
> ? ? ? ?clks = _get_clksel_by_parent(clk, src_clk);
> @@ -123,6 +123,9 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
>
> + ? ? ? if (!max_clkr)
> + ? ? ? ? ? ? ? return 0;

Would it be more appropriate to move this check after the "if" check
of max_div==0 and it's warning?
or add a warning before it returns?

> +
> ? ? ? ?if (max_div == 0) {
> ? ? ? ? ? ? ? ?/* This indicates an error in the clksel data */
> ? ? ? ? ? ? ? ?WARN(1, "clock: Could not find divisor for clock %s parent %s"
> --
> 1.7.3.4.598.g85356
>
