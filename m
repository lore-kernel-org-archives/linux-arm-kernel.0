From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Feb 2015 19:35:52 +0000
Subject: [PATCH v2 2/2] ARM: perf: Add support for Scorpion PMUs
In-Reply-To: <1423851849-6069-3-git-send-email-sboyd@codeaurora.org>
References: <1423851849-6069-1-git-send-email-sboyd@codeaurora.org>
 <1423851849-6069-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150220193552.GE1767@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 06:24:09PM +0000, Stephen Boyd wrote:
> Scorpion supports a set of local performance monitor event
> selection registers (LPM) sitting behind a cp15 based interface
> that extend the architected PMU events to include Scorpion CPU
> and Venum VFP specific events. To use these events the user is
> expected to program the lpm register with the event code shifted
> into the group they care about and then point the PMNx event at
> that region+group combo by writing a LPMn_GROUPx event. Add
> support for this hardware.
> 
> Note: the raw event number is a pure software construct that
> allows us to map the multi-dimensional number space of regions,
> groups, and event codes into a flat event number space suitable
> for use by the perf framework.
> 
> This is based on code originally written by Ashwin Chaugule and
> Neil Leeder [1] massaged to become similar to the Krait PMU
> support code.
> 
> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/tree/arch/arm/kernel/perf_event_msm.c?h=msm-3.4
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Neil Leeder <nleeder@codeaurora.org>
> Cc: Ashwin Chaugule <ashwinc@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt |   2 +
>  arch/arm/kernel/perf_event_cpu.c              |   2 +
>  arch/arm/kernel/perf_event_v7.c               | 417 ++++++++++++++++++++++++++
>  3 files changed, 421 insertions(+)

[...]

> +static void scorpion_evt_setup(int idx, u32 config_base)
> +{
> +       u32 val;
> +       u32 mask;
> +       u32 vval, fval;
> +       unsigned int region;
> +       unsigned int group;
> +       unsigned int code;
> +       unsigned int group_shift;
> +       bool venum_event;
> +
> +       krait_decode_event(config_base, &region, &group, &code, &venum_event,
> +                          NULL);
> +
> +       group_shift = group * 8;
> +       mask = 0xff << group_shift;
> +
> +       /* Configure evtsel for the region and group */
> +       if (venum_event)
> +               val = SCORPION_VLPM_GROUP0;
> +       else
> +               val = scorpion_get_pmresrn_event(region);
> +       val += group;
> +       /* Mix in mode-exclusion bits */
> +       val |= config_base & (ARMV7_EXCLUDE_USER | ARMV7_EXCLUDE_PL1);
> +       armv7_pmnc_write_evtsel(idx, val);
> +
> +       asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));

What's this guy doing?

> +static int scorpion_pmu_get_event_idx(struct pmu_hw_events *cpuc,
> +                                  struct perf_event *event)
> +{
> +       int idx;
> +       int bit = -1;
> +       unsigned int region;
> +       unsigned int code;
> +       unsigned int group;
> +       bool venum_event, scorpion_event;
> +       struct hw_perf_event *hwc = &event->hw;
> +
> +       krait_decode_event(hwc->config_base, &region, &group, &code,
> +                          &venum_event, &scorpion_event);
> +
> +       if (venum_event || scorpion_event) {
> +               /* Ignore invalid events */
> +               if (group > 3 || region > 3)

Where does the 3 come from?

Will
