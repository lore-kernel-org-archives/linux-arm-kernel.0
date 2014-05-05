From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 05 May 2014 15:50:13 -0700
Subject: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
In-Reply-To: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20140505225013.5739.23946@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ben Dooks (2014-04-15 09:06:34)
> With the addition of clock-indices, we need to change the renesas
> clock implementation to use these instead of the local definition
> of "renesas,clock-indices".
> 
> Since this will break booting with older device trees, we add a
> simple auto-detection of which properties are present.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I'm fine to take this into clk-fixes, destined for 3.15-rc5. Does that
solve the issues on your end? Do you still need me to host a stable
topic branch for you? I'm happy to do that if needed.

Regards,
Mike

> ---
>  .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt        | 2 +-
>  drivers/clk/shmobile/clk-mstp.c                                  | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 5992dce..02a25d9 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -43,7 +43,7 @@ Example
>                 clock-output-names =
>                         "tpu0", "mmcif1", "sdhi3", "sdhi2",
>                          "sdhi1", "sdhi0", "mmcif0";
> -               renesas,clock-indices = <
> +               clock-indices = <
>                         R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
>                         R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
>                         R8A7790_CLK_MMCIF0
> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index 2e5810c..1f6324e 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -156,6 +156,7 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
>  static void __init cpg_mstp_clocks_init(struct device_node *np)
>  {
>         struct mstp_clock_group *group;
> +       const char *idxname;
>         struct clk **clks;
>         unsigned int i;
>  
> @@ -184,6 +185,11 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>         for (i = 0; i < MSTP_MAX_CLOCKS; ++i)
>                 clks[i] = ERR_PTR(-ENOENT);
>  
> +       if (of_find_property(np, "clock-indices", &i))
> +               idxname = "clock-indices";
> +       else
> +               idxname = "renesas,clock-indices";
> +
>         for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
>                 const char *parent_name;
>                 const char *name;
> @@ -197,8 +203,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>                         continue;
>  
>                 parent_name = of_clk_get_parent_name(np, i);
> -               ret = of_property_read_u32_index(np, "renesas,clock-indices", i,
> -                                                &clkidx);
> +               ret = of_property_read_u32_index(np, idxname, i, &clkidx);
>                 if (parent_name == NULL || ret < 0)
>                         break;
>  
> -- 
> 1.9.1
> 
