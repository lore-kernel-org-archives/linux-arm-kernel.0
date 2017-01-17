From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 17 Jan 2017 13:57:06 -0600
Subject: [PATCH v12 6/7] arm64: pmu: Detect and enable multiple PMUs in an
 ACPI system
In-Reply-To: <20170116182838.GA1843@red-moon>
References: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
 <1484068672-15852-7-git-send-email-jeremy.linton@arm.com>
 <20170116182838.GA1843@red-moon>
Message-ID: <7cac6043-b3d6-d10b-c471-9d39c7e34305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2017 12:28 PM, Lorenzo Pieralisi wrote:
> On Tue, Jan 10, 2017 at 11:17:51AM -0600, Jeremy Linton wrote:
>
> [...]
>
>> +static int __init pmu_acpi_init(void)
>> +{
>> +	struct pmu_types *pmu, *safe_temp;
>> +	bool unused_madt_entries;
>> +	LIST_HEAD(pmus);
>> +
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	unused_madt_entries = arm_pmu_acpi_determine_cpu_types(&pmus);
>
> IIUC (and that's an if) unused_madt_entries is a "buffer" that you add
> to all platform devices you manage to create through midr matching to
> make sure there are enough resource entries when/if a cpu of the
> respective type is onlined.
>
> If that's the case unused_madt_entries can't be a bool.

Some where along in the patch churn, it transformed from a bool 
indicating there were extras to the count which triggered allocation at 
max cpu counts to just adding in the difference. So yes, its a bug if 
there is more than 1 offline CPU. I will resubmit it.


>
> Second question I have is what happens if cpus that aren't online
> have an midr that differs from all the entries parsed at init time
> (ie those you created a platform device for), that's certainly
> a pesky corner case though.

Yes, right now if you have an entire class of cores offline at boot and 
they are later brought online, they won't get PMU entries because that 
requires creating another platform device, and the posted code can't 
handle that. I was ignoring it for this patch set because it fails 
gracefully and I didn't want to add even more churn.
