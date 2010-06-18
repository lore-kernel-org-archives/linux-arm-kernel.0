From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Jun 2010 18:50:58 +0900
Subject: [PATCH] S5PV210 Correct clock source control register properties
In-Reply-To: <1276766116-6839-1-git-send-email-myungjoo.ham@samsung.com>
References: <1276766116-6839-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <005401cb0ecb$c3f16c00$4bd44400$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> The clock source controls (struct clksrc_clk) have been often accessing
> CLK_GATE_IPx, which are for clock gating and are accessed by each clock
> as well as the clock source. This duplicated clock issue may incur
> lockup problems when there are two modules accessing the same clock with
> different names.
> 
Could you please explain further about the above the statement " accessed by
each clock as well as the clock source"

> Besides, the clock source control is supposed to control (setting values
> of MASK, SRC, DIV), not to turn on/off individual clock.
> 
That is not quite true. Only S5PV210/S5PC110 have the gate for the clock mux.
S5P6440 and S5PC100, for instance, do not have a gate for the output for
_just_ the clock mux. And the reason why the Clock Mux Gate is provide for
the mux is explained in Section 3.4 of the user manual.

> Another point is that there are registers (CLK_SRC_MASK0/1) specialized
> for masking clock source control in S5PV210/S5PC110 according to the
> user manual (rev 20100201).
> 
> Therefore, accessing CLK_SRC_MASK0/1 (rather than accessing
> CLK_GATE_IPx) for the clock source control is safer and fits to the
> semantics of S5PV210/S5PC110 registers. And fortuneatly, each clock
> source defined in clock.c has corresponding bit at CLK_SRC_MASK0/1
> except for MFC, G2D, and G3D.
> 
Can you please explain how the use CLK_SRC_MASKx makes it safer. The reason
why MFC, G2D and G3D do not have a corresponding bit in CLK_SRC_MASKx is
mentioned in Section 3.4 of the user manual.

Let me know your opinion.

> In this patch,
> 
> - DAC, HDMI, AUDIO 0/1/2, UCLK(uart) 0/1/2/3, MIXER, FIMC 0/1/2,
> FIMC, MMC 0/1/2/3, CSIS, SPI 0/1, PWI, and PWM clock sources are
> modified to use CLK_SRC_MASK0/1, which were using CLK_GATE_IPx.
> 
> - CAM 0/1 did not have enable/disable control. They now access
>   CLK_SRC_MASK0.
> 
> - MFC, G3D, G2D were using CLK_GATE_IPx. However, as there are no clocks
>   defined to control MFC, G3D, and G2D, we kept them to access
> CLK_GATE_IPx. These may need to be modified (erase .enable, .ctrlbit
> from sclk_mfc, sclk_g2d, sclk_g3d and create clocks: g3d, g2d, mfc)
> later.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |  101
++++++++++++++++++++++-------------------
>  1 files changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index ec5ad8c..08c1063 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
