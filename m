From: ashok.sekar@broadcom.com (Ashok Sekar)
Date: Mon, 28 Mar 2016 17:55:44 +0530
Subject: [PATCH v2 3/6] arm64/perf: Filter common events based on
 PMCEIDn_EL0
In-Reply-To: <20160324161442.GA14953@leverpostej>
References: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
 <1458823960-32760-4-git-send-email-ashoks@broadcom.com>
 <20160324161442.GA14953@leverpostej>
Message-ID: <CANK38rY7Vr2hgJ6itWO7wbnisAatL4UBGUyRuP8N9ceMb=JHRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Mar 24, 2016 at 9:44 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> HI,
>
> On Thu, Mar 24, 2016 at 05:52:37AM -0700, Ashok Kumar wrote:
>> The complete common architectural and micro-architectural
>> event number structure is filtered based on PMCEIDn_EL0 and
>> copied to a new structure which is exposed to /sys
>>
>> The function which derives event bitmap from PMCEIDn_EL0 is
>> executed in the cpus, which has the pmu being initialized,
>> for heterogeneous pmu support.
>
> I would prefer it we could instead filter the list at run time by
> implementing attribute_group::is_visible() for the events attribute
> group, and share a common set of attributes and attr groups. That would
> avoid the filtering, copying, and assocaited memory allocation.
>
> e.g. have an array of:
>
> struct event_attribute {
>         struct attribute attr;
>         int pmceid_idx;
> };
>
> Then cache the pmceid value at probe time, and have and something like:
>
> umode_t event_attr_is_visible(struct kobject *kobj, struct attribute *attr, int)
> {
>         struct arm_pmu *arm_pmu;
>         struct event_attribute *e_attr;
>
>         arm_pmu = pmu_kobj_to_armpmu(kobj);
>         e_attr = container_of(attr, struct event_attr, attr);
>
>         if (test_bit(e_attr->pmceid_idx, &arm_pmu->cached_pmceid))
>                 return 0444;
>
>         return 0;
> }
This looks better - posted a v3 based on your suggestion.

Thanks,
Ashok
>
> Thanks,
> Mark.
