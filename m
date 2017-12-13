From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Dec 2017 10:48:40 +0100
Subject: [PATCH V4 05/12] boot_constraint: Add support for clk constraints
In-Reply-To: <fb9fb79a1486bc2ed62cfb2257db44b1498ad66e.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <fb9fb79a1486bc2ed62cfb2257db44b1498ad66e.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171213094840.GG13194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:53PM +0530, Viresh Kumar wrote:
> This patch adds the clk constraint type.
> 
> The constraint is set by enabling the clk for the device. Once the
> device is probed, the clk is disabled and the constraint is removed.
> 
> We may want to do clk_set_rate() from here, but lets wait for some real
> users that really want it.
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/boot_constraints/Makefile |  2 +-
>  drivers/boot_constraints/clk.c    | 70 +++++++++++++++++++++++++++++++++++++++
>  drivers/boot_constraints/core.c   |  4 +++
>  drivers/boot_constraints/core.h   |  3 ++
>  include/linux/boot_constraint.h   |  5 +++
>  5 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/boot_constraints/clk.c
> 
> diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
> index a45616f0c3b0..3424379fd1e4 100644
> --- a/drivers/boot_constraints/Makefile
> +++ b/drivers/boot_constraints/Makefile
> @@ -1,3 +1,3 @@
>  # Makefile for device boot constraints
>  
> -obj-y := core.o supply.o
> +obj-y := clk.o core.o supply.o
> diff --git a/drivers/boot_constraints/clk.c b/drivers/boot_constraints/clk.c
> new file mode 100644
> index 000000000000..b5b1d63c3e76
> --- /dev/null
> +++ b/drivers/boot_constraints/clk.c
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (C) 2017 Linaro.
> + * Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#define pr_fmt(fmt) "Clock Boot Constraints: " fmt

You don't use this :(
