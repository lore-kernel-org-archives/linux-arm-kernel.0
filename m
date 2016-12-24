From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 24 Dec 2016 12:18:35 +0000
Subject: [RFC] arm64/acpi: make ACPI boot preference configurable
In-Reply-To: <7eba0601099f75f19021c4259eca75ada06f4511.1482341997.git.jtoppins@redhat.com>
References: <7eba0601099f75f19021c4259eca75ada06f4511.1482341997.git.jtoppins@redhat.com>
Message-ID: <CAKv+Gu_RGzXRjfr9zuo1AgadAXkbKJp7h=X_+ev-MsGSd=k-Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 December 2016 at 17:54, Jonathan Toppins <jtoppins@redhat.com> wrote:
> This patch allows a user to configure ACPI to be preferred over
> device-tree.
>

This has been discussed at length in the past, and has been rejected
by the arm64 maintainers. (I was the one who proposed the exact same
thing the last time around)

> Currently for ACPI to be used a user either has to set acpi=on on the
> kernel command line or make sure any device tree passed to the kernel
> is empty. If the dtb passed to the kernel is non-empty then device-tree
> will be chosen as the boot method of choice even if it is not correct.

It should not be up to the kernel to reason about whether the DT is
correct or not. If the firmware passes both, they should both be
correct. I fully understand that there are reasons why ACPI may be
preferable if both are correct, but correctness is not a valid
argument in this discussion.

> To prevent this situation where a system is only intended to be booted
> via ACPI a user can set this kernel configuration so it ignores
> device-tree settings unless ACPI table checks fail.
>

If a system is only intended to be booted via ACPI, it should not
expose a DT via the UEFI configuration table to begin with. Since this
is only an issue in development context (a production system that can
expose either should be configurable via the UEFI setup menu), you
should be able to add a SysPrep entry that clears the UEFI config
table using a separate UEFI app.

I think we need an update to the SBBR to stipulate that DT can be
disabled in the firmware if it is supported in addition to ACPI. In
the mean time, what we could do is update the stub so it appends to
/chosen/bootargs, rather than replace it, allowing the firmware to
pass 'acpi=on' if it absolutely needs to



> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
>  arch/arm64/Kconfig       | 13 +++++++++++++
>  arch/arm64/kernel/acpi.c |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 111742126897..e432e84245b9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -954,6 +954,19 @@ config ARM64_ACPI_PARKING_PROTOCOL
>           protocol even if the corresponding data is present in the ACPI
>           MADT table.
>
> +config ARM64_PREFER_ACPI
> +       bool "Prefer usage of ACPI boot tables over device-tree"
> +       depends on ACPI
> +       help
> +         Normally device-tree is preferred over ACPI on arm64 unless
> +         explicitly preferred via kernel command line, something like: acpi=on
> +         This configuration changes this default behaviour by pretending
> +         the user set acpi=on on the command line. This configuration still
> +         allows the user to turn acpi table parsing off via acpi=off. If
> +         for some reason the table checks fail the system will still fall
> +         back to using device-tree unless the user explicitly sets acpi=force
> +         on the command line.
> +
>  config CMDLINE
>         string "Default kernel command string"
>         default ""
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 252a6d9c1da5..b5dfa5752ff7 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -43,7 +43,7 @@ int acpi_pci_disabled = 1;    /* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>
>  static bool param_acpi_off __initdata;
> -static bool param_acpi_on __initdata;
> +static bool param_acpi_on __initdata = IS_ENABLED(CONFIG_ARM64_PREFER_ACPI);
>  static bool param_acpi_force __initdata;
>
>  static int __init parse_acpi(char *arg)
> --
> 2.10.2
>
