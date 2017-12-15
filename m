From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 16:35:25 -0600
Subject: [PATCH 04/10] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <1513081897-31612-5-git-send-email-ilialin@codeaurora.org>
References: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
 <1513081897-31612-5-git-send-email-ilialin@codeaurora.org>
Message-ID: <20171215223525.tzcycllxsl72hway@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 02:31:31PM +0200, Ilia Lin wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> Each of the CPU clusters (Power and Perf) on msm8996 are
> clocked via 2 PLLs, a primary and alternate. There are also
> 2 Mux'es, a primary and secondary all connected together
> as shown below
> 
>                              +-------+
>               XO             |       |
>           +------------------>0      |
>                              |       |
>                    PLL/2     | SMUX  +----+
>                      +------->1      |    |
>                      |       |       |    |
>                      |       +-------+    |    +-------+
>                      |                    +---->0      |
>                      |                         |       |
> +---------------+    |             +----------->1      | CPU clk
> |Primary PLL    +----+ PLL_EARLY   |           |       +------>
> |               +------+-----------+    +------>2 PMUX |
> +---------------+      |                |      |       |
>                        |   +------+     |   +-->3      |
>                        +--^+  ACD +-----+   |  +-------+
> +---------------+          +------+         |
> |Alt PLL        |                           |
> |               +---------------------------+
> +---------------+         PLL_EARLY
> 
> The primary PLL is what drives the CPU clk, except for times
> when we are reprogramming the PLL itself (for rate changes) when
> we temporarily switch to an alternate PLL. A subsequent patch adds
> support to switch between primary and alternate PLL during rate
> changes.
> 
> The primary PLL operates on a single VCO range, between 600Mhz
> and 3Ghz. However the CPUs do support OPPs with frequencies
> between 300Mhz and 600Mhz. In order to support running the CPUs
> at those frequencies we end up having to lock the PLL at twice
> the rate and drive the CPU clk via the PLL/2 output and SMUX.
> 
> So for frequencies above 600Mhz we follow the following path
>  Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
> and for frequencies between 300Mhz and 600Mhz we follow
>  Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk
> Support for this is added in a subsequent patch as well.
> 
> ACD stands for Adaptive Clock Distribution and is used to
> detect voltage droops. We do not add support for ACD as yet.
> This can be added at a later point as needed.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +

If you respin, please make bindings a separate patch. In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/clk/qcom/Kconfig                           |   8 +
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/clk-cpu-8996.c                    | 388 +++++++++++++++++++++
>  4 files changed, 414 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
>  create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
