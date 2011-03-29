From: khilman@ti.com (Kevin Hilman)
Date: Tue, 29 Mar 2011 10:51:22 -0700
Subject: [PATCH 04/10] omap: Make a subset of dmtimer functions into
	inline functions
In-Reply-To: <20110328222137.4046.32363.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:37 -0700")
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222137.4046.32363.stgit@baageli.muru.com>
Message-ID: <87y63xx1b9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> This will allow us to share the code between system timer and
> dmtimer device driver code without having to initialize all
> dmtimers early. It will also make the timer_set_next_event
> more efficient as the inline functions will optimize the code
> better in this case.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

[...]

> -static void omap_dm_timer_reset(struct omap_dm_timer *timer)
> +/* Assumes the source clock has been set by caller */
> +void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
> +				int wakeup)
>  {
>  	u32 l;
>  
> +	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> +	l |= 0x02 << 3;  /* Set to smart-idle mode */
> +	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
> +
> +	if (autoidle)
> +		l |= 0x1 << 0;
> +
> +	if (wakeup)
> +		l |= 1 << 2;
> +
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> +
> +	/* Match hardware reset default of posted mode */
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> +			OMAP_TIMER_CTRL_POSTED);
> +	timer->posted = 1;
> +}

The reset code is an example of something that will not be able to be
shared between a system timer driver and a real device driver.  In the
real driver, the reset (as well as smart-idle, autoidle, wakeup
capability, etc.) will all be handled by the hwmod.

With a hwmod conversion, the system timer will have to have
duplicate/alternate compared to the real timer.

Ideally, what we need is a way for the system timer to be early_init
only.  When the real driver is available, it switches to that.  This
could probably be done pretty easily by using the 'rating' field of the
clockevent so when the "real" timer driver becomes available with a
higher rating, the clockevent code would switch to it.

Kevin
