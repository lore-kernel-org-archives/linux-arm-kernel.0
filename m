From: john.garry@huawei.com (John Garry)
Date: Fri, 5 Oct 2018 13:27:08 +0100
Subject: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
In-Reply-To: <20181004122207.GE4065@arm.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com>
 <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
 <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
 <20181004122207.GE4065@arm.com>
Message-ID: <b04c43bd-5c90-cc06-e2cc-ce542981853a@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2018 13:22, Will Deacon wrote:
> Hi Ganapat,
>
> On Thu, Oct 04, 2018 at 11:12:09AM +0530, Ganapatrao Kulkarni wrote:
>> can you please pull this patch?
>
> I still don't like the idea of just removing events like this, especially
> when other architectures (including some x86 and Power CPUs afaict) playa
> similar games for generic events, and these events do actually appear in
> user code.
>
> I also don't understand why you remove the TLB events. I think that logic
> would imply we should remove all of the events, because we can't distinguish
> prefetches from reads either. If we want to be consistent, then I think
> we should just remove the OP_WRITE events for L1D and BPU -- would you be
> ok with that instead?
>
> Also, looking at the code, I think our PMCEID parsing is broken for 8.1
> parts, where the upper 32 bits of the register are offset by 0x4000 in the
> event numbering space.
>

Here's something I noticed:
static ssize_t
armv8pmu_events_sysfs_show(struct device *dev,
			   struct device_attribute *attr, char *page)
{
	struct perf_pmu_events_attr *pmu_attr;

	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);

	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);

Should this be min width now be 4, since event width is now 16 bits 
(even though I don't know why we need to specify this width at all)?

Cheers,
John

> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>
