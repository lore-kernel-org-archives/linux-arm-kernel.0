From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 11:23:23 +0100
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902102323.GP26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:09:12PM +0530, Viresh KUMAR wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
> 

The reason being?

> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/common/gic.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 7dfa9a8..e816ef1 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -201,6 +201,18 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>  	chip->unmask(irq);
>  }
>  
> +#ifdef CONFIG_PM
> +
> +static int gic_set_wake(unsigned int irq, unsigned int on)
> +{
> +	return 0;
> +}
> +
> +#else
> +
> +#define gic_set_wake NULL
> +#endif
> +
>  static struct irq_chip gic_chip = {
>  	.name		= "GIC",
>  	.ack		= gic_ack_irq,
> @@ -210,6 +222,7 @@ static struct irq_chip gic_chip = {
>  #ifdef CONFIG_SMP
>  	.set_affinity	= gic_set_cpu,
>  #endif
> +	.set_wake	= gic_set_wake,
>  };
>  
>  void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
> -- 
> 1.7.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
