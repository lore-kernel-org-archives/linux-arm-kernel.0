From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Thu, 20 Jul 2017 21:49:47 +0800
Subject: [PATCH v3 2/6] perf: hisi: Add support for HiSilicon SoC uncore
 PMU driver
In-Reply-To: <c7fe3dc9-4510-1821-d2db-2e52f311aacd@hisilicon.com>
References: <1500364799-90518-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500364799-90518-3-git-send-email-zhangshaokun@hisilicon.com>
 <20170719171912.000031dd@huawei.com>
 <c7fe3dc9-4510-1821-d2db-2e52f311aacd@hisilicon.com>
Message-ID: <20170720214904.0000601b@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jul 2017 21:03:19 +0800
Zhangshaokun <zhangshaokun@hisilicon.com> wrote:

> Hi Jonathan
> 
> On 2017/7/19 17:19, Jonathan Cameron wrote:
> > On Tue, 18 Jul 2017 15:59:55 +0800
> > Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> >   
> >> This patch adds support HiSilicon SoC uncore PMU driver framework and
> >> interfaces.
> >>
> >> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> >> Signed-off-by: Anurup M <anurup.m@huawei.com>    
> > A couple of minor things inline.
> > 
<snip>
> >> +/* Generic pmu struct for different pmu types */
> >> +struct hisi_pmu {
> >> +	const char *name;
> >> +	struct pmu pmu;
> >> +	const struct hisi_uncore_ops *ops;
> >> +	struct hisi_pmu_hwevents pmu_events;
> >> +	cpumask_t cpus;
> >> +	struct device *dev;
> >> +	struct hlist_node node;
> >> +	u32 scl_id;
> >> +	u32 ccl_id;
> >> +	/* Hardware information for different pmu types */
> >> +	void __iomem *base;
> >> +	union {
> >> +		u32 ddrc_chn_id;
> >> +		u32 l3c_tag_id;
> >> +		u32 hha_uid;
> >> +	};
> >> +	int num_counters;
> >> +	int num_events;
> >> +	int counter_bits;
> >> +};
> >> +
> >> +int hisi_uncore_pmu_counter_valid(struct hisi_pmu *hisi_pmu, int idx);
> >> +int hisi_uncore_pmu_get_event_idx(struct perf_event *event);
> >> +void hisi_uncore_pmu_clear_event_idx(struct hisi_pmu *hisi_pmu, int idx);    
> > The above is only used in hisi_uncore_pmu.c so doesn't need to be here
> > and can be static.
> >   
> 
> These functions would be called in L3C/HHA/DDR PMU driver. We want to give a
> uncore perf framework in hisi_uncore_pmu.c for hisilicon uncore PMUs.
> 
For all but the one function above that is true.  I couldn't find this one being
used anywhere in those drivers.


> Thanks.
> Shaokun
> 
> >> +void hisi_uncore_pmu_read(struct perf_event *event);
> >> +int hisi_uncore_pmu_add(struct perf_event *event, int flags);
> >> +void hisi_uncore_pmu_del(struct perf_event *event, int flags);
> >> +void hisi_uncore_pmu_start(struct perf_event *event, int flags);
> >> +void hisi_uncore_pmu_stop(struct perf_event *event, int flags);
> >> +void hisi_uncore_pmu_set_event_period(struct perf_event *event);
> >> +u64 hisi_uncore_pmu_event_update(struct perf_event *event);
> >> +int hisi_uncore_pmu_event_init(struct perf_event *event);
> >> +int hisi_uncore_pmu_setup(struct hisi_pmu *hisi_pmu, const char *pmu_name);
> >> +void hisi_uncore_pmu_enable(struct pmu *pmu);
> >> +void hisi_uncore_pmu_disable(struct pmu *pmu);
> >> +struct hisi_pmu *hisi_pmu_alloc(struct device *dev, u32 num_cntrs);
> >> +ssize_t hisi_event_sysfs_show(struct device *dev,
> >> +			      struct device_attribute *attr, char *buf);
> >> +ssize_t hisi_format_sysfs_show(struct device *dev,
> >> +			       struct device_attribute *attr, char *buf);
> >> +ssize_t hisi_cpumask_sysfs_show(struct device *dev,
> >> +				struct device_attribute *attr, char *buf);
> >> +void hisi_read_scl_and_ccl_id(u32 *scl_id, u32 *ccl_id);
> >> +#endif /* __HISI_UNCORE_PMU_H__ */    
> > 
> > 
> > .
> >   
> 
