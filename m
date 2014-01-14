From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 Jan 2014 13:29:17 -0600
Subject: [PATCH V6 6/8] Add EFI stub for ARM
In-Reply-To: <1389371417-379-7-git-send-email-roy.franz@linaro.org>
References: <1389371417-379-1-git-send-email-roy.franz@linaro.org>
 <1389371417-379-7-git-send-email-roy.franz@linaro.org>
Message-ID: <CAL_JsqLDVBfYomiNpFRacku4pJ3TrFy4rKJKedGp+LPGQt4m0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 10:30 AM, Roy Franz <roy.franz@linaro.org> wrote:
> This patch adds EFI stub support for the ARM Linux kernel.  The EFI stub
> operates similarly to the x86 stub: it is a shim between the EFI firmware
> and the normal zImage entry point, and sets up the environment that the
> zImage is expecting.  This includes loading the initrd (optionaly) and
> device tree from the system partition based on the kernel command line.
> The stub updates the device tree as necessary, adding entries for EFI
> runtime services. The PE/COFF "MZ" header at offset 0 results in the
> first instruction being an add that corrupts r5, which is not used by
> the zImage interface.
>
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---

[snip]

> +       /* Look up the base of DRAM from the device tree. */
> +       fdt = (void *)fdt_addr;
> +       node = fdt_subnode_offset(fdt, 0, "memory");
> +       region = fdt_getprop(fdt, node, "reg", NULL);
> +       if (region) {
> +               dram_base = fdt64_to_cpu(region->base);

This will not work if the address is 32-bit size.

> +       } else {
> +               /* There is no way to get amount or addresses of physical
> +                * memory installed using EFI calls.  If the device tree
> +                * we read from disk doesn't have this, there is no way
> +                * for us to construct this informaion.
> +                */
> +               pr_efi_err(sys_table, "No 'memory' node in device tree.\n");
> +               goto fail_free_fdt;

The current pc can't be used to determine the DRAM base like AUTO_ZRELADDR?

Rob
