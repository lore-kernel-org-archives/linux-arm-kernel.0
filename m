From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Dec 2017 10:48:13 +0100
Subject: [PATCH V4 06/12] boot_constraint: Add support for PM constraints
In-Reply-To: <000268f9c5b06354333a18dbe26fc8b052231ed8.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <000268f9c5b06354333a18dbe26fc8b052231ed8.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171213094813.GF13194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:54PM +0530, Viresh Kumar wrote:
> This patch adds the PM constraint type.
> 
> The constraint is set by attaching the power domain for the device,
> which will also enable the power domain. This guarantees that the power
> domain doesn't get shut down while being used.
> 
> We don't need to detach the power domain to remove the constraint as the
> domain is attached only once, from here or before driver probe.
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/boot_constraints/Makefile |  2 +-
>  drivers/boot_constraints/core.c   |  4 ++++
>  drivers/boot_constraints/core.h   |  3 +++
>  drivers/boot_constraints/pm.c     | 24 ++++++++++++++++++++++++
>  include/linux/boot_constraint.h   |  1 +
>  5 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/boot_constraints/pm.c
> 
> diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
> index 3424379fd1e4..b7ade1a7afb5 100644
> --- a/drivers/boot_constraints/Makefile
> +++ b/drivers/boot_constraints/Makefile
> @@ -1,3 +1,3 @@
>  # Makefile for device boot constraints
>  
> -obj-y := clk.o core.o supply.o
> +obj-y := clk.o core.o pm.o supply.o
> diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
> index 9213e56e8078..f4d3520ddb04 100644
> --- a/drivers/boot_constraints/core.c
> +++ b/drivers/boot_constraints/core.c
> @@ -98,6 +98,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
>  		add = constraint_clk_add;
>  		remove = constraint_clk_remove;
>  		break;
> +	case DEV_BOOT_CONSTRAINT_PM:
> +		add = constraint_pm_add;
> +		remove = constraint_pm_remove;
> +		break;
>  	case DEV_BOOT_CONSTRAINT_SUPPLY:
>  		add = constraint_supply_add;
>  		remove = constraint_supply_remove;
> diff --git a/drivers/boot_constraints/core.h b/drivers/boot_constraints/core.h
> index 4f28ac2ef691..a051c3d7c8ab 100644
> --- a/drivers/boot_constraints/core.h
> +++ b/drivers/boot_constraints/core.h
> @@ -33,6 +33,9 @@ struct constraint {
>  int constraint_clk_add(struct constraint *constraint, void *data);
>  void constraint_clk_remove(struct constraint *constraint);
>  
> +int constraint_pm_add(struct constraint *constraint, void *data);
> +void constraint_pm_remove(struct constraint *constraint);
> +
>  int constraint_supply_add(struct constraint *constraint, void *data);
>  void constraint_supply_remove(struct constraint *constraint);
>  
> diff --git a/drivers/boot_constraints/pm.c b/drivers/boot_constraints/pm.c
> new file mode 100644
> index 000000000000..edba5eca5093
> --- /dev/null
> +++ b/drivers/boot_constraints/pm.c
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2017 Linaro.
> + * Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#define pr_fmt(fmt) "PM Boot Constraints: " fmt

You don't use this :(
