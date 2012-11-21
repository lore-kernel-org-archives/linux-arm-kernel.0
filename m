From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 21 Nov 2012 13:14:32 +0800
Subject: [PATCH 1/1] ARM: pxa: fix pxa25x gpio wakeup setting
In-Reply-To: <1353458245-14142-1-git-send-email-andrea.adami@gmail.com>
References: <1353458245-14142-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <CAN1soZyVHVY_xqQk8yLi0irvg3fZtkthp0K=LxJ0WHyV-bLVVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 8:37 AM, Andrea Adami <andrea.adami@gmail.com> wrote:
> * Since 3.3 gpio wakeup is broken on pxa25x (tested on corgi and poodle).
> * Use gpio_set_wake like done for pxa27x with commit id
> * b95ace54a23e2f8ebb032744cebb17c9f43bf651
>
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  arch/arm/mach-pxa/pxa25x.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index 3352b37..aeb913e 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -338,6 +338,10 @@ void __init pxa25x_map_io(void)
>         pxa25x_get_clk_frequency_khz(1);
>  }
>
> +static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
> +       .gpio_set_wake = gpio_set_wake,
> +};
> +
>  static struct platform_device *pxa25x_devices[] __initdata = {
>         &pxa25x_device_udc,
>         &pxa_device_pmu,
> @@ -370,6 +374,7 @@ static int __init pxa25x_init(void)
>                 register_syscore_ops(&pxa2xx_mfp_syscore_ops);
>                 register_syscore_ops(&pxa2xx_clock_syscore_ops);
>
> +               pxa_register_device(&pxa_device_gpio, &pxa25x_gpio_info);
>                 ret = platform_add_devices(pxa25x_devices,
>                                            ARRAY_SIZE(pxa25x_devices));
>                 if (ret)
> --
> 1.7.8.6
>

Acked & applied

Regards
Haojian
