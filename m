From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 20:42:44 +0200
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
Message-ID: <2893693.4bZJXXENof@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 22:57:51 Hanjun Guo wrote:
> +       /* Collect CPU base addresses */
> +       count = acpi_parse_entries(sizeof(struct acpi_table_madt),
> +                                  gic_acpi_parse_madt_cpu, table,
> +                                  ACPI_MADT_TYPE_GENERIC_INTERRUPT,
> +                                  ACPI_MAX_GIC_CPU_INTERFACE_ENTRIES);
> +       if (count < 0) {
> +               pr_err("Error during GICC entries parsing\n");
> +               return -EFAULT;
> +       } else if (!count) {
> +               /* No GICC entries provided, use address from MADT header */
> +               struct acpi_table_madt *madt = (struct acpi_table_madt *)table;
> +
> +               if (!madt->address)
> +                       return -EFAULT;
> +
> +               cpu_phy_base = (u64)madt->address;
> +       }

After I read through ACPI-5.1 section 5.2.12.14, I wonder if this is the
best way to treat a missing ACPI_MADT_TYPE_GENERIC_INTERRUPT table.

Do we expect to see those in practice? It seems like using the x86 local
APIC address as a fallback for the GIC address is not something we
should do unless we absolutely have to support a system that doesn't
have the GIC table.

	Arnd
