From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 11:57:07 +0000
Subject: [PATCH v6 07/11] drivers: perf: hisi: Add support for Hisilicon
 SoC event counters
In-Reply-To: <58D4F277.7080006@gmail.com>
References: <1489127311-112778-1-git-send-email-anurup.m@huawei.com>
 <20170321165252.GA29116@leverpostej> <58D4F277.7080006@gmail.com>
Message-ID: <20170324115707.GD22771@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 03:48:31PM +0530, Anurup M wrote:
> On Tuesday 21 March 2017 10:22 PM, Mark Rutland wrote:
> >On Fri, Mar 10, 2017 at 01:28:31AM -0500, Anurup M wrote:

> >Can you please elaborate on the relationship between the index, its
> >bank, and its module?
> >
> >It's not clear to me what's going on above.
> 
> The module_id and bank_select values are both needed to identify the
> L3 cache bank/instance.
> The v1 and v2 chip differ in the way these values are mapped.
> 
> In v1 hw (hip05/06):
> instance 0: module_id = 0x04, bank_select = 0x02
> instance 1: module_id = 0x04, bank_select = 0x04
> instance 2: module_id = 0x04, bank_select = 0x01
> instance 3: module_id = 0x04, bank_select = 0x08
> 
> In v2 hw (hip07):
> instance 0: module_id = 0x01, bank_select = 0x01
> instance 1: module_id = 0x02, bank_select = 0x01
> instance 2: module_id = 0x03, bank_select = 0x01
> instance 3: module_id = 0x04, bank_select = 0x01
> 
> So here we can see that for v1 hw, module_id is same and bank_select
> is different.
> In v2 hw, every instance has different module_id to make djtag
> access faster than v1.
> so the module_id is different and bank_select is same.
> 
> So I create a map array to identify the L3 cache instance.
> 
> +/* hip05/06 chips L3C bank identifier */
> +static u32 l3c_bankid_map_v1[MAX_BANKS] = {
> +    0x02, 0x04, 0x01, 0x08,
> +};
> +
> +/* hip07 chip L3C bank identifier */
> +static u32 l3c_bankid_map_v2[MAX_BANKS] = {
> +    0x01, 0x02, 0x03, 0x04,
> +};
> 
> Is my approach OK? or can be improved?

I think it would make more sense for this to be described in the DT.

[...]

> >>+	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);

> >>+	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);

> >What happens when either of these fail?

> >>+	hisi_djtag_readreg(module_id, bank_sel, reg_off, client, &value);

> >>+	hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);

> >>+	ret = hisi_djtag_writereg(module_id, bank_sel, reg_off, value, client);

> >>+	hisi_djtag_readreg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
> >>+			   client, &value);

> >>+	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
> >>+			    value, client);

> >What happens if these accesses time out?
> >
> >Why are we not proagating the error, or handling it somehow?


> >>+	hisi_djtag_readreg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
> >>+			   client, &value);

> >>+	hisi_djtag_writereg(module_id, bank_sel, L3C_EVCTRL_REG_OFF,
> >>+			    value, client);

> >Likewise.
 
> The djtag -EBUSY in hardware is a very rare scenario, and by design
> of hardware, does not occur unless there is a Chip hung situation.
> The maximum timeout possible in djtag is 30us, and hardware logic
> shall reset it, if djtag is unavailable for more than 30us.
> The timeout used in driver is 100ms to ensure that it does not fail
> in any case.
> so I had ignored the error with just a warning.
> 
> I shall handle the error internally and propagate it until a void
> function (pmu->start, pmu->stop, pmu->del etc. are void).
> e.g. in the scenario pmu->add ---> pmu->start. If start fail,
> pmu->add cannot catch it and continues.
> the counter index could be cleared when pmu->del is called later.
> 
> Is this fine? Any suggestion to handle it?

Propagating it up to a void function, only to silently fail is not good.

Given it seems this should only happen if there is a major HW problem,
I'd be happier with a BUG_ON() in the djtag accessors.

[...]

> >>+void hisi_uncore_pmu_enable(struct pmu *pmu)
> >>+{
> >>+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
> >>+
> >>+	if (hisi_pmu->ops->start_counters)
> >>+		hisi_pmu->ops->start_counters(hisi_pmu);
> >>+}
> >>+
> >>+void hisi_uncore_pmu_disable(struct pmu *pmu)
> >>+{
> >>+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
> >>+
> >>+	if (hisi_pmu->ops->stop_counters)
> >>+		hisi_pmu->ops->stop_counters(hisi_pmu);
> >>+}
> >When do you not have these?
> >
> >In the absence of pmu::{enable,disable}, you must disallow groups, since
> >their events will be enabled for different periods of time.
> 
> For L3 cache and MN PMU, pmu::{enable,disable}is present. But in
> case of Hisilicon DDRC PMU,
> it is not available. It only support continuous counting. I shall
> disallow groups when adding support
> for DDRC PMU.

Given this code does not currently support the DDRC, please simplify
the coder to assume these callbacks always exist. We can alter it when
DDRC support arrives.

Thanks,
Mark.
