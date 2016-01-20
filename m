From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 20 Jan 2016 17:12:18 +0200
Subject: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
In-Reply-To: <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
 <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> Factor out the code that finds the first physical device
> of a given ACPI device.  It is used in several places.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

Hmm? Sorry, didn't notice one style issue and there is one is matter
of taste below.

> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -43,7 +43,6 @@ static const struct acpi_device_id forbidden_id_list[] = {

> +       pdevinfo.parent = adev->parent ?
> +               acpi_get_first_physical_node(adev->parent) : NULL;

Matter of taste, but I believe if-else looks better here even when
consumes +2 LOC.
Or, does it fit 80? How wide then?

> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -478,24 +478,35 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
>                               Device Matching
>     -------------------------------------------------------------------------- */
>
> -static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
> -                                                     const struct device *dev)
> +/**
> + * acpi_device_fix_parent - Get first physical node of an ACPI device

'node' -> 'device node'
Name of the function is wrong.

> + * @adev: ACPI device in question
> + */
> +struct device *acpi_get_first_physical_node(struct acpi_device *adev)
>  {
>         struct mutex *physical_node_lock = &adev->physical_node_lock;
> +       struct device *node = NULL;
>
>         mutex_lock(physical_node_lock);
> -       if (list_empty(&adev->physical_node_list)) {
> -               adev = NULL;
> -       } else {
> -               const struct acpi_device_physical_node *node;
>
> +       if (!list_empty(&adev->physical_node_list))
>                 node = list_first_entry(&adev->physical_node_list,
> -                                       struct acpi_device_physical_node, node);
> -               if (node->dev != dev)
> -                       adev = NULL;
> -       }
> +                               struct acpi_device_physical_node, node)->dev;

I didn't notice this '->dev' thingy. I supposed that the function
returns struct acpi_device_physical_node *, not struct device *.

Currently the name is not aligned with returned value.

> +
>         mutex_unlock(physical_node_lock);
> -       return adev;
> +
> +       return node;
> +}


-- 
With Best Regards,
Andy Shevchenko
