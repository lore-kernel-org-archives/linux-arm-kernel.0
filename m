From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Jan 2017 18:28:38 +0000
Subject: [PATCH v12 6/7] arm64: pmu: Detect and enable multiple PMUs in
 an ACPI system
In-Reply-To: <1484068672-15852-7-git-send-email-jeremy.linton@arm.com>
References: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
 <1484068672-15852-7-git-send-email-jeremy.linton@arm.com>
Message-ID: <20170116182838.GA1843@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 11:17:51AM -0600, Jeremy Linton wrote:

[...]

> +static int __init pmu_acpi_init(void)
> +{
> +	struct pmu_types *pmu, *safe_temp;
> +	bool unused_madt_entries;
> +	LIST_HEAD(pmus);
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	unused_madt_entries = arm_pmu_acpi_determine_cpu_types(&pmus);

IIUC (and that's an if) unused_madt_entries is a "buffer" that you add
to all platform devices you manage to create through midr matching to
make sure there are enough resource entries when/if a cpu of the
respective type is onlined.

If that's the case unused_madt_entries can't be a bool.

Second question I have is what happens if cpus that aren't online
have an midr that differs from all the entries parsed at init time
(ie those you created a platform device for), that's certainly
a pesky corner case though.

Thanks,
Lorenzo

> +
> +	list_for_each_entry_safe(pmu, safe_temp, &pmus, list) {
> +		pmu->cpu_count += unused_madt_entries;
> +		pmu_acpi_register(pmu);
> +
> +		list_del(&pmu->list);
> +		kfree(pmu);
> +	}
> +
> +	return 0;
> +}
> +
> +arch_initcall(pmu_acpi_init);
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
