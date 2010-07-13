From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue, 13 Jul 2010 17:24:57 +0300
Subject: [PATCH] imx: move gpio init after to irq init
In-Reply-To: <1279026162-6634-5-git-send-email-jason77.wang@gmail.com>
References: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
	<1279026162-6634-2-git-send-email-jason77.wang@gmail.com>
	<1279026162-6634-3-git-send-email-jason77.wang@gmail.com>
	<1279026162-6634-4-git-send-email-jason77.wang@gmail.com>
	<1279026162-6634-5-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100713142457.GA6727@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jul 13, Jason Wang wrote:
> The commit 9a763bf "get rid of mxc_gpio_init" changed gpio_init
> and irq_init sequence. Usually we will call set_irq_chained_handler
> in gpio_init functions, this should be called after the irq_init
> called, otherwise the chained irq can't get propoer irq_chip and this
> irq will remain masked even we called set_irq_chained_handler.
> 
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>

Acked-by: Amit Kucheria <amit.kucheria@canonical.com>

> ---
>  arch/arm/mach-imx/mm-imx1.c  |    2 +-
>  arch/arm/mach-imx/mm-imx21.c |    2 +-
>  arch/arm/mach-imx/mm-imx27.c |    2 +-
>  arch/arm/mach-mx25/mm.c      |    2 +-
>  arch/arm/mach-mx3/mm.c       |    2 +-
>  arch/arm/mach-mx5/mm.c       |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
> index 117ebf6..9be92b9 100644
> --- a/arch/arm/mach-imx/mm-imx1.c
> +++ b/arch/arm/mach-imx/mm-imx1.c
> @@ -45,6 +45,6 @@ int imx1_register_gpios(void);
>  
>  void __init mx1_init_irq(void)
>  {
> -	imx1_register_gpios();
>  	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
> +	imx1_register_gpios();
>  }
> diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
> index 68aa5d2..12faeea 100644
> --- a/arch/arm/mach-imx/mm-imx21.c
> +++ b/arch/arm/mach-imx/mm-imx21.c
> @@ -81,6 +81,6 @@ int imx21_register_gpios(void);
>  
>  void __init mx21_init_irq(void)
>  {
> -	imx21_register_gpios();
>  	mxc_init_irq(MX21_IO_ADDRESS(MX21_AVIC_BASE_ADDR));
> +	imx21_register_gpios();
>  }
> diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
> index bcedce9..a246229 100644
> --- a/arch/arm/mach-imx/mm-imx27.c
> +++ b/arch/arm/mach-imx/mm-imx27.c
> @@ -81,6 +81,6 @@ int imx27_register_gpios(void);
>  
>  void __init mx27_init_irq(void)
>  {
> -	imx27_register_gpios();
>  	mxc_init_irq(MX27_IO_ADDRESS(MX27_AVIC_BASE_ADDR));
> +	imx27_register_gpios();
>  }
> diff --git a/arch/arm/mach-mx25/mm.c b/arch/arm/mach-mx25/mm.c
> index 593e145..bb67711 100644
> --- a/arch/arm/mach-mx25/mm.c
> +++ b/arch/arm/mach-mx25/mm.c
> @@ -69,7 +69,7 @@ int imx25_register_gpios(void);
>  
>  void __init mx25_init_irq(void)
>  {
> -	imx25_register_gpios();
>  	mxc_init_irq((void __iomem *)MX25_AVIC_BASE_ADDR_VIRT);
> +	imx25_register_gpios();
>  }
>  
> diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
> index a378fba..20e48c0 100644
> --- a/arch/arm/mach-mx3/mm.c
> +++ b/arch/arm/mach-mx3/mm.c
> @@ -97,8 +97,8 @@ int imx3x_register_gpios(void);
>  
>  void __init mx31_init_irq(void)
>  {
> -	imx3x_register_gpios();
>  	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
> +	imx3x_register_gpios();
>  }
>  
>  void __init mx35_init_irq(void)
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index 2f79722..bc3f30d 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -81,6 +81,6 @@ void __init mx51_init_irq(void)
>  	if (!tzic_virt)
>  		panic("unable to map TZIC interrupt controller\n");
>  
> -	imx51_register_gpios();
>  	tzic_init_irq(tzic_virt);
> +	imx51_register_gpios();
>  }
> -- 
> 1.5.6.5
> 

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
