From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 5 Nov 2015 14:59:08 +0100
Subject: [PATCH] ARM: ACPI: Fix the helper which checks if only a /chosen
 node
In-Reply-To: <1446728187-14552-1-git-send-email-zhaoshenglong@huawei.com>
References: <1446728187-14552-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <CAKv+Gu-EJxogB29vXM-G_KYjHYzXFEzgWX3f=E=3=QVGcRXJaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2015 at 13:56, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> Assuming that there are several other nodes and a /chosen node in a DTS
> and the /chosen node is last node, of_scan_flat_dt() will return 0

If those 'several other nodes' are not all subnodes of /chosen, at
least one of them will be at depth 1, right? Could you give an example
DTS where this goes wrong?

> while
> we expect it returns 1 when it's used to call a function to check if
> there is only a /chosen node in DTS.
>

of_scan_flat_dt() will terminate early and return 1 on the first
occasion that the callback returns 1. The callback returns 1 if it
encounters a node at depth 1 whose name is not 'chosen'. So I am
failing to see how this code is broken.

> Fix this by passing a meaningful parameter instead of NULL to
> of_scan_flat_dt() to record if it finds a node that is not /chosen node.
>

While it is hardly a performance concern, you really don't need to
traverse the entire FDT to figure out that /chosen is not the only
depth 1 node.

> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 19de753..51c988c 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -60,12 +60,15 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
>                                        const char *uname, int depth,
>                                        void *data)
>  {
> +       bool *found = data;
> +
>         /*
>          * Return 1 as soon as we encounter a node at depth 1 that is
>          * not the /chosen node.
>          */
>         if (depth == 1 && (strcmp(uname, "chosen") != 0))
> -               return 1;
> +               *found = true;
> +
>         return 0;
>  }
>
> @@ -176,15 +179,20 @@ out:
>   */
>  void __init acpi_boot_table_init(void)
>  {
> +       bool found = false;
>         /*
>          * Enable ACPI instead of device tree unless
>          * - ACPI has been disabled explicitly (acpi=off), or
>          * - the device tree is not empty (it has more than just a /chosen node)
>          *   and ACPI has not been force enabled (acpi=force)
>          */
> -       if (param_acpi_off ||
> -           (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> +       if (param_acpi_off) {
>                 return;
> +       } else if (!param_acpi_force) {
> +               of_scan_flat_dt(dt_scan_depth1_nodes, &found);
> +               if (found)
> +                       return;
> +       }
>
>         /*
>          * ACPI is disabled at this point. Enable it in order to parse
> --
> 2.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
