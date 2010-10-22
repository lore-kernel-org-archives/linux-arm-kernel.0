From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Oct 2010 23:10:20 -0200
Subject: imx: PWM module on mx35
In-Reply-To: <1287700257.4822.29.camel@rado-desktop>
References: <1287700257.4822.29.camel@rado-desktop>
Message-ID: <AANLkTi=p1y9aAodOBu=kskGnXUu-fZ_snL+Y9R=5-Gck@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radoslav,

On Thu, Oct 21, 2010 at 8:30 PM, Radoslav Kolev <radoslav.kolev@rnd.bg> wrote:
> Hello,
>
> I am trying to use the PWM module on a Freescale MX35 SOC but all writes
> to the PWM module registers seem to be ignored.
>
> I have found two issues reported as fixed in the changelog of
> Freescales's Linux BSP for the i.MX31ADS (with similar PWM module) at
> http://www.freescale.com/files/soft_dev_tools/doc/support_info/BSPIMX31ADSLTIB__RN.txt
>
> 851 ? ? Unable to write to PWM registers
> 1438 ? ?Cannot write to PWM registers

These patches fixed the MXC_CCM_CGR1 offset for the pwm_clk in the
Freescale kernel.

Another thing that was needed was to enable the PWM clock.

Please try the patch below.

Regards,

Fabio Estevam

Subject: [PATCH] Enable PWM clocks on MX31 and MX35
 Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

---
 arch/arm/mach-mx3/clock-imx31.c |    1 +
 arch/arm/mach-mx3/clock-imx35.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 109e98f..3926915 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -612,6 +612,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_enable(&iim_clk);

 	clk_enable(&serial_pll_clk);
+	clk_enable(&pwm_clk);

 	mx31_read_cpu_rev();

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 61e4a31..968982b 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -536,6 +536,7 @@ int __init mx35_clocks_init()
 	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);

 	clk_enable(&iim_clk);
+	clk_enable(&pwm_clk);
 	mx35_read_cpu_rev();

 #ifdef CONFIG_MXC_USE_EPIT
--
