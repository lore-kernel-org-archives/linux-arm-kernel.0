From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 30 Jun 2015 18:07:50 +0100
Subject: [PATCH v2 0/3] Correct for ACPI 5.1->6.0 spec changes in MADT
 GICC entries
In-Reply-To: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
Message-ID: <5592CCE6.6040604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On 18/06/15 23:36, Al Stone wrote:
> In the ACPI 5.1 version of the spec, the struct for the GICC subtable
> (struct acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in
> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
> subtable, it fails if 5.1 structs are in use, and there are systems in
> the wild that have them.
>
> Note that this was found in linux-next and these patches apply against
> that tree and the arm64 kernel tree; 4.1-rc8 does not appear to have this
> problem since it still has the 5.1 struct definition.
>
> Even though there is precendent in ia64 code for ignoring the changes in
> size, this patch set instead tries to verify correctness.  The first patch
> in the set adds macros for easily using the ACPI spec version.  The second
> patch adds the BAD_MADT_GICC_ENTRY() macro that uses the version macros to
> check the GICC subtable only, accounting for the difference in specification
> versions that are possible.  The final patch replaces BAD_MADT_ENTRY usage
> with the BAD_MADT_GICC_ENTRY macro in arm64 code, which is currently the
> only architecture affected.  The BAD_MADT_ENTRY() will continue to work as
> is for all other MADT subtables.
>

We need to get this series or a patch to remove the check(similar to
ia64) based on what Rafael prefers. Without that, platforms using ACPI
on ARM64 fails to boot with latest mainline. This blocks any testing on
ARM64/ACPI systems.

Regards,
Sudeep
