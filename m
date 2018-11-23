From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 23 Nov 2018 15:06:53 +0100
Subject: [PATCH v2 2/4] clk: meson: clk-regmap: add read-only gate ops
In-Reply-To: <20181122214017.25643-3-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
 <20181122214017.25643-3-martin.blumenstingl@googlemail.com>
Message-ID: <46911a32-43bc-4fd8-b4bd-92fe934cecf8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/2018 22:40, Martin Blumenstingl wrote:
> Some of the gate clocks are described as "just in case" bits in the
> datasheet. Examples are the ABP, PERIPH, AXI and L2 DRAM clocks on
> Meson8b.
> The datasheet suggests that these bits are not touched. The full
> explanation is:
> "Set to 1 to manually disable the [...] clock when changing the mux
> selection. Typically this bit is set to 0 since the clock muxes can
> switch without glitches.".
> 
> This adds new read-only ops for gate clocks so we can describe these
> clocks in our clock controller drivers while ensuring that we can't
> accidentally modify the registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-regmap.c | 5 +++++
>  drivers/clk/meson/clk-regmap.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index 305ee307c003..c515f67322a3 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -50,6 +50,11 @@ const struct clk_ops clk_regmap_gate_ops = {
>  };
>  EXPORT_SYMBOL_GPL(clk_regmap_gate_ops);
>  
> +const struct clk_ops clk_regmap_gate_ro_ops = {
> +	.is_enabled = clk_regmap_gate_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_gate_ro_ops);
> +
>  static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
>  						unsigned long prate)
>  {
> diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
> index ed2d4348dbe2..e9c5728d40eb 100644
> --- a/drivers/clk/meson/clk-regmap.h
> +++ b/drivers/clk/meson/clk-regmap.h
> @@ -51,6 +51,7 @@ clk_get_regmap_gate_data(struct clk_regmap *clk)
>  }
>  
>  extern const struct clk_ops clk_regmap_gate_ops;
> +extern const struct clk_ops clk_regmap_gate_ro_ops;
>  
>  /**
>   * struct clk_regmap_div_data - regmap backed adjustable divider specific data
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
