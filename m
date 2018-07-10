From: ilia.lin@gmail.com (Ilia Lin)
Date: Tue, 10 Jul 2018 15:43:57 +0300
Subject: [PATCH v11 2/2] dt: qcom: Add qcom-cpufreq-kryo driver
 configuration
In-Reply-To: <20180710092900.GA26718@centauri.lan>
References: <1527081091-13389-1-git-send-email-ilialin@codeaurora.org>
 <1527081091-13389-3-git-send-email-ilialin@codeaurora.org>
 <20180710092900.GA26718@centauri.lan>
Message-ID: <CA+5LGR36xwVWKytv=NGaeS+S7L3ryFgpWWz_dgqH3SHi9XCqaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

The frequency list in the DT is correct, but the initial frequency for
the CPUs 0,1 is configured by the XBL, while the CPUs 2,3 stay at XO
rate. Both rates are unlisted in the DT and that's OK.

BR,
Ilia Lin

On Tue, Jul 10, 2018 at 12:29 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> On Wed, May 23, 2018 at 04:11:31PM +0300, Ilia Lin wrote:
> > 1. Add NVMEM node for the speedbin
> > 2. Add definitions for all possible MSM8996 CPU OPPs.
> > The qcom-cpufreq-kryo driver will select the appropriate subset.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi       | 281 ++++++++++++++++++++++++++--
> >  2 files changed, 270 insertions(+), 13 deletions(-)
> >
>
> Hello Ilia, Viresh
>
>
> I tried this patch series (together with you cpu clock driver).
>
> The first problem is that the driver fails to create debugfs entries.
>
> The second problem appears to be that it runs on unlisted frequency.
> Is this simply because of missing entries in the opp table?
>
> [    4.538513] cpu cpu1: opp_list_debug_create_link: Failed to create link
> [    4.538567] cpu cpu1: _add_opp_dev: Failed to register opp debugfs (-12)
> [    4.544514] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 614400 KHz
> [    4.551441] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 652800 KHz
> [    4.563219] cpu cpu3: opp_list_debug_create_link: Failed to create link
> [    4.566937] cpu cpu3: _add_opp_dev: Failed to register opp debugfs (-12)
> [    4.573489] cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 19200 KHz
> [    4.580368] cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 307200 KHz
>
>
> Kind regards,
> Niklas
