From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Dec 2017 10:48:53 +0100
Subject: [PATCH V4 04/12] boot_constraint: Add support for supply
 constraints
In-Reply-To: <4e171b6a496a6f5645804d9ed9cb53b4bcbe75a0.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <4e171b6a496a6f5645804d9ed9cb53b4bcbe75a0.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171213094853.GH13194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:52PM +0530, Viresh Kumar wrote:
> This patch adds the first constraint type: power-supply.
> 
> The constraint is set by enabling the regulator and setting a voltage
> range (if required) for the respective regulator device, which will be
> honored by the regulator core even if more users turn up. Once the
> device is probed, the regulator is released and the constraint is
> removed.
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/boot_constraints/Makefile |  2 +-
>  drivers/boot_constraints/core.c   |  4 ++
>  drivers/boot_constraints/core.h   |  3 ++
>  drivers/boot_constraints/supply.c | 98 +++++++++++++++++++++++++++++++++++++++
>  include/linux/boot_constraint.h   |  8 +++-
>  5 files changed, 113 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/boot_constraints/supply.c
> 
> diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
> index 0f2680177974..a45616f0c3b0 100644
> --- a/drivers/boot_constraints/Makefile
> +++ b/drivers/boot_constraints/Makefile
> @@ -1,3 +1,3 @@
>  # Makefile for device boot constraints
>  
> -obj-y := core.o
> +obj-y := core.o supply.o
> diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
> index 366a05d6d9ba..b9c024a3bdf5 100644
> --- a/drivers/boot_constraints/core.c
> +++ b/drivers/boot_constraints/core.c
> @@ -94,6 +94,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
>  	void (*remove)(struct constraint *constraint);
>  
>  	switch (type) {
> +	case DEV_BOOT_CONSTRAINT_SUPPLY:
> +		add = constraint_supply_add;
> +		remove = constraint_supply_remove;
> +		break;
>  	default:
>  		return ERR_PTR(-EINVAL);
>  	}
> diff --git a/drivers/boot_constraints/core.h b/drivers/boot_constraints/core.h
> index 7ba4ac172c09..73b9d2d22a12 100644
> --- a/drivers/boot_constraints/core.h
> +++ b/drivers/boot_constraints/core.h
> @@ -30,4 +30,7 @@ struct constraint {
>  };
>  
>  /* Forward declarations of constraint specific callbacks */
> +int constraint_supply_add(struct constraint *constraint, void *data);
> +void constraint_supply_remove(struct constraint *constraint);
> +
>  #endif /* _CORE_H */
> diff --git a/drivers/boot_constraints/supply.c b/drivers/boot_constraints/supply.c
> new file mode 100644
> index 000000000000..30f816dbf12c
> --- /dev/null
> +++ b/drivers/boot_constraints/supply.c
> @@ -0,0 +1,98 @@
> +/*
> + * Copyright (C) 2017 Linaro.
> + * Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#define pr_fmt(fmt) "Supply Boot Constraints: " fmt

And again :)
