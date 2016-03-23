From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 23 Mar 2016 11:48:34 -0400
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <56D60C90.7080703@timesys.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
Message-ID: <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Mar 1, 2016 at 4:41 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> Hi Philipp,
>
> On 02/26/2016 03:51 AM, Philipp Zabel wrote:
>>
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>
> <snip>
>
>
>> +static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
>> +{
>> +       unsigned int reg;
>> +       unsigned int sel[2][4];
>> +       int i;
>> +
>> +       reg = readl_relaxed(ccm_base + CCM_CS2CDR);
>> +       sel[0][0] = (reg >> CS2CDR_LDB_DI0_CLK_SEL_SHIFT) & 7;
>> +       sel[1][0] = (reg >> CS2CDR_LDB_DI1_CLK_SEL_SHIFT) & 7;
>> +
>> +       sel[0][3] = sel[0][2] = sel[0][1] = sel[0][0];
>> +       sel[1][3] = sel[1][2] = sel[1][1] = sel[1][0];
>> +
>> +       of_assigned_ldb_sels(np, &sel[0][3], &sel[1][3]);
>> +
>> +       for (i = 0; i < 2; i++) {
>> +               /* Warn if a glitch might have been introduced already */
>> +               if (sel[i][0] != 3) {
>> +                       pr_warn("ccm: ldb_di%d_sel already changed from
>> reset value: %d\n",
>> +                               i, sel[i][0]);
>> +               }
>> +
>> +               if (sel[i][0] == sel[i][3])
>> +                       continue;
>> +
>> +               /* Only switch to or from pll2_pfd2_396m if it is disabled
>> */
>> +               if ((sel[i][0] == 2 || sel[i][3] == 2) &&
>> +                   (clk_get_parent(clk[IMX6QDL_CLK_PERIPH_PRE]) ==
>> +                    clk[IMX6QDL_CLK_PLL2_PFD2_396M])) {
>> +                       pr_err("ccm: ldb_di%d_sel: couldn't disable
>> pll2_pfd2_396m\n",
>> +                              i);
>> +                       sel[i][3] = sel[i][2] = sel[i][1] = sel[i][0];
>> +                       continue;
>> +               }
>> +
>> +               /*
>> +                * It is unclear whether the procedure works for switching
>> from
>> +                * pll3_usb_otg to any other parent than pll5_video_div
>> +                */
>> +               if (sel[i][0] > 3 && sel[i][0] != (sel[i][3] | 4)) {
>> +                       pr_err("ccm: ldb_di%d_sel workaround only for top
>> mux\n",
>> +                              i);
>> +                       sel[i][3] = sel[i][2] = sel[i][1] = sel[i][0];
>> +                       continue;
>> +               }
>
>
> EB821 doesn't mention the above restriction. My understanding was as long as
> the clock source you are switching from/to is disabled it should be ok to do
> so. Maybe someone from Freescale can comment?
>
>> +
>> +               /* First switch to the bottom mux */
>> +               sel[i][1] = sel[i][0] | 4;
>> +
>
>
> Not sure if this really matters but as per EB821 Section 4.2, 6 b, the
> recommended setting for sel[i][1] is 7
>
>
>> +               /* Then configure the top mux before switching back to it
>> */
>> +               sel[i][2] = sel[i][3] | 4;
>> +
>
>
> Same goes here, as per EB821, Section 4.2, 6 c, the recommended setting for
> sel[i][2] is 4
>

Any comment from NXP regarding the same? I have tested this patch as
it is and it resolves intermittent blank LVDS display issues we are
seeing on our boards. The questions is if the patch needs to be
updated to match EB821 document for the above sections?

It would be nice to get the patch accepted since it solves actual LVDS
display issues on clock switch.

Thanks,
Akshay
