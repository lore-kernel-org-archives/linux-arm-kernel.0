From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sun, 27 Sep 2015 15:48:24 +0200
Subject: [PATCH V5 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <8d3d3428c3a36f821e4c3d8563d094ca4b4763fd.1443304934.git.viresh.kumar@linaro.org>
References: <8d3d3428c3a36f821e4c3d8563d094ca4b4763fd.1443304934.git.viresh.kumar@linaro.org>
Message-ID: <CAJZ5v0imYBPVNfVjkgX1r8a1x6QbY4LtRcS7BNsGzg5=yuPRfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 12:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> global_lock is defined as an unsigned long and accessing only its lower
> 32 bits from sysfs is incorrect, as we need to consider other 32 bits
> for big endian 64-bit systems. There are no such platforms yet, but the
> code needs to be robust for such a case.
>
> Fix that by changing type of 'global_lock' to u32.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Greg, please take this one along with the [2/2] if that one looks good to you.

> ---
> BCC'd a lot of people (rather than cc'ing them) to make sure
> - the series reaches them
> - mailing lists do not block the patchset due to long cc list
> - and we don't spam the BCC'd people for every reply
>
> V4->V5:
> - Switch back to the original solution of making global_lock u32.
> ---
>  drivers/acpi/ec_sys.c   | 2 +-
>  drivers/acpi/internal.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
> index b4c216bab22b..bea8e425a8de 100644
> --- a/drivers/acpi/ec_sys.c
> +++ b/drivers/acpi/ec_sys.c
> @@ -128,7 +128,7 @@ static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
>         if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
>                 goto error;
>         if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
> -                                (u32 *)&first_ec->global_lock))
> +                                &first_ec->global_lock))
>                 goto error;
>
>         if (write_support)
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 9e426210c2a8..9db196de003c 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -138,7 +138,7 @@ struct acpi_ec {
>         unsigned long gpe;
>         unsigned long command_addr;
>         unsigned long data_addr;
> -       unsigned long global_lock;
> +       u32 global_lock;
>         unsigned long flags;
>         unsigned long reference_count;
>         struct mutex mutex;
> --
> 2.4.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
