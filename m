From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 18 Oct 2011 20:40:08 +0200
Subject: Warning at kernel/mutex.c
In-Reply-To: <CAOMZO5BKTzeV0f0=frQT-4uHESh2-cEQtc2UzniFT6dVSi_0EQ@mail.gmail.com>
References: <CAOMZO5AR4iiktjmjzUU3AbQmYVk4wE28+KrZckt=VXLBJzXdBA@mail.gmail.com>
	<20111018173744.GQ21648@n2100.arm.linux.org.uk>
	<CAOMZO5BKTzeV0f0=frQT-4uHESh2-cEQtc2UzniFT6dVSi_0EQ@mail.gmail.com>
Message-ID: <20111018184008.GI21504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Oct 18, 2011 at 04:33:07PM -0200, Fabio Estevam wrote:
> On Tue, Oct 18, 2011 at 3:37 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > clk_enable() shouldn't be taking a mutex because drivers can _and_ do
> > call it from non-schedulable contexts. ?Unfortunately, some clk_enable
> > implementations do use a mutex.
> >
> > We have a transition path for this, discussed quite a while ago -
> > introducing clk_prepare() to do the slow bits of enabling a clock,
> > leaving clk_enable() for the fast stuff.
> >
> 
> Thanks for the explanation, Russell.
> 
> Sascha,
> 
> Would the conversion from mutex to spinlock in clk_enable/disable work
> in the meantime?
> 
> Please see below.
> 
> OMAP/PXA/Tegra also use spinlock in clk_enable/disable.
> 
> If this is OK then I can submit a proper patch for mxc and mxs.
> 
> diff --git a/arch/arm/mach-mxs/clock.c b/arch/arm/mach-mxs/clock.c
> index a7093c8..1cdc21a 100644
> --- a/arch/arm/mach-mxs/clock.c
> +++ b/arch/arm/mach-mxs/clock.c
> @@ -42,6 +42,7 @@
> 
>  static LIST_HEAD(clocks);
>  static DEFINE_MUTEX(clocks_mutex);
> +static DEFINE_SPINLOCK(clock_lock);
If clocks_mutex is unused now, please remove it. If it's not unused you
probably introduced a problem with your patch.

Uwe
> 
>  /*-------------------------------------------------------------------------
>   * Standard clock functions defined in include/linux/clk.h
> @@ -80,13 +81,14 @@ static int __clk_enable(struct clk *clk)
>  int clk_enable(struct clk *clk)
>  {
>  	int ret = 0;
> +	unsigned long flags;
> 
>  	if (clk == NULL || IS_ERR(clk))
>  		return -EINVAL;
> 
> -	mutex_lock(&clocks_mutex);
> +	spin_lock_irqsave(&clock_lock, flags);
>  	ret = __clk_enable(clk);
> -	mutex_unlock(&clocks_mutex);
> +	spin_unlock_irqrestore(&clock_lock, flags);
> 
>  	return ret;
>  }
> @@ -98,12 +100,14 @@ EXPORT_SYMBOL(clk_enable);
>   */
>  void clk_disable(struct clk *clk)
>  {
> +	unsigned long flags;
> +
>  	if (clk == NULL || IS_ERR(clk))
>  		return;
> 
> -	mutex_lock(&clocks_mutex);
> +	spin_lock_irqsave(&clock_lock, flags);
>  	__clk_disable(clk);
> -	mutex_unlock(&clocks_mutex);
> +	spin_unlock_irqrestore(&clock_lock, flags);
>  }
>  EXPORT_SYMBOL(clk_disable);
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
