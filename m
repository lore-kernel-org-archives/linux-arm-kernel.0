From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 21 Jun 2017 23:35:14 +0200
Subject: [PATCH 4/9] PM / ACPI: Split code validating need for runtime
 resume in ->prepare()
In-Reply-To: <1498072888-14782-5-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <1498072888-14782-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0j3oLUmg-8fW4372yE-uy0kM28E06jFQCPp14xb66aY+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Move the code dealing with validation of whether runtime resuming the
> device is needed during system suspend.
>
> In this way it becomes more clear for what circumstances ACPI is prevented
> from trying the direct_complete path.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/acpi/device_pm.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d38acbc..ee51e75 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -933,6 +933,27 @@ int acpi_dev_resume_early(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
>
> +static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
> +{
> +       u32 sys_target = acpi_target_system_state();
> +       int ret, state;
> +
> +       if (device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
> +               return true;
> +
> +       if (sys_target == ACPI_STATE_S0)
> +               return false;
> +
> +       if (adev->power.flags.dsw_present)
> +               return true;
> +
> +       ret = acpi_dev_pm_get_state(dev, adev, sys_target, NULL, &state);
> +       if (ret)
> +               return true;
> +
> +       return !(state == adev->power.state);

Nit: I would write this as

  return state != adev->power.state;

Thanks,
Rafael
