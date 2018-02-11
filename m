From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 11 Feb 2018 01:42:09 +0000
Subject: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
In-Reply-To: <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
References: <20180118235836.17393-1-stefan@agner.ch>
 <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
Message-ID: <AM3PR04MB1315240E4A77431A58AC8501F5F00@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Sunday, February 11, 2018 12:26 AM
> To: Stefan Agner <stefan@agner.ch>; Anson Huang <anson.huang@nxp.com>
> Cc: rjw at rjwysocki.net; viresh kumar <viresh.kumar@linaro.org>;
> linux-pm at vger.kernel.org; Marcel Ziswiler <marcel.ziswiler@toradex.com>;
> max.oss.09 at gmail.com; linux-kernel <linux-kernel@vger.kernel.org>; Octavian
> Purdila <octavian.purdila@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Shawn Guo <shawnguo@kernel.org>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
> i.MX6UL/ULL
> 
> Hi Anson,
> 
> On Thu, Jan 18, 2018 at 9:58 PM, Stefan Agner <stefan@agner.ch> wrote:
> > Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> > Use PLL1 sys clock for all operating points higher than 528MHz.
> >
> > Note: For higher operating points VDD_SOC_IN needs to be 125mV higher
> > than the ARM set-point (see datasheet). Specifically, the i.MX6UL/ULL
> > EVK boards have an external DC regulator which needs adjustment. The
> > regulator adjustment is not covered with this change.
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
> > b/drivers/cpufreq/imx6q-cpufreq.c index 628fe899cb48..840f6386c780
> > 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy
> *policy, unsigned int index)
> >                  */
> >                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> >                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> > -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> > -                       clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> > -               else
> > -                       clk_set_parent(secondary_sel_clk,
> pll2_pfd2_396m_clk);
> > -               clk_set_parent(step_clk, secondary_sel_clk);
> > -               clk_set_parent(pll1_sw_clk, step_clk);
> > +               if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> > +                       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> > +                               clk_set_parent(secondary_sel_clk,
> pll2_bus_clk);
> > +                       else
> > +                               clk_set_parent(secondary_sel_clk,
> pll2_pfd2_396m_clk);
> > +                       clk_set_parent(step_clk, secondary_sel_clk);
> > +                       clk_set_parent(pll1_sw_clk, step_clk);
> > +               }

For cpufreq > 528MHz, ARM PLL needs to be set_rate, I did NOT see where sets ARM PLL rate?

Anson.

> >         } else {
> >                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> >                 clk_set_parent(pll1_sw_clk, step_clk);
> 
> Could you please help reviewing this patch?
> 
> Thanks
