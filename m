From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 7 Jun 2013 11:18:40 +0800
Subject: [PATCH] ARM: prima2: fix incorrect panic usage
In-Reply-To: <1370574605-30505-1-git-send-email-haojian.zhuang@linaro.org>
References: <1370574605-30505-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAGsJ_4z8ko01ok0tstFwc9dgBn+EqJ2rnh1SgvpKRrM+TBSxTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/7 Haojian Zhuang <haojian.zhuang@linaro.org>:
> In prima2, some functions of checking DT is registered in initcall
> level. If it doesn't match the compatible name of sirf, kernel
> will panic. It blocks the usage of multiplatform on other verndor.
>
> The error message is in below.
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,255)
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 3.10.0-rc3-00006-gd7f26ea-dirty #87
> [<c0013adc>] (unwind_backtrace+0x0/0xf8) from [<c0011430>]
> (show_stack+0x10/0x1)
> [<c0011430>] (show_stack+0x10/0x14) from [<c026f724>] (panic+0x90/0x1e8)
> [<c026f724>] (panic+0x90/0x1e8) from [<c0320e44>]
> (mount_block_root+0x250/0x298)
> [<c0320e44>] (mount_block_root+0x250/0x298) from [<c0321010>]
> (prepare_namespac)
> [<c0321010>] (prepare_namespace+0x120/0x174) from [<c0320aa0>]
> (kernel_init_fre)
> [<c0320aa0>] (kernel_init_freeable+0x17c/0x1c4) from [<c026b9e8>]
> (kernel_init+)
> [<c026b9e8>] (kernel_init+0x8/0xe4) from [<c000e158>]
> (ret_from_fork+0x14/0x3c)
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

haojian, thanks.  this has been handed by:
[PATCH 0/2] ARM: multiple-platforms: fix the kernel panic on non-SiRF platforms
[PATCH 1/2] ARM:prima2: move sirfsoc_of_rstc_init to .init_machine
[PATCH 2/2] ARM:prima2:drop postcore_initcalls in pm module

> ---
>  arch/arm/mach-prima2/pm.c   | 6 ++++--
>  arch/arm/mach-prima2/rstc.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
> index 9936c18..8f595c0 100644
> --- a/arch/arm/mach-prima2/pm.c
> +++ b/arch/arm/mach-prima2/pm.c
> @@ -101,8 +101,10 @@ static int __init sirfsoc_of_pwrc_init(void)
>         struct device_node *np;
>
>         np = of_find_matching_node(NULL, pwrc_ids);
> -       if (!np)
> -               panic("unable to find compatible pwrc node in dtb\n");
> +       if (!np) {
> +               pr_err("unable to find compatible sirf pwrc node in dtb\n");
> +               return -ENOENT;
> +       }
>
>         /*
>          * pwrc behind rtciobrg is not located in memory space
> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
> index 435019c..d5e0cbc 100644
> --- a/arch/arm/mach-prima2/rstc.c
> +++ b/arch/arm/mach-prima2/rstc.c
> @@ -28,8 +28,10 @@ static int __init sirfsoc_of_rstc_init(void)
>         struct device_node *np;
>
>         np = of_find_matching_node(NULL, rstc_ids);
> -       if (!np)
> -               panic("unable to find compatible rstc node in dtb\n");
> +       if (!np) {
> +               pr_err("unable to find compatible sirf rstc node in dtb\n");
> +               return -ENOENT;
> +       }
>
>         sirfsoc_rstc_base = of_iomap(np, 0);
>         if (!sirfsoc_rstc_base)
> --
> 1.8.1.2

-barry
