From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 11:10:56 +0000
Subject: [PATCH V3 39/63] GIC: Added dummy handlers for Power
	Management Suspend Resume
In-Reply-To: <674f9b1ab90602072d7adcd856453380ed21872b.1292833229.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<674f9b1ab90602072d7adcd856453380ed21872b.1292833229.git.viresh.kumar@st.com>
Message-ID: <20101220111056.GB28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And still this patch gets reposted a few more times despite my
objections:

http://lists.arm.linux.org.uk/lurker/message/20100920.150749.c97eda0d.en.html

On Mon, Dec 20, 2010 at 01:55:59PM +0530, Viresh Kumar wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
> 
> enable_irq_wake() has a callback for interrupt controllers.
> But since gic handler did not had this call back associated, it was always
> returning -ENXIO, which was breaking the existing drivers. This patch
> adds dummy handlers in gic in order to avoid breaking of existing drivers.
> 
> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/common/gic.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index e6388dc..f5561b7 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -193,6 +193,18 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
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
> @@ -202,6 +214,7 @@ static struct irq_chip gic_chip = {
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
