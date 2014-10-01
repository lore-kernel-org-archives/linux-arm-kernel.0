From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 1 Oct 2014 16:08:25 +0545
Subject: [PATCH v8 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CABxcv=kEVma+Ho6PPy+4t+zYH67sAWbbvJvrviPop-MBqktbjw@mail.gmail.com>
References: <1412074969-12704-1-git-send-email-vikas.sajjan@samsung.com>
 <CABxcv=kEVma+Ho6PPy+4t+zYH67sAWbbvJvrviPop-MBqktbjw@mail.gmail.com>
Message-ID: <CAGm_ybhD0N0r5gj=xAp+ERPq7CjO2d6bDLcPHAoZk1_8+t2Fvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Javier,

On Tue, Sep 30, 2014 at 7:15 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Vikas,
>
> Thanks a lot for the re-spin.
>
> On Tue, Sep 30, 2014 at 1:02 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>>
>> Tested on Kukjin Kim's tree, for-next branch +
>> 1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
>> 2] https://lkml.org/lkml/2014/9/30/156
>
> I wanted to test your series but I noticed that Abhilash's patch:
>
> "[PATCH v7] ARM: EXYNOS: Use MCPM call-backs to support S2R on Exynos5420"
>
> does not apply cleanly on Kukjin's for-next branch. I see that all the
> dependencies mentioned (modulo $subject or course) have already been
> merged though.
>
> Did you rebase Abhilash's to test your series?. I can forward port as
> well but just want to be sure that I'm not missing any other
> dependency.
>
Yea, I did rebase abhilash's MCPM patch to test my series.

> These are the patches I've on top of Kukjin's for-next branch fyi:
>
> 663dfa7 ARM: exynos5: Add Suspend-to-RAM support for 5420
> b4b3b76 ARM: exynos5: Add PMU support for 5420
> 6c0e381 ARM: EXYNOS: Move PMU specific definitions from common.h
> cdf79fe ARM: EXYNOS: Add platform driver support for Exynos PMU
> d2d8bc6 mfd: syscon: Decouple syscon interface from platform devices
>

My git log looks like below on top of Kukjin's for-next branch,

d861ddd clk: exynos: Add CLK_IGNORE_UNUSED to aclk200_disp1 and aclk300_disp1
adc14dc POSTED: ARM: EXYNOS: Use MCPM call-backs to support S2R on Exynos5420
d61fc43 ARM: exynos5: Add Suspend-to-RAM support for 5420
3d1d7bd ARM: exynos5: Add PMU support for 5420
a8887b3 mfd: syscon: Decouple syscon interface from platform devices
072e2bc ARM: EXYNOS: Move PMU specific definitions from common.h
ec2f950 ARM: EXYNOS: Add platform driver support for Exynos PMU

recently I noticed that, without the CLK_IGNORE_UNUSED flag for
aclk200_disp1 and aclk300_disp1 CLK,  the system is NOT suspending,
which was NOT the case when i had posted my previous revisions.

diff --git a/drivers/clk/samsung/clk-exynos5420.c
b/drivers/clk/samsung/clk-exynos5420.c
index 848d602..d8b6633 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -932,14 +932,14 @@ static struct samsung_gate_clock
exynos5x_gate_clks[] __initdata = {
        GATE(0, "aclk400_mscl", "mout_user_aclk400_mscl",
                        GATE_BUS_TOP, 17, 0, 0),
        GATE(0, "aclk200_disp1", "mout_user_aclk200_disp1",
-                       GATE_BUS_TOP, 18, 0, 0),
+                       GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
        GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
                        GATE_BUS_TOP, 28, 0, 0),
        GATE(CLK_SCLK_HSIC_12M, "sclk_hsic_12m", "ff_hsic_12m",
                        GATE_BUS_TOP, 29, 0, 0),

        GATE(0, "aclk300_disp1", "mout_user_aclk300_disp1",
-                       SRC_MASK_TOP2, 24, 0, 0),
+                       SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),

        GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
                        SRC_MASK_TOP7, 20, 0, 0),

Regards
Vikas Sajjan


> Best regards,
> Javier
