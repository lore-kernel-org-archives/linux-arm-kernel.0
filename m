From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 23 Nov 2016 16:05:03 -0800
Subject: [PATCH 2/2] clk: uniphier: add clock data for cpufreq
In-Reply-To: <1477503088-26508-2-git-send-email-yamada.masahiro@socionext.com>
References: <1477503088-26508-1-git-send-email-yamada.masahiro@socionext.com>
 <1477503088-26508-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161124000503.GE6095@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27, Masahiro Yamada wrote:
> Data needed for CPU-gear change (cpufreq).
> 
> Note:
> At this moment, some clock data for Pro5/Pxs2 (32bit SoCs) are
> a bit faked because clock rates greater than LONG_MAX (~2.15 GHz)
> must be avoided on 32 bit systems.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I raised a flag in the following post:
> https://www.spinics.net/lists/kernel/msg2361374.html
> 
> I have not had any comments.
> Anyway, I am moving forward.
> I can fix the data arrays to reflect the real
> clock topology.
> 
> 
>  drivers/clk/uniphier/clk-uniphier-sys.c | 111 ++++++++++++++++++++++++++++++++
>  drivers/clk/uniphier/clk-uniphier.h     |  35 +++++++++-
>  2 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
> index 5d02999..74ab179 100644
> --- a/drivers/clk/uniphier/clk-uniphier-sys.c
> +++ b/drivers/clk/uniphier/clk-uniphier-sys.c
> @@ -41,6 +41,19 @@
>  #define UNIPHIER_PRO4_SYS_CLK_USB3(idx, ch)				\
>  	UNIPHIER_CLK_GATE("usb3" #ch, (idx), NULL, 0x2104, 16 + (ch))
>  
> +#define UNIPHIER_PRO5_SYS_CPUGEARS					\
> +	UNIPHIER_CLK_DIV8("cpll", 2, 3, 4, 6, 8, 12, 16, 24),		\
> +	UNIPHIER_CLK_DIV8("spll", 2, 3, 4, 6, 8, 12, 16, 24),		\
> +	UNIPHIER_CLK_DIV8("ippll", 2, 3, 4, 6, 8, 12, 16, 24),		\
> +	UNIPHIER_CLK_CPUGEAR("cpu-ca9", 32, 0x8000, 0x1f, 16,		\
> +			     "cpll/2", "spll/2", "cpll/3", "spll/3",	\
> +			     "cpll/4", "spll/4", "cpll/6", "spll/6",	\
> +			     "cpll/8", "spll/8", "cpll/12", "spll/12",	\
> +			     "cpll/16", "spll/16", "cpll/24", "spll/24"),\
> +	UNIPHIER_CLK_CPUGEAR("cpu-ipp", 34, 0x8100, 0xf, 8,		\
> +			     "ippll/2", "spll/2", "ippll/3", "spll/3",	\
> +			     "spll/4", "spll/8", "ippll/4", "ippll/8")
> +
>  const struct uniphier_clk_data uniphier_sld3_sys_clk_data[] = {
>  	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
>  	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
> @@ -96,6 +109,8 @@
>  };
>  
>  const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
> +	UNIPHIER_CLK_FACTOR("cpll", -1, "ref", 140, 1),		/* 2800 MHz */
> +	UNIPHIER_CLK_FACTOR("ippll", -1, "ref", 130, 1),	/* 2600 MHz */
>  	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 120, 1),		/* 2400 MHz */
>  	UNIPHIER_CLK_FACTOR("dapll1", -1, "ref", 128, 1),	/* 2560 MHz */
>  	UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),	/* 2949.12 MHz */
> @@ -106,10 +121,43 @@
>  	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
>  	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
>  	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
> +#if 1
> +	/*
> +	 * TODO:
> +	 * The return type of .round_rate() is "long", which is 32 bit wide on
> +	 * 32 bit systems.  Clock rate greater than LONG_MAX (~ 2.15 GHz) is
> +	 * treated as an error.  Needs a workaround until the problem is fixed.
> +	 */

Just curious is the problem internal to the clk framework because
of the clk_ops::round_rate design? Or does the consumer, cpufreq
in this case, have to deal with rates that are larger than
unsigned long on a 32 bit system? If it's just a clk_ops problem
and we need to support rates up to 32 bits wide (~ 4.3 GHz) on
the system then the driver could be changed to use
.determine_rate() ops and that would allow us to use all the bits
of unsigned long to figure out rates.

If the problem is rates even larger than unsigned long on 32 bit
systems, then at the least I'd like to see some sort of plan to
fix that in the framework before merging code. Hopefully it can
be done gradually, but as I start looking at it it seems more and
more complicated to support this so this will be a long term
project.

We can discuss the clk API changes needed as well if those are
required, but that is another issue that requires changes in
other places outside of clk drivers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
